Class {
	#name : #CpWorkerBehavior,
	#superclass : #Object,
	#instVars : [
		'globalThis'
	],
	#category : #'CodeParadise-WebApplication-Core'
}

{ #category : #'class initialization' }
CpWorkerBehavior class >> beLoaded [

	CpBrowserDedicatedWorkerGlobalScope beLoaded
]

{ #category : #initialization }
CpWorkerBehavior class >> createIn: aServerEnvironment [

	<serverEnvironment>

	"Create an instance of the receiver in the specified ServerEnvironment"

	aServerEnvironment clientCreateInstanceOf: self withId: self workerId
]

{ #category : #initialization }
CpWorkerBehavior class >> installIn: aServerEnvironment [

	<serverEnvironment>

	"Install the receiver in the specified ServerEnvironment"

	aServerEnvironment addClass: self
]

{ #category : #accessing }
CpWorkerBehavior class >> workerId [

	<serverEnvironment>

	"Answer my identifier inside the ClientEnvironment"

	^ #worker
]

{ #category : #operations }
CpWorkerBehavior >> cancelAnimationFrame: anInteger [

	globalThis cancelAnimationFrame: anInteger
]

{ #category : #accessing }
CpWorkerBehavior >> clientEnvironment [

	^ CpClientEnvironment current
]

{ #category : #operations }
CpWorkerBehavior >> close [

	globalThis close
]

{ #category : #operations }
CpWorkerBehavior >> endSession [

	"End the client session"

	self clientEnvironment exit.

	globalThis terminate
]

{ #category : #initialization }
CpWorkerBehavior >> initialize [

	super initialize.

	globalThis := CpGlobalThis globalThis
]

{ #category : #'event handling' }
CpWorkerBehavior >> onMessage: aBlock [

	"Install and answer event handler for messages from Worker thread"

	^ globalThis onMessage: aBlock
]

{ #category : #operations }
CpWorkerBehavior >> postMessage: anObject [

	"Send message to the context that spawned the Worker"

	globalThis postMessage: anObject
]

{ #category : #operations }
CpWorkerBehavior >> requestAnimationFrame: aBlock [

	^ globalThis requestAnimationFrame: aBlock
]
