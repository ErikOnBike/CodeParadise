"
I represent the JavaScript Promise class.

"
Class {
	#name : #CpJavaScriptPromise,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-RemoteEnvironment-Support'
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

{ #category : #accessing }
CpJavaScriptPromise >> catch: rejectedBlock [

	"Appends a rejection handler callback to the promise, and returns a new promise
	resolving to the return value of the callback if it is called, or to its original
	fulfillment value if the promise is instead fulfilled."

	^ self apply: #catch withArguments: { rejectedBlock } resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpJavaScriptPromise >> finally: aBlock [

	"Appends a handler to the promise, and returns a new promise that is resolved when
	the original promise is resolved. The handler is called when the promise is settled,
	whether fulfilled or rejected."

	^ self apply: #finally withArguments: { aBlock } resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpJavaScriptPromise >> then: fullfilledBlock [

	^ self then: fullfilledBlock onRejected: nil
]

{ #category : #convenience }
CpJavaScriptPromise >> then: fullfilledBlock catch: rejectedBlock [

	^ (self then: fullfilledBlock) catch: rejectedBlock
]

{ #category : #convenience }
CpJavaScriptPromise >> then: fullfilledBlock onRejected: rejectedBlock [

	"Appends fulfillment and rejection handlers to the promise, and returns a new promise
	resolving to the return value of the called handler, or to its original settled value
	if the promise was not handled (i.e. if the relevant handler onFulfilled or onRejected
	is not a function)."

	^ self apply: #then withArguments: { fullfilledBlock . rejectedBlock } resultAs: CpJavaScriptPromise
]

{ #category : #convenience }
CpJavaScriptPromise >> then: fullfilledBlock then: secondBlock catch: rejectedBlock [

	^ (self then: fullfilledBlock) then: secondBlock catch: rejectedBlock
]

{ #category : #convenience }
CpJavaScriptPromise >> then: fullfilledBlock then: secondBlock then: thirdBlock catch: rejectedBlock [

	^ (self then: fullfilledBlock) then: secondBlock then: thirdBlock catch: rejectedBlock
]
