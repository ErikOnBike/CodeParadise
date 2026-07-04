Class {
	#name : #WaAnimation,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #'accessing - convenience' }
WaAnimation >> beNotPlay [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self play: false
]

{ #category : #'accessing - convenience' }
WaAnimation >> bePlay [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self play: true
]

{ #category : #actions }
WaAnimation >> cancel [

	"Clears all keyframe effects caused by this animation and aborts its playback."

	^ self apply: #cancel
]

{ #category : #accessing }
WaAnimation >> currentTime [

	"Gets and sets the current animation time.
	
	Type: Number (CSSNumberish)"

	^ self propertyAt: #currentTime
]

{ #category : #accessing }
WaAnimation >> currentTime: aNumber [

	"Gets and sets the current animation time.
	
	Type: Number (CSSNumberish)"

	self propertyAt: #currentTime put: aNumber
]

{ #category : #accessing }
WaAnimation >> delay [

	"The number of milliseconds to delay the start of the animation.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #delay
]

{ #category : #accessing }
WaAnimation >> delay: aNumber [

	"The number of milliseconds to delay the start of the animation.
	
	Type: Number
	Default: 0"

	self propertyAt: #delay put: aNumber
]

{ #category : #accessing }
WaAnimation >> direction [

	"Determines the direction of playback as well as the behavior when reaching the end of an iteration.
	[Learn more](https://developer.mozilla.org/en-US/docs/Web/CSS/animation-direction)
	
	Type: String (PlaybackDirection)
	Default: 'normal'"

	^ self propertyAt: #direction
]

{ #category : #accessing }
WaAnimation >> direction: aString [

	"Determines the direction of playback as well as the behavior when reaching the end of an iteration.
	[Learn more](https://developer.mozilla.org/en-US/docs/Web/CSS/animation-direction)
	
	Type: String (PlaybackDirection)
	Default: 'normal'"

	self propertyAt: #direction put: aString
]

{ #category : #accessing }
WaAnimation >> duration [

	"The number of milliseconds each iteration of the animation takes to complete.
	
	Type: Number
	Default: 1000"

	^ self propertyAt: #duration
]

{ #category : #accessing }
WaAnimation >> duration: aNumber [

	"The number of milliseconds each iteration of the animation takes to complete.
	
	Type: Number
	Default: 1000"

	self propertyAt: #duration put: aNumber
]

{ #category : #accessing }
WaAnimation >> easing [

	"The easing function to use for the animation. This can be a Web Awesome easing function or a custom easing function
	such as `cubic-bezier(0, 1, .76, 1.14)`.
	
	Type: String
	Default: 'linear'"

	^ self propertyAt: #easing
]

{ #category : #accessing }
WaAnimation >> easing: aString [

	"The easing function to use for the animation. This can be a Web Awesome easing function or a custom easing function
	such as `cubic-bezier(0, 1, .76, 1.14)`.
	
	Type: String
	Default: 'linear'"

	self propertyAt: #easing put: aString
]

{ #category : #accessing }
WaAnimation >> endDelay [

	"The number of milliseconds to delay after the active period of an animation sequence.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #endDelay
]

{ #category : #accessing }
WaAnimation >> endDelay: aNumber [

	"The number of milliseconds to delay after the active period of an animation sequence.
	
	Type: Number
	Default: 0"

	self propertyAt: #endDelay put: aNumber
]

{ #category : #accessing }
WaAnimation >> fill [

	"Sets how the animation applies styles to its target before and after its execution.
	
	Type: String (FillMode)
	Default: 'auto'"

	^ self propertyAt: #fill
]

{ #category : #accessing }
WaAnimation >> fill: aString [

	"Sets how the animation applies styles to its target before and after its execution.
	
	Type: String (FillMode)
	Default: 'auto'"

	self propertyAt: #fill put: aString
]

{ #category : #actions }
WaAnimation >> finish [

	"Sets the playback time to the end of the animation corresponding to the current playback direction."

	^ self apply: #finish
]

{ #category : #accessing }
WaAnimation >> iterationStart [

	"The offset at which to start the animation, usually between 0 (start) and 1 (end).
	
	Type: Number
	Default: 0"

	^ self propertyAt: #iterationStart
]

{ #category : #accessing }
WaAnimation >> iterationStart: aNumber [

	"The offset at which to start the animation, usually between 0 (start) and 1 (end).
	
	Type: Number
	Default: 0"

	self propertyAt: #iterationStart put: aNumber
]

{ #category : #accessing }
WaAnimation >> iterations [

	"The number of iterations to run before the animation completes. Defaults to `Infinity`, which loops.
	
	Type: Number
	Default: Float infinity"

	^ self propertyAt: #iterations
]

{ #category : #accessing }
WaAnimation >> iterations: aNumber [

	"The number of iterations to run before the animation completes. Defaults to `Infinity`, which loops.
	
	Type: Number
	Default: Float infinity"

	self propertyAt: #iterations put: aNumber
]

{ #category : #accessing }
WaAnimation >> keyframes [

	"The keyframes to use for the animation. If this is set, `name` will be ignored.
	
	Type: Array (Keyframe[] | undefined)"

	^ self propertyAt: #keyframes
]

{ #category : #accessing }
WaAnimation >> keyframes: anArray [

	"The keyframes to use for the animation. If this is set, `name` will be ignored.
	
	Type: Array (Keyframe[] | undefined)"

	self propertyAt: #keyframes put: anArray
]

{ #category : #accessing }
WaAnimation >> name [

	"The name of the built-in animation to use. For custom animations, use the `keyframes` prop.
	
	Type: String
	Default: 'none'"

	^ self propertyAt: #name
]

{ #category : #accessing }
WaAnimation >> name: aString [

	"The name of the built-in animation to use. For custom animations, use the `keyframes` prop.
	
	Type: String
	Default: 'none'"

	self propertyAt: #name put: aString
]

{ #category : #accessing }
WaAnimation >> play [

	"Plays the animation. When omitted, the animation will be paused. This attribute will be automatically removed when
	the animation finishes or gets canceled.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #play
]

{ #category : #accessing }
WaAnimation >> play: aBoolean [

	"Plays the animation. When omitted, the animation will be paused. This attribute will be automatically removed when
	the animation finishes or gets canceled.
	
	Type: Boolean
	Default: false"

	self propertyAt: #play put: aBoolean
]

{ #category : #accessing }
WaAnimation >> playbackRate [

	"Sets the animation's playback rate. The default is `1`, which plays the animation at a normal speed. Setting this
	to `2`, for example, will double the animation's speed. A negative value can be used to reverse the animation. This
	value can be changed without causing the animation to restart.
	
	Type: Number
	Default: 1"

	^ self propertyAt: #playbackRate
]

{ #category : #accessing }
WaAnimation >> playbackRate: aNumber [

	"Sets the animation's playback rate. The default is `1`, which plays the animation at a normal speed. Setting this
	to `2`, for example, will double the animation's speed. A negative value can be used to reverse the animation. This
	value can be changed without causing the animation to restart.
	
	Type: Number
	Default: 1"

	self propertyAt: #playbackRate put: aNumber
]
