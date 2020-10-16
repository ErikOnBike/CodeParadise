"
I represent an Animation in the browser.

I will be activated approximately 60 times a second by the BrowserAnimator. If the browser is really busy or the page I'm running in is invisible I might not get activated. So please do not use me to keep track of time or for time critical events ;-).  (see https://developer.mozilla.org/en-US/docs/Web/API/window/requestAnimationFrame for a more thorough explanation)

I am activated by receiving a #handleTick: message. The provided argument will be the number of milliseconds I'm running since started. This value is also an approximation, because of code execution taking time. Furthermore, to allow synchronous behavior between different Animation instances all instances will receive the same 'relative' time (i.e. not taking into account that an Animation took time to execute). To allow synchronous Animations they have to be added to the BrowserAnimator using #addAnimation:inSyncWith: or #addAnimation:inSyncWith:delay: (see the comment there for further explanation).

"
Class {
	#name : #CpAnimation,
	#superclass : #Object,
	#instVars : [
		'duration',
		'block'
	],
	#category : #'CodeParadise-WebApplication-Animations'
}

{ #category : #'instance creation' }
CpAnimation class >> for: aBlock duration: anInteger [

	"Answer a new instance of the receiver with specified animation block for running specified milliseconds"

	^ self basicNew
		initialize ;
		block: aBlock ;
		duration: anInteger ;
		yourself
]

{ #category : #'instance creation' }
CpAnimation class >> new [

	self shouldNotImplement
]

{ #category : #accessing }
CpAnimation >> block [

	^ block
]

{ #category : #accessing }
CpAnimation >> block: aBlock [

	block := aBlock
]

{ #category : #accessing }
CpAnimation >> duration [

	^ duration
]

{ #category : #accessing }
CpAnimation >> duration: anInteger [

	duration := anInteger
]

{ #category : #animating }
CpAnimation >> handleTick: anInteger [

	"Handle a tick of the receiver and answer whether the receiver should keep animating.
	The specified Integer represents the number of milliseconds the animation is running.
	See the class comment for further explanation."

	self block cull: (self progressAt: anInteger).

	^ anInteger < self duration
]

{ #category : #accessing }
CpAnimation >> progressAt: anInteger [

	"Answer the progress (a value between 0.0 and 1.0, inclusive) of the receiver when
	at anInteger milliseconds into the animation.
	It is assumed anInteger will not be negative."

	^ (anInteger / self duration) min: 1.0
]
