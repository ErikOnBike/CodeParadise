Class {
	#name : #CpBrowserWorker,
	#superclass : #CpBrowserEventTarget,
	#category : #'CodeParadise-Browser-Support-Worker'
}

{ #category : #'instance creation' }
CpBrowserWorker class >> name: aString [

	"Answer a new Worker for the specified name.
	It is assumed this Worker will start a new CodeParadise VM and environment."

	^ self url: 'worker.js' options: (Dictionary with: #name -> aString)
]

{ #category : #'instance creation' }
CpBrowserWorker class >> url: aString [

	^ self url: aString options: nil
]

{ #category : #'instance creation' }
CpBrowserWorker class >> url: aString options: aDictionary [

	^ self newInstanceWithArguments: { aString . aDictionary }
]

{ #category : #'event handling' }
CpBrowserWorker >> onMessage: aBlock [

	"Install and answer event handler for messages from Worker thread.

	Be aware: this method receives Smalltalk objects.

	If you need to receive the raw JavaScript message event objects,
	consider using: #onRawMessage: which pairs with #postRawMessage:"

	^ self onRawMessage: [ :messageEvent |
			aBlock value: (CpObjectDecoder on: (messageEvent propertyAt: #data)) decodeNext ]
]

{ #category : #'event handling' }
CpBrowserWorker >> onRawMessage: aBlock [

	"Install and answer event handler for messages from Worker thread.

	Be aware: this method receives the raw message event object.

	If you need to receive Smalltalk objects, consider using: #onMessage:
	which pairs with #postMessage:"


	^ self
		addEventListener: #message
		handler: [ :messageEvent | aBlock value: messageEvent ]
]

{ #category : #operations }
CpBrowserWorker >> postMessage: anObject [

	"Sends a message — consisting of any JavaScript object — to the worker's inner scope.

	Be aware: We're not sending the JavaScript objects being wrapped in Smalltalk objects.
	Instead we send an encoded Smalltalk object.

	If you need to send raw JavaScript objects, please use: #postRawMessage:"

	self postRawMessage: anObject cpEncoded
]

{ #category : #operations }
CpBrowserWorker >> postRawMessage: anObject [

	"Sends a message — consisting of any JavaScript object — to the worker's inner scope.

	Be aware: Since different Smalltalk objects are wrapping JavaScript objects in CodeParadise,
	providing a Smalltalk object as parameter, will transfer the JavaScript object, but not the
	Smalltalk wrapper. A new wrapper will be created within the Worker.
	Any instance variable or other state in the Smalltalk object will therefore be lost in the
	Worker thread.

	If you need to send Smalltalk objects, please use: #postMessage:"

	self apply: #postMessage withArguments: { anObject }
]

{ #category : #operations }
CpBrowserWorker >> terminate [

	"Immediately terminates the worker. This does not let worker finish its operations; it is halted at once. ServiceWorker instances do not support this method."

	self apply: #terminate
]
