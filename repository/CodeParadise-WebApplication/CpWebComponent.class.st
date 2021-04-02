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
	The postfix 'View' will be removed from the class name, allowing names like
	'CpPersonView' to become 'cp-person' as tag name.
	The resulting name will be fully lowercase.
	Examples:
		CpWindow -> cp-window
		IconButton -> icon-button
		CpMEGALabel -> cp-mega-label
		Speciality -> x-speciality"

	<primitive: 'primitiveWebComponentTagName' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #querying }
CpWebComponent >> shadowRoot [

	"Answer the receiver's shadowRoot element or nil if the receiver does not have a shadowRoot"

	<primitive: 'primitiveWebComponentShadowRoot' module: 'CpDOMPlugin'>
	self primitiveFailed
]
