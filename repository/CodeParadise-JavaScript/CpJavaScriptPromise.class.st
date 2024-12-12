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

{ #category : #convenience }
CpJavaScriptPromise class >> resolve: aBlock [

	"Answer a new instance of the receiver using only a resolve (and not a reject) Block"

	^ self on: [ :resolveBlock :rejectBlock |
		resolveBlock value: aBlock value ]
]

{ #category : #operations }
CpJavaScriptPromise >> catch: aBlockOrFunction [

	"Appends a rejection handler callback to the promise, and returns a new promise
	resolving to the return value of the callback if it is called, or to its original
	fulfillment value if the promise is instead fulfilled.

	This implementation unwraps the JavaScript Error and uses the underlying Smalltalk
	Error (if possible). If there is no Smalltalk Error (signaled) causing this catch,
	the regular JavaScript Error is used. If this is unwanted behavior, please use
	#rawCatch:"

	aBlockOrFunction ifNil: [ self error: 'A Block or Function should be specified' ].

	aBlockOrFunction isBlock
		ifFalse: [ ^ self rawCatch: aBlockOrFunction ].

	^ self
		apply: #catch
		withArguments: { CpJavaScriptFunction wrap: [ :error |
			| rootCause |
			rootCause := error rootCause.
			aBlockOrFunction value: (rootCause isJavaScriptObject
				ifTrue: [ error ]
				ifFalse: [ rootCause ]) ] }
		resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpJavaScriptPromise >> finally: aBlockOrFunction [

	"Appends a handler to the promise, and returns a new promise that is resolved when
	the original promise is resolved. The handler is called when the promise is settled,
	whether fulfilled or rejected."

	aBlockOrFunction ifNil: [ self error: 'A Block or Function should be specified' ].

	^ self apply: #finally withArguments: { aBlockOrFunction asJavaScriptFunction } resultAs: CpJavaScriptPromise
]

{ #category : #private }
CpJavaScriptPromise >> rawCatch: aBlockOrFunction [

	"Appends a rejection handler callback to the promise, and returns a new promise
	resolving to the return value of the callback if it is called, or to its original
	fulfillment value if the promise is instead fulfilled."

	aBlockOrFunction ifNil: [ self error: 'A Block or Function should be specified' ].

	^ self apply: #catch withArguments: { aBlockOrFunction asJavaScriptFunction } resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpJavaScriptPromise >> then: fullfilledBlock [

	^ self then: fullfilledBlock onRejected: nil
]

{ #category : #convenience }
CpJavaScriptPromise >> then: fullfilledBlock catch: rejectedBlock [

	^ (self then: fullfilledBlock) catch: rejectedBlock
]

{ #category : #operations }
CpJavaScriptPromise >> then: fullfilledBlock onRejected: rejectedBlock [

	"Appends fulfillment and rejection handlers to the promise, and returns a new promise
	resolving to the return value of the called handler, or to its original settled value
	if the promise was not handled (i.e. if the relevant handler onFulfilled or onRejected
	is not a function).

	fullfilledBlock and rejectedBlock can each be either a Block or a JavaScript Function.
	The rejectedBlock can also be nil, meaning no handling of a Promise rejection."

	fullfilledBlock ifNil: [ self error: 'A Block or Function should be specified' ].

	^ self
		apply: #then
		withArguments: {
			fullfilledBlock asJavaScriptFunction.
			rejectedBlock ifNotNil: [ rejectedBlock asJavaScriptFunction ] }
		resultAs: CpJavaScriptPromise
]

{ #category : #convenience }
CpJavaScriptPromise >> then: fullfilledBlock then: secondBlock catch: rejectedBlock [

	^ (self then: fullfilledBlock) then: secondBlock catch: rejectedBlock
]

{ #category : #convenience }
CpJavaScriptPromise >> then: fullfilledBlock then: secondBlock then: thirdBlock catch: rejectedBlock [

	^ (self then: fullfilledBlock) then: secondBlock then: thirdBlock catch: rejectedBlock
]
