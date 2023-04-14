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

Progress will always start at 0.0 and end with 1.0 (even if elapsed time does not fully
match that progress percentage). This allows users to make use of this fact for certain
init/exit behaviour.
Two exceptions to the above:
1. A Transition that is stopped will not reach progress 1.0 (use #finish to stop it and
   still receive progress 1.0).
2. A Transition with duration = 0 will only receive a single tick with progress 1.0.

Transitions with duration = 0 can be used to execute a certain operation in the future
using #startDelayedBy:.
"
Class {
	#name : #CpTransition,
	#superclass : #Object,
	#instVars : [
		'block',
		'duration',
		'startTick',
		'started',
		'announcer'
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
	self registerTransitionProcess: transitionProcess.

	"Start the process (which will actually put it to sleep waiting for the first tick)"
	transitionProcess resume
]

{ #category : #easing }
CpTransition class >> easeInOutBack: aFloat [

	"Algorithm taken from: https://easings.net"

	| c |

	c := 2.5949095. "1.70158 * 1.525".

	^ aFloat < 0.5
		ifTrue: [ (2 * aFloat raisedTo: 2) * ((((c + 1) * 2 * aFloat)) - c) / 2 ]
		ifFalse: [ ((2 * aFloat - 2 raisedTo: 2) * ((c + 1) * (aFloat * 2 - 2) + c) + 2) / 2 ]
]

{ #category : #easing }
CpTransition class >> easeInOutCubic: aFloat [

	"Algorithm taken from: https://easings.net"

	^ aFloat < 0.5
		ifTrue: [ 4 * (aFloat raisedTo: 3) ]
		ifFalse: [ 1 - (((-2 * aFloat + 2) raisedTo: 3) / 2) ]
]

{ #category : #easing }
CpTransition class >> easeInOutElastic: aFloat [

	"Algorithm taken from: https://easings.net"

	| c |

	c := 1.3962634015954636. "2 * Float pi / 4.5"

	(aFloat == 0.0 or: [ aFloat == 1.0 ])
		ifTrue: [ ^ aFloat ].

	^ aFloat < 0.5
		ifTrue: [ ((2 raisedTo: (20 * aFloat - 10)) * ((20 * aFloat - 11.125) * c) sin) / -2 ]
		ifFalse: [ ((2 raisedTo: (-20 * aFloat + 10)) * ((20 * aFloat - 11.125) * c) sin) / 2 + 1 ]

]

{ #category : #easing }
CpTransition class >> easeInOutSine: aFloat [

	"Algorithm taken from: https://easings.net"

	^ ((aFloat * Float pi) cos - 1) / -2
]

{ #category : #easing }
CpTransition class >> easeOutBack: aFloat [

	"Algorithm taken from: https://easings.net"

	| c1 c3 |

	c1 := 1.70158.
	c3 := c1 + 1.

	^ 1 + (c3 * (aFloat - 1 raisedTo: 3)) + (c1 * (aFloat - 1 raisedTo: 2))
]

{ #category : #easing }
CpTransition class >> easeOutSine: aFloat [

	"Algorithm taken from: https://easings.net"

	^ (aFloat * Float pi / 2) sin
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

	| currentTick finishedTransitions |

	Transitions ifEmpty: [ ^ self ].

	currentTick := self tickCount.

	"Handle all transitions keeping track which have finished"
	finishedTransitions := Transitions select: [ :each |
		each startTick
			ifNotNil: [ :startTick |
				startTick <= currentTick
					ifTrue: [
						each handleTick: currentTick - startTick.
						each startTick isNil "remove transition if finished" ]
					ifFalse: [ false "keep transition because it runs in the future" ] ]
			ifNil: [ true "remove transition because it has no start time" ] ].

	self unregisterFinishedTransitions: finishedTransitions
]

{ #category : #'class initialization' }
CpTransition class >> postInstallOnce [

	"Create transition process to perform transitions periodically"

	Transitions := OrderedCollection new.

	self createTransitionProcess

]

{ #category : #'accessing - private' }
CpTransition class >> registerTransition: aTransition [

	"Register the specified Transition for handling"

	^ Transitions add: aTransition
]

{ #category : #'processing - private' }
CpTransition class >> registerTransitionProcess: transitionProcess [

	<primitive: 'primitiveTransitionRegisterProcess:' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #accessing }
CpTransition class >> tickCount [

	<primitive: 'primitiveTransitionTickCount' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #'accessing - private' }
CpTransition class >> unregisterFinishedTransitions: finishedTransitions [

 	"Remove all transitions which have finished.
 	Use a reverse lookup for performance (typically iterating over few items)."

 	| currentTransitions index |

 	"For avoiding 'Transitions' class variable captured as nil in reverseDo: block. (Bug in SqueakJS?)"
 	currentTransitions := Transitions.
 	index := currentTransitions size.

 	finishedTransitions reverseDo: [ :each |
 		(currentTransitions lastIndexOf: each startingAt: index ifAbsent: [ nil ])
			ifNotNil: [ :foundIndex |
 				currentTransitions removeAt: foundIndex.
 				index := foundIndex min: currentTransitions size ] ]
]

{ #category : #'accessing - private' }
CpTransition class >> unregisterTransition: aTransition [

	"Unregister the specified Transition and answer it
	or answer nil if it was not registered or it has finished transitioning"

	^ Transitions remove: aTransition ifAbsent: [ nil ]
]

{ #category : #announcing }
CpTransition >> announce: anAnnouncement [

	"Announce the specified Announcement"

	"Only announce something when interest is shown in the receiver (which will have resulted
	in the creation of the Announcer"
	announcer ifNil: [ ^ self ].

	announcer announce: anAnnouncement
]

{ #category : #'accessing - private' }
CpTransition >> announcer [

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
CpTransition >> block [

	^ block
]

{ #category : #accessing }
CpTransition >> block: aBlock [

	block := aBlock
]

{ #category : #actions }
CpTransition >> delayBy: anInteger [

	"Delay the start of the receiver by the specified amount of milliseconds"

	started := false.
	startTick := self class tickCount + anInteger
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
	Progress will always start with 0.0 and end with 1.0 (both values being provided to the block).
	Progress is therefore not an accurate value for time elapsed, but assures full range is covered.
	Two exceptions: When stopped, a Transition will never reach 1.0 and on Transitions with
	duration = 0 a single tick with progress 1.0 will result.
	See the class comment for further explanation."

	started
		ifTrue: [ self block cull: (self progressAt: anInteger) cull: anInteger ]
		ifFalse: [
			"First tick should be at 0.0 (progress)"
			started := true.
			self announce: CpTransitionStarted.
			self block cull: (self progressAt: 0) cull: anInteger ].

	"Prevent further handling if the receiver has finished"
	anInteger >= self duration
		ifTrue: [
			startTick := nil.
			self announce: CpTransitionEnded ]
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

{ #category : #initialization }
CpTransition >> release [

	announcer ifNotNil: [
		announcer subscriptions reset.
		announcer := nil ].
	block := nil.

	super release
]

{ #category : #actions }
CpTransition >> start [

	"Start the receiver directly"

	^ self startDelayedBy: 0
]

{ #category : #actions }
CpTransition >> startDelayedBy: anInteger [

	"Start the receiver after the specified amount of milliseconds"

	self delayBy: anInteger.

	^ self class registerTransition: self
]

{ #category : #actions }
CpTransition >> startInSyncWith: anotherTransition [

	"Start the receiver in parallel with the specified Transition"

	^ self startInSyncWith: anotherTransition delayedBy: 0
]

{ #category : #actions }
CpTransition >> startInSyncWith: anotherTransition delayedBy: anInteger [

	"Start the receiver in sync with the specified Transition with a fixed
	number of millisconds 'distance' (before or after)."

	anotherTransition isScheduled
		ifFalse: [ ^ self error: 'Unscheduled or stopped transition given for synchronous execution' ].

	started := false.
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

{ #category : #announcing }
CpTransition >> unsubscribe: anObject [

	self announcer
		unsubscribe: anObject
]

{ #category : #announcing }
CpTransition >> when: anAnnouncement do: aBlock [

	self announcer
		when: anAnnouncement do: aBlock
]

{ #category : #announcing }
CpTransition >> when: anAnnouncement send: aSymbol to: anObject [

	self announcer
		when: anAnnouncement send: aSymbol to: anObject
]
