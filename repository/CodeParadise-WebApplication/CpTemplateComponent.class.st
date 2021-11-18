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

{ #category : #'instance creation' }
CpTemplateComponent class >> new [

	"Answer a new instance of the receiver.
	Although not allowed on the receiver or its superclasses,
	new instances of the receiver's subclasses are allowed to be created,
	because the receiver knows its own tag."

	self = CpTemplateComponent
		ifTrue: [ ^ super new ].

	^ self newWithTag: self tagName
]

{ #category : #'class initialization' }
CpTemplateComponent class >> postInstall [

	"Install the style and template of the receiver"

	super postInstall.

	self installStyle: self style andTemplate: self template
]

{ #category : #primitives }
CpTemplateComponent class >> register [

	"Register the receiver as a WebComponent class (with own style and template)"

	super register.

	self registerStyleAndTemplate
]

{ #category : #primitives }
CpTemplateComponent class >> registerStyleAndTemplate [

	"Register the receiver's style and template"

	<primitive: 'primitiveTemplateComponentRegisterStyleAndTemplate' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #updating }
CpTemplateComponent class >> renderAllInstances [

	"(Re)render all instances of the receiver"

	<primitive: 'primitiveTemplateComponentRenderAllInstances' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #'web resources' }
CpTemplateComponent class >> style [

	"Answer the style (a CSS description) of the receiver's instances"

	<webResource: #css>

	^ ''
]

{ #category : #'web resources' }
CpTemplateComponent class >> template [

	"Answer the template (a HTML description) of the receiver's instances"

	<webResource: #html>

	^ ''
]

{ #category : #updating }
CpTemplateComponent class >> updateAllInstances [

	self allInstancesDo: [ :each | each initializeShadowRoot ]
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

{ #category : #initialization }
CpTemplateComponent >> initialize [

	super initialize.

	self ensureShadowRoot.

	self initializeShadowRoot
]

{ #category : #initialization }
CpTemplateComponent >> initializeShadowRoot [ 

	"Override in subclass when desired"
]
