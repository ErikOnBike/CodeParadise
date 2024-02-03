"
I represent the JavaScript Promise class.

"
Class {
	#name : #CpJavaScriptPromise,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

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
CpJavaScriptPromise >> then: fullfilledBlock onRejected: rejectedBlock [

	"Appends fulfillment and rejection handlers to the promise, and returns a new promise
	resolving to the return value of the called handler, or to its original settled value
	if the promise was not handled (i.e. if the relevant handler onFulfilled or onRejected
	is not a function)."

	^ self apply: #then withArguments: { fullfilledBlock . rejectedBlock } resultAs: CpJavaScriptPromise
]
