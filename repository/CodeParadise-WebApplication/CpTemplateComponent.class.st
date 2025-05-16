"
I am a template based WebComponent.
See https://developer.mozilla.org/en-US/docs/Web/Web_Components/Using_templates_and_slots

I have a style and a template describing the visual appearance of my instances. My style is described using CSS and my template is described using HTML. I do support both named slots as well as a default (unnamed) slot.

My subclasses can, contrary to my superclasses, be instantiated directly because my subclasses represent specific variants of TemplateComponents.

"
Class {
	#name : #CpTemplateComponent,
	#superclass : #CpWebComponent,
	#category : #'CodeParadise-WebApplication-DOM'
}

{ #category : #'web resources' }
CpTemplateComponent class >> globalStyle [

	"Answer the style (a CSS description) to support the receiver's instances from the light DOM
	(instead of the shadow DOM like #style does)"

	<webResource: #css>

	^ ''
]

{ #category : #private }
CpTemplateComponent class >> initializeMarkupCreatedInstance: aCreatedFromMarkupEvent [

	"Initialize the element (detail in the specified event) which was created through markup content
	instead of Smalltalk code"

	aCreatedFromMarkupEvent detail initialize
]

{ #category : #updating }
CpTemplateComponent class >> installGlobalStyle [

	"Install the global (light DOM) style for the instances of the receiver"

	self updateGlobalStyle
]

{ #category : #updating }
CpTemplateComponent class >> installStyle: styleString [

	"Install the specified style in the receiver, rerendering all instances"

	<primitive: 'primitiveTemplateComponentInstallStyle:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #updating }
CpTemplateComponent class >> installStyle: styleString andTemplate: templateString [

	"Convenience method to install both style and template with single rerendering of all instances"

	<primitive: 'primitiveTemplateComponentInstallStyle:andTemplate:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #updating }
CpTemplateComponent class >> installTemplate: templateString [

	"Install the specified template in the receiver, rerendering all instances"

	<primitive: 'primitiveTemplateComponentInstallTemplate:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #tags }
CpTemplateComponent class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #primitives }
CpTemplateComponent class >> registerStyleAndTemplate [

	"Register the receiver's style and template"

	<primitive: 'primitiveTemplateComponentRegisterStyleAndTemplate' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #'class initialization' }
CpTemplateComponent class >> registerWithInitialize: initializeBoolean thirdParty: thirdPartyBoolean [

	"Register the receiver as a WebComponent class (with own style and template)
	and then install style and template"

	super registerWithInitialize: initializeBoolean thirdParty: thirdPartyBoolean.

	self
		installStyle: self style andTemplate: self template ;
		installGlobalStyle
]

{ #category : #updating }
CpTemplateComponent class >> renderAllInstances [

	"(Re)render all instances of the receiver"

	<primitive: 'primitiveTemplateComponentRenderAllInstances' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #'web resources' }
CpTemplateComponent class >> style [

	"Answer the style (a CSS description) of the receiver's instances
	(as applies to the shadow DOM and/or slotted elements through ::slotted(),
	to set some supporting CSS in the light DOM, please use #globalStyle)"

	<webResource: #css>

	^ '*, *:before, *:after {
	box-sizing: border-box;
}'
]

{ #category : #'web resources' }
CpTemplateComponent class >> template [

	"Answer the template (a HTML description) of the receiver's instances"

	<webResource: #html>

	^ '<slot></slot>'
]

{ #category : #updating }
CpTemplateComponent class >> updateAllInstances [

	"Update all instances.

	Implementation:
	This uses a full DOM tree (incl. Shadow DOM) traversal. Please use with care.
	It should preferrably only be used during development and not in production."

	CpHtmlElement documentBody allElementsDo: [ :each |
		each class == self
			ifTrue: [ each initializeShadowRoot ] ]
]

{ #category : #updating }
CpTemplateComponent class >> updateGlobalStyle [

	"Install or update the global (light DOM) style for the instances of the receiver"

	self updateGlobalStyleUsing: self globalStyle
]

{ #category : #updating }
CpTemplateComponent class >> updateGlobalStyleUsing: aString [

	"Install or update the global (light DOM) style for the instances of the receiver using the
	specified String.

	Implementation:
	A <style> tag is added or updated with the current global style (as described in #globalStyle).
	The method can therefore be called multiple times to update the global style as well (without
	adding unnecessary DOM elements)."

	| cssIdentifier |

	cssIdentifier := 'global-css-', self tagName.

	(CpHtmlElement documentHead firstDescendantMatching: '#', cssIdentifier)
		ifNotNil: [ :styleElement |
			aString
				ifNotEmpty: [ styleElement textContent: aString ]
				ifEmpty: [ styleElement remove ] ]
		ifNil: [
			aString
				ifNotEmpty: [
					(CpHtmlElement documentAddStyle: aString)
						id: cssIdentifier ] ]
]

{ #category : #updating }
CpTemplateComponent class >> updateStyle [

	self installStyle: self style.

	self updateAllInstances
]

{ #category : #updating }
CpTemplateComponent class >> updateTemplate [

	self installTemplate: self template.

	self updateAllInstances
]

{ #category : #initialization }
CpTemplateComponent >> ensureShadowRoot [

	"Ensure the ShadowRoot is present.
	This is required, because nested WebComponents are initialized through asynchronous callbacks."

	<primitive: 'primitiveTemplateComponentEnsureShadowRoot' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #testing }
CpTemplateComponent >> hasTemplate [

	^ true
]

{ #category : #initialization }
CpTemplateComponent >> initialize [

	super initialize.

	self
		ensureShadowRoot ;
		initializeShadowRoot
]

{ #category : #initialization }
CpTemplateComponent >> initializeShadowRoot [ 

	"Override in subclass when desired"
]
