"
I represent an Animator inside a web browser.

I activate Animation instances at a regular interval (around 60 times a second, see CpAnimation comment for further explanation).
There can only be a single instance of me.

"
Class {
	#name : #CpBrowserAnimator,
	#superclass : #Object,
	#instVars : [
		'ticker',
		'lastTick',
		'animations'
	],
	#classVars : [
		'Current'
	],
	#category : #'CodeParadise-WebApplication-Animations'
}

{ #category : #accessing }
CpBrowserAnimator class >> current [

	"Answer the current instance of the receiver"

	^ Current ifNil: [ Current := self basicNew initialize ; yourself ]
]

{ #category : #accessing }
CpBrowserAnimator class >> new [

	"Use self >> #current instead to get the singleton instance"

	self shouldNotImplement
]

{ #category : #adding }
CpBrowserAnimator >> addAnimation: anAnimation [

	^ self addAnimation: anAnimation delay: 0
]

{ #category : #adding }
CpBrowserAnimator >> addAnimation: anAnimation delay: anInteger [

	"Add the specified Animation to the receiver and start animating after specified delay (in milliseconds)"

	animations := animations copyWith: (Array
		with: anAnimation
		with: ticker + anInteger).

	^ anAnimation
]

{ #category : #adding }
CpBrowserAnimator >> addAnimation: anAnimation inSyncWith: anotherAnimation [

	^ self addAnimation: anAnimation inSyncWith: anotherAnimation delay: 0
]

{ #category : #adding }
CpBrowserAnimator >> addAnimation: anAnimation inSyncWith: anotherAnimation delay: anInteger [

	"Add an Animation to the receiver and start animating a fixed time after anotherAnimation.
	If anotherAnimation is not registered, an error will be thrown.
	If anInteger is negative, the new animation will start before anotherAnimation."

	| animationEntry |

	animationEntry := animations
		detect: [ :each | (each at: 1) = anotherAnimation ]
		ifNone: [ ^ self error: 'Unknown animation given for synchronous execution' ].

	animations add: (Array
		with: anAnimation
		with: (animationEntry at: 2) + anInteger).

	^ anAnimation
]

{ #category : #initialization }
CpBrowserAnimator >> createAnimationProcess [

	"Create an animation process, register it and start it"

	| animationProcess |

	"Create process with high priority to handle animations fast
	(priority should be lower than event handler see CpBrowserEventHandler >> #createEventHandlerProcess)"
	animationProcess := Process
		forContext: [ [

			"Wait for next animation tick"
			Processor activeProcess suspend.

			"Handle the animations (for single tick)"
			self handleAnimations ] repeat ] asContext
		priority: Processor highIOPriority.

	"Register the event handler process so the VM (plugin) can activate it"
	self primRegisterAnimationProcess: animationProcess.

	"Start the process (which will actually put it to sleep waiting for the first tick)"
	animationProcess resume
]

{ #category : #'animation handling' }
CpBrowserAnimator >> handleAnimations [

	"Handle all annimations of the receiver (for a single tick)"

	animations := animations select: [ :each |
		| startTick |

		(startTick := each at: 2) < ticker
			ifTrue: [ (each at: 1) handleTick: ticker - startTick ]
			ifFalse: [ true "keep animations which still need to run" ] ]
]

{ #category : #initialization }
CpBrowserAnimator >> initialize [

	super initialize.

	ticker := 0.
	lastTick := 0.
	animations := Array new.

	self createAnimationProcess
]

{ #category : #primitives }
CpBrowserAnimator >> primRegisterAnimationProcess: animationProcess [

	<primitive: 'primitiveAnimatorRegisterProcess:' module: 'CpDOMPlugin'>
	self primitiveFailed

]
