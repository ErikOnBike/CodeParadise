"
I represent the JavaScript Promise class.

I do not support await as in JavaScript. The reason is that await is not actually suspending execution
(like Smalltalk Processes can), but is more a syntactic replacement for chained Promises.
Furthermore, the way CodeParadise is implemented does not play well with this asynchronous mechanism.
Browser events are the initiator for performing code. The event handler should perform its task as
quickly as possible (not waiting on some Promise to resolve). Similar for Transitions which periodically
run (as quickly as possible).
So only background Processes would/could benefit from having an await feature, because these Processes
can be suspended. Since such Processes are probably not used often and making distinction between such
Processes is probably awkward for the developer to understand, await is not supported.

See also explanation in the link below:
https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function

"
Class {
	#name : #CpJavaScriptPromise,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-JavaScript-Core'
}

{ #category : #operations }
CpJavaScriptPromise class >> all: aCollection [

	"Takes an iterable of promises as input and returns a single Promise. This returned promise fulfills when all of the input's promises fulfill (including when an empty iterable is passed), with an array of the fulfillment values. It rejects when any of the input's promises reject, with this first rejection reason."

	^ self apply: #all withArguments: { aCollection } resultAs: self
]

{ #category : #operations }
CpJavaScriptPromise class >> allSettled: aCollection [

	"Takes an iterable of promises as input and returns a single Promise. This returned promise fulfills when all of the input's promises settle (including when an empty iterable is passed), with an array of objects that describe the outcome of each promise."

	^ self apply: #allSettled withArguments: { aCollection } resultAs: self
]

{ #category : #operations }
CpJavaScriptPromise class >> any: aCollection [

	"Takes an iterable of promises as input and returns a single Promise. This returned promise fulfills when any of the input's promises fulfill, with this first fulfillment value. It rejects when all of the input's promises reject (including when an empty iterable is passed), with an AggregateError containing an array of rejection reasons."

	^ self apply: #any withArguments: { aCollection } resultAs: self
]

{ #category : #convenience }
CpJavaScriptPromise class >> on: executorBlock [

	"Answer a new instance of the receiver with the specified executor Block.
	The executor Block should accept two arguments, both of which are Blocks.
	The first argument is the resolve Block which resolves the Promise.
	The second argument is the reject Block which rejects the Promise.

	Implementation:
	Since a JavaScript Promise adds functions to perform its operations
	and these function calls perform automatic Smalltalk to JavaScript
	conversions and vice versa on the boundaries between the two, we need
	some special handling here. Otherwise this automatic conversion
	mechanism will 'undo' any explicit conversions made in Blocks which
	are required."

	^ self newInstanceWithArguments: { [ :resolveFunc :rejectFunc |
		executorBlock
			value: [ :value | resolveFunc apply: #applyPassThrough withArguments: { nil . { value } } ]
			value: [ :reason | rejectFunc apply: #applyPassThrough withArguments: { nil . { reason } } ] ] }
]

{ #category : #operations }
CpJavaScriptPromise class >> race: aCollection [

	"Takes an iterable of promises as input and returns a single Promise. This returned promise settles with the eventual state of the first promise that settles."

	^ self apply: #race withArguments: { aCollection } resultAs: self
]

{ #category : #convenience }
CpJavaScriptPromise class >> reject: anObject [

	"Answer a new instance of the receiver which will reject with the value of the specified Object
	(which can also be a Block which will then be evaluated)"

	^ self on: [ :resolveBlock :rejectBlock |
		rejectBlock value: anObject value ]
]

{ #category : #convenience }
CpJavaScriptPromise class >> resolve: anObject [

	"Answer a new instance of the receiver which will resolve with the value of the specified Object
	(which can also be a Block which will then be evaluated)"

	^ self on: [ :resolveBlock :rejectBlock |
		resolveBlock value: anObject value ]
]

{ #category : #operations }
CpJavaScriptPromise >> await [

	"Evaluate the receiver and wait for its result or signal an Error.

	Await makes the Promise become synchronous (from a Smalltalk perspective).
	This makes the Promise fulfilled result become available as regular value.
	If the receiver rejects, an UnhandledRejection will be signaled with the
	rejection reason.

	Implementation:
	Since JavaScriptFunctions are (already) performed in separate Processes,
	the thenable Block to receive the value result will execute even though
	this active Process is suspended and it will, after execution, resume the
	initial active Process to provide the result.

	See also class comments in CpJavaScriptFunction"

	| activeProcess success fulfilled rejected |

	"Keep track of original Process"
	activeProcess := Processor activeProcess.

	activeProcess allowAwaitPromise
		ifFalse: [ self error: 'Only use #await in a Process which allows waiting. Please run this code in a separate Process using ''[ ... ] fork'' or ''[ ... ] forkedOnErrorDo: [ :error | ...]''. Current Process: ', activeProcess name ].

	"The following (thenable) Block will be performed in own Process"
	self
		then: [ :value |

			"Store the fulfilled result"
			fulfilled := value.
			success := true.

			"Resume the original Process"
			activeProcess resume.

			"Use nil as result (it will be easy to convert to a JavaScript value)"
			nil ]
		onRejected: [ :reason |

			"Store the rejected result"
			rejected := reason.
			success := false.

			"Resume the original Process"
			activeProcess resume.

			"Use nil as result (it will be easy to convert to a JavaScript value)"
			nil ].

	"Stop the current Process (will be resumed by the resolve or reject Block above)"
	activeProcess suspend.

	^ success
		ifTrue: [ fulfilled ]
		ifFalse: [
			rejected isErrorObject
				ifTrue: [ rejected signal ]
				ifFalse: [ (CpUnhandledRejection reason: rejected promise: self compiledCode: (CpUnhandledRejection >> #syncMarker)) signal ] ]
]

{ #category : #operations }
CpJavaScriptPromise >> catch: aBlockOrFunction [

	"Appends a rejection handler callback to the Promise, and returns a new Promise
	resolving to the return value of the callback if it is called, or to its original
	fulfillment value if the Promise is instead fulfilled.

	This implementation unwraps the JavaScript Error and uses the underlying Smalltalk
	Error (if possible). If there is no Smalltalk Error signaled which caused this catch,
	the regular supplied reason is used. If this is unwanted behavior, please use #rawCatch:"

	aBlockOrFunction ifNil: [ self error: 'A Block or Function should be specified' ].

	aBlockOrFunction isBlock
		ifFalse: [ ^ self rawCatch: aBlockOrFunction ].

	^ self primCatch: (CpJavaScriptFunction wrap: [ :reason | aBlockOrFunction value: (self errorFromReason: reason) ])
]

{ #category : #private }
CpJavaScriptPromise >> errorFromReason: anObject [

	"Answer the Smalltalk Error which caused the rejection with the specicied reason and
	otherwise answer the reason value itself.

	Implementation:
	If a Smalltalk Error is signaled it is set as the cause of a JavaScript Error.
	See CpJavaScriptFunction class >> #wrap:

	Check if the root cause is such a Smalltalk Error and use it if so. Otherwise use
	the provided reason value."

	| rootCause |

	"If not an Error, just answer the original value"
	anObject isErrorObject
		ifFalse: [ ^ anObject ].

	"Check for a non-JavaScript error, otherwise use original value"
	rootCause := anObject rootCause.
	rootCause isJavaScriptObject
		ifTrue: [ ^ anObject ].

	"Root cause is a Smalltalk Error, answer it"
	^ rootCause
]

{ #category : #operations }
CpJavaScriptPromise >> finally: aBlockOrFunction [

	"Appends a handler to the Promise, and returns a new Promise that is resolved when
	the original Promise is resolved. The handler is called when the Promise is settled,
	whether fulfilled or rejected."

	aBlockOrFunction ifNil: [ self error: 'A Block or Function should be specified' ].

	^ self primFinally: aBlockOrFunction asJavaScriptFunction
]

{ #category : #private }
CpJavaScriptPromise >> primCatch: aBlock [

	"For safety to be able to catch all rejections (prevent unhandled rejections)"

	<primitive: 'primitiveJavaScriptPromiseCatch:' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #private }
CpJavaScriptPromise >> primFinally: aBlock [

	"For safety to be able to catch all rejections (prevent unhandled rejections)"

	<primitive: 'primitiveJavaScriptPromiseFinally:' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #private }
CpJavaScriptPromise >> primThen: fullfilledBlock onRejected: rejectBlock [

	"For safety to be able to catch all rejections (prevent unhandled rejections)"

	<primitive: 'primitiveJavaScriptPromiseThen:onRejected:' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #operations }
CpJavaScriptPromise >> rawCatch: aBlockOrFunction [

	"Appends a rejection handler callback to the Promise, and returns a new Promise
	resolving to the return value of the callback if it is called, or to its original
	fulfillment value if the Promise is instead fulfilled."

	aBlockOrFunction ifNil: [ self error: 'A Block or Function should be specified' ].

	^ self primCatch: aBlockOrFunction asJavaScriptFunction
]

{ #category : #operations }
CpJavaScriptPromise >> then: fulfilledBlock [

	^ self then: fulfilledBlock onRejected: nil
]

{ #category : #convenience }
CpJavaScriptPromise >> then: fulfilledBlock catch: rejectedBlock [

	^ (self then: fulfilledBlock) catch: rejectedBlock
]

{ #category : #operations }
CpJavaScriptPromise >> then: fulfilledBlock onRejected: rejectedBlock [

	"Appends fulfillment and rejection handlers to the promise, and returns a new promise
	resolving to the return value of the called handler, or to its original settled value
	if the promise was not handled (i.e. if the relevant handler onFulfilled or onRejected
	is not a function).

	fulfilledBlock and rejectedBlock can each be either a Block or a JavaScript Function.
	The rejectedBlock can also be nil, meaning no explicit handling of a Promise rejection.
	Same as in JavaScript, a function '(x) => { throw x; }' is then used in place of the
	missing rejectedBlock. This will propagate the error. (Hopefully there is a catch down
	the Promise chain ;-)"

	fulfilledBlock ifNil: [ self error: 'A Block or Function should be specified' ].

	^ self
		primThen: fulfilledBlock asJavaScriptFunction
		onRejected: (rejectedBlock ifNotNil: [ rejectedBlock asJavaScriptFunction ])
]

{ #category : #convenience }
CpJavaScriptPromise >> then: fulfilledBlock then: secondBlock [

	^ (self then: fulfilledBlock) then: secondBlock
]

{ #category : #convenience }
CpJavaScriptPromise >> then: fulfilledBlock then: secondBlock catch: rejectedBlock [

	^ (self then: fulfilledBlock) then: secondBlock catch: rejectedBlock
]

{ #category : #convenience }
CpJavaScriptPromise >> then: fulfilledBlock then: secondBlock then: thirdBlock [

	^ (self then: fulfilledBlock) then: secondBlock then: thirdBlock
]

{ #category : #convenience }
CpJavaScriptPromise >> then: fulfilledBlock then: secondBlock then: thirdBlock catch: rejectedBlock [

	^ (self then: fulfilledBlock) then: secondBlock then: thirdBlock catch: rejectedBlock
]

{ #category : #convenience }
CpJavaScriptPromise >> then: fulfilledBlock then: secondBlock thenAwait: thirdBlock [

	^ (self then: fulfilledBlock) then: secondBlock thenAwait: thirdBlock
]

{ #category : #convenience }
CpJavaScriptPromise >> then: fulfilledBlock thenAwait: secondBlock [

	^ (self then: fulfilledBlock) thenAwait: secondBlock
]

{ #category : #convenience }
CpJavaScriptPromise >> thenAwait: fulfilledBlock [

	^ (self then: fulfilledBlock) await
]
