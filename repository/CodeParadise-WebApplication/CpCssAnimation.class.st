"
I am a Class which contains a number of CSS Animation keyframes.

Some example keyframes can be found at Fomantic-UI:
https://github.com/fomantic/Fomantic-UI/blob/develop/src/themes/default/modules/transition.overrides

Pay attention: do NOT use kebab-case naming, but camelCase naming for style elements.
So use #backgroundColor instead of #background-color.

See https://devdocs.io/dom/web_animations_api/keyframe_formats#attributes

"
Class {
	#name : 'CpCssAnimation',
	#superclass : 'Object',
	#category : 'CodeParadise-WebApplication-DOM',
	#package : 'CodeParadise-WebApplication',
	#tag : 'DOM'
}

{ #category : 'animation - keyframes' }
CpCssAnimation class >> glowKeyframes [

	^ {
		{ #backgroundColor -> '#FCFCFD'. #offset -> 0.0 } asDictionary.
		{ #backgroundColor -> '#FFF6CD'. #offset -> 0.3 } asDictionary.
		{ #backgroundColor -> '#FCFCFD'. #offset -> 1.0 } asDictionary.
	}
]

{ #category : 'animation - keyframes' }
CpCssAnimation class >> highlightKeyframes [

	"Pay attention: do not use kebab-case naming, but camelCase naming for style elements"

	^ {
		{ #backgroundColor -> 'rgba(255, 255, 255, 0)'. #easing -> #'ease-out' } asDictionary.
		{ #backgroundColor -> 'rgba(255, 255, 0, .1)' } asDictionary.
		{ #backgroundColor -> 'rgba(255, 255, 255, 0)'. #easing -> #'ease-in' } asDictionary.
	}
]

{ #category : 'instance creation' }
CpCssAnimation class >> new [

	self shouldNotImplement
]

{ #category : 'animation - keyframes' }
CpCssAnimation class >> pulseKeyframes [

	^ {
		{ #transform -> 'scale(1)'. #opacity -> 1. #offset -> 0.0 } asDictionary.
		{ #transform -> 'scale(0.9)'. #opacity -> 0.7. #offset -> 0.5 } asDictionary.
		{ #transform -> 'scale(1)'. #opacity -> 1. #offset -> 1.0 } asDictionary.
	}
]

{ #category : 'animation - keyframes' }
CpCssAnimation class >> shakeKeyframes [

	^ {
		{ #transform -> 'translateX(0)' } asDictionary.
		{ #transform -> 'translateX(-10px)' } asDictionary.
		{ #transform -> 'translateX(10px)' } asDictionary.
		{ #transform -> 'translateX(-10px)' } asDictionary.
		{ #transform -> 'translateX(10px)' } asDictionary.
		{ #transform -> 'translateX(-10px)' } asDictionary.
		{ #transform -> 'translateX(10px)' } asDictionary.
		{ #transform -> 'translateX(-10px)' } asDictionary.
		{ #transform -> 'translateX(10px)' } asDictionary.
		{ #transform -> 'translateX(-10px)' } asDictionary.
		{ #transform -> 'translateX(0px)' } asDictionary.
	}
]

{ #category : 'animation - keyframes' }
CpCssAnimation class >> showTemporarilyKeyframes [

	"Pay attention: do not use kebab-case naming, but camelCase naming for style elements"

	^ {
		{ #opacity -> '0'. #easing -> #'ease-out'. #offset -> 0 } asDictionary.
		{ #opacity -> '1'. #offset -> 0.2 } asDictionary.
		{ #opacity -> '1'. #offset -> 0.8 } asDictionary.
		{ #opacity -> '0'. #easing -> #'ease-in'. #offset -> 1 } asDictionary.
	}
]

{ #category : 'animation - keyframes' }
CpCssAnimation class >> tadaKeyframes [

	^ {
		{ #transform -> 'scale(1)' } asDictionary.
		{ #transform -> 'scale(0.9) rotate(-3deg)' } asDictionary.
		{ #transform -> 'scale(0.9) rotate(-3deg)' } asDictionary.
		{ #transform -> 'scale(1.1) rotate(3deg)' } asDictionary.
		{ #transform -> 'scale(1.1) rotate(-3deg)' } asDictionary.
		{ #transform -> 'scale(1.1) rotate(3deg)' } asDictionary.
		{ #transform -> 'scale(1.1) rotate(-3deg)' } asDictionary.
		{ #transform -> 'scale(1.1) rotate(3deg)' } asDictionary.
		{ #transform -> 'scale(1.1) rotate(-3deg)' } asDictionary.
		{ #transform -> 'scale(1.1) rotate(3deg)' } asDictionary.
		{ #transform -> 'scale(1) rotate(0)' } asDictionary
	}
]
