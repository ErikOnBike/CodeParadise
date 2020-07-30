"
I am a HTML element and I represent a WebComponent aka a CustomElement.
See https://developer.mozilla.org/en-US/docs/Web/Web_Components 

I register myself with the browser so my instances can be created using a custom tag name. This tag name is based on my (class) name. See #tagName.

"
Class {
	#name : #CpWebComponent,
	#superclass : #CpHtmlElement,
	#category : #'CodeParadise-WebApplication-DOM'
}

{ #category : #'class initialization' }
CpWebComponent class >> postInstall [

	"Register the receiver as a WebComponent in the web browser"

	super postInstall.

	self register
]

{ #category : #primitives }
CpWebComponent class >> register [

	"Register the receiver as a WebComponent class"

	<primitive: 'primitiveWebComponentRegister' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #accessing }
CpWebComponent class >> tagName [

	"Answer a tag name based on the receiver's (ie class) name which will be used
	as tag for the receiver's instances inside the DOM.

	Implementation: the CamelCase naming will be replaced by dash-separated words
	and if needed prepended by 'x-', since custom tags need at least one dash.
	The resulting name will be fully lowercase.
	Examples:
		CpWindow -> cp-window
		IconButton -> icon-button
		CpMEGALabel -> cp-mega-label
		Speciality -> x-speciality"

	<primitive: 'primitiveWebComponentTagName' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #testing }
CpWebComponent >> canHandleEvents [

	"Answer whether the receiver can handle events (autonomously)"

	^ true
]

{ #category : #'event handling' }
CpWebComponent >> handleBeforeInputEvent: aBeforeInputEvent [

]

{ #category : #'event handling' }
CpWebComponent >> handleClickEvent: aClickEvent [

]

{ #category : #'event handling' }
CpWebComponent >> handleCompositionEndEvent: aCompositionEndEvent [

]

{ #category : #'event handling' }
CpWebComponent >> handleCompositionStartEvent: aCompositionStartEvent [

]

{ #category : #'event handling' }
CpWebComponent >> handleCompositionUpdateEvent: aCompositionUpdateEvent [

]

{ #category : #'event handling' }
CpWebComponent >> handleDragEvent: aDragEvent [

]

{ #category : #'event handling' }
CpWebComponent >> handleInputEvent: anInputEvent [

]

{ #category : #'event handling' }
CpWebComponent >> handleKeyDownEvent: aKeyDownEvent [

]

{ #category : #'event handling' }
CpWebComponent >> handleKeyPressEvent: aKeyPressEvent [

]

{ #category : #'event handling' }
CpWebComponent >> handleKeyUpEvent: aKeyUpEvent [

]

{ #category : #'event handling' }
CpWebComponent >> handlePointerDownEvent: aPointerDownEvent [

]

{ #category : #'event handling' }
CpWebComponent >> handlePointerMoveEvent: aPointerMoveEvent [

]

{ #category : #'event handling' }
CpWebComponent >> handlePointerUpEvent: aPointerUpEvent [

]
