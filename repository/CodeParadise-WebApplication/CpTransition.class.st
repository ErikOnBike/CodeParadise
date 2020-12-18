"
I represent a transition in time. I have a duration and a Block which gets executed
on average 60 times a second (but on high load this could be less). Such execution
is called handling a 'tick'. I can be used to create animations.

A duration of 0 is allowed which will indicate a transition which will receive a
single tick.

My instances can be started directly or with a delay (specified in milliseconds),
possibly in sync with other transitions. This allows both fully synchronous as well
as cascading transitions.

Transitions can be stopped or (prematurely) finished. The latter will perform one
last tick to perform the final transition behavior.

The Block of a Transition will receive two optional parameters: the progress (a Float
value between 0.0 and 1.0) and the number of milliseconds which have passed since the
start of the transition.
"
Class {
	#name : #CpTransition,
	#superclass : #Object,
	#instVars : [
		'block',
		'duration',
		'startTick'
	],
	#classVars : [
		'Transitions'
	],
	#category : #'CodeParadise-WebApplication-Transitions'
}

{ #category : #'processing - private' }
CpTransition class >> createTransitionProcess [

	"Create a transition process, register it and start it"

	| transitionProcess |

	"Create process with high priority to perform transitions fast
	(priority should be lower than event handler see CpEvent class >> #createEventProcess)"
	transitionProcess := Process
		forContext: [ [

			"Wait for next transition tick"
			Processor activeProcess suspend.

			"Perform the transitions (for single tick)"
			self performTransitions ] repeat ] asContext
		priority: Processor highIOPriority.

	"Register the transition process so the VM (plugin) can activate it"
	self primRegisterTransitionProcess: transitionProcess.

	"Start the process (which will actually put it to sleep waiting for the first tick)"
	transitionProcess resume
]

{ #category : #'accessing - private' }
CpTransition class >> isRegisteredTransition: aTransition [

	"Answer whether the specified Transition is being handled"

	^ Transitions includes: aTransition
]

{ #category : #'instance creation' }
CpTransition class >> new [

	"Transitions should not be instantiated without a block.
	See #onBlock: to create instances."

	self shouldNotImplement
]

{ #category : #'instance creation' }
CpTransition class >> onBlock: aBlock [

	"Answer a new instance of the receiver with specified trasition block"

	^ self basicNew
		initialize ;
		block: aBlock ;
		yourself
]

{ #category : #'processing - private' }
CpTransition class >> performTransitions [

	"Handle 'ticking' all transitions of the receiver"

	| currentTick |

	currentTick := self tickCount.

	"Handle all transitions, but only keep the ones needing future handling"
	Transitions := Transitions select: [ :each |

		each startTick
			ifNotNil: [ :startTick |
				each handleTick: currentTick - startTick.
				each startTick notNil "remove transition if finished" ]
			ifNil: [ false "remove transition because it has no start time" ] ]

]

{ #category : #'class initialization' }
CpTransition class >> postInstall [

	super postInstall.

	Transitions := OrderedCollection new.

	self == CpTransition
		ifTrue: [ self createTransitionProcess ]

]

{ #category : #'processing - private' }
CpTransition class >> primRegisterTransitionProcess: transitionProcess [

	<primitive: 'primitiveTransitionRegisterProcess:' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #'accessing - private' }
CpTransition class >> registerTransition: aTransition [

	"Register the specified Transition for handling"

	^ Transitions add: aTransition
]

{ #category : #accessing }
CpTransition class >> tickCount [

	<primitive: 'primitiveTransitionTickCount' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #'accessing - private' }
CpTransition class >> unregisterTransition: aTransition [

	"Unregister the specified Transition and answer it
	or answer nil if it was not registered or it has finished transitioning"

	^ Transitions remove: aTransition ifAbsent: [ nil ]
]

{ #category : #accessing }
CpTransition >> block [

	^ block
]

{ #category : #accessing }
CpTransition >> block: aBlock [

	block := aBlock
]

{ #category : #accessing }
CpTransition >> duration [

	^ duration
]

{ #category : #accessing }
CpTransition >> duration: anInteger [

	"Set the duration in milliseconds (must be non negative)"

	duration := anInteger
]

{ #category : #actions }
CpTransition >> finish [

	"Finish the receiver (possibly premature).
	This will simulate the effect of the Transition reaching its end."

	self isRunning
		ifFalse: [ ^ self ].

	self
		stop ;
		handleTick: self duration
]

{ #category : #transitioning }
CpTransition >> handleTick: anInteger [

	"Handle a tick of the receiver.
	The specified Integer represents the number of milliseconds the transition is running.
	See the class comment for further explanation."

	self block cull: (self progressAt: anInteger) cull: anInteger.

	"Prevent further handling if the receiver has finished"
	anInteger >= self duration
		ifTrue: [ startTick := nil ]

]

{ #category : #initialization }
CpTransition >> initialize [

	super initialize.

	duration := 0
]

{ #category : #testing }
CpTransition >> isRunning [

	"Answer whether the receiver is running (is being handled).

	Implementation: The receiver's startTick might have become nil
	although still registered, therefore perform additional check."

	^ (self class isRegisteredTransition: self) and: [
		self startTick
			ifNotNil: [ :tick | tick >= self class tickCount ]
			ifNil: [ false ] ]
]

{ #category : #testing }
CpTransition >> isScheduled [

	"Answer whether the receiver is scheduled for handling"

	^ self startTick notNil
]

{ #category : #accessing }
CpTransition >> progressAt: anInteger [

	"Answer the progress (a value between 0.0 and 1.0, inclusive) of the receiver when
	at anInteger milliseconds into the transition.
	It is assumed anInteger will not be negative."

	"A transition with duration 0 will receive a single tick"
	self duration = 0
		ifTrue: [ ^ 1.0 ].

	^ (anInteger / self duration) min: 1.0
]

{ #category : #actions }
CpTransition >> start [

	^ self startDelayedBy: 0
]

{ #category : #actions }
CpTransition >> startDelayedBy: anInteger [

	startTick := self class tickCount + anInteger.

	^ self class registerTransition: self
]

{ #category : #actions }
CpTransition >> startInSyncWith: anotherTransition [

	^ self startInSyncWith: anotherTransition delayedBy: 0
]

{ #category : #actions }
CpTransition >> startInSyncWith: anotherTransition delayedBy: anInteger [

	anotherTransition isScheduled
		ifFalse: [ ^ self error: 'Unscheduled or stopped transition given for synchronous execution' ].

	startTick := anotherTransition startTick + anInteger.

	^ self class registerTransition: self
]

{ #category : #'accessing - private' }
CpTransition >> startTick [

	^ startTick
]

{ #category : #actions }
CpTransition >> stop [

	"Stop the receiver without further handling"

	startTick := nil.
	self class unregisterTransition: self
]
