Class {
	#name : #CpBrowserDedicatedWorkerGlobalScope,
	#superclass : #CpBrowserWorkerGlobalScope,
	#category : #'CodeParadise-Browser-Support-Worker'
}

{ #category : #operations }
CpBrowserDedicatedWorkerGlobalScope >> cancelAnimationFrame: anInteger [

	"Cancels an animation frame request previously scheduled through a call to requestAnimationFrame()."

	self apply: #cancelAnimationFrame withArguments: { anInteger }
]

{ #category : #'initialize-release' }
CpBrowserDedicatedWorkerGlobalScope >> close [

	"Discards any tasks queued in the WorkerGlobalScope's event loop, effectively closing this particular scope."

	self apply: #close
]

{ #category : #'event handling' }
CpBrowserDedicatedWorkerGlobalScope >> onMessage: aBlock [

	"Install and answer event handler for messages from the context that spawned the Worker.

	Be aware: this method receives Smalltalk objects.

	If you need to receive the raw JavaScript message event objects,
	consider using: #onRawMessage: which pairs with #postRawMessage:"

	^ self onRawMessage: [ :messageEvent |
			aBlock value: (CpObjectDecoder on: (messageEvent propertyAt: #data)) decodeNext ]
]

{ #category : #'event handling' }
CpBrowserDedicatedWorkerGlobalScope >> onRawMessage: aBlock [

	"Install and answer event handler for messages from the context that spawned the Worker.

	Be aware: this method receives the raw message event object.

	If you need to receive Smalltalk objects, consider using: #onMessage:
	which pairs with #postMessage:"


	^ self
		addEventListener: #message
		handler: [ :messageEvent | aBlock value: messageEvent ]
]

{ #category : #operations }
CpBrowserDedicatedWorkerGlobalScope >> postMessage: anObject [

	"Send message to the context that spawned the Worker.

	Be aware: We're not sending the JavaScript objects being wrapped in Smalltalk objects.
	Instead we send an encoded Smalltalk object.

	If you need to send raw JavaScript objects, please use: #postRawMessage:"

	self postRawMessage: anObject cpEncoded
]

{ #category : #operations }
CpBrowserDedicatedWorkerGlobalScope >> postRawMessage: anObject [

	"Send message to the context that spawned the Worker.

	Be aware: Since different Smalltalk objects are wrapping JavaScript objects in CodeParadise,
	providing a Smalltalk object as parameter, will transfer the JavaScript object, but not the
	Smalltalk wrapper. A new wrapper will be created within the Worker.
	Any instance variable or other state in the Smalltalk object will therefore be lost in the
	Worker thread.

	If you need to send Smalltalk objects, please use: #postMessage:"

	self apply: #postMessage withArguments: { anObject }
]

{ #category : #operations }
CpBrowserDedicatedWorkerGlobalScope >> requestAnimationFrame: aBlock [

	"Perform an animation frame request and call a user-supplied callback function before the next repaint."

	^ self apply: #requestAnimationFrame withArguments: { aBlock asJavaScriptFunction }
]
