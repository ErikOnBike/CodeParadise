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
CpTemplateComponent class >> updateStyle [

	self installStyle: self style
]

{ #category : #updating }
CpTemplateComponent class >> updateStyleAndTemplate [

	self installStyle: self style andTemplate: self template 
]

{ #category : #updating }
CpTemplateComponent class >> updateTemplate [

	self installTemplate: self template
]

{ #category : #'adding/removing' }
CpTemplateComponent >> appendChild: childElement atSlotNamed: nameString [

	"Append the specified element as child of the receiver in the specified template slot"

	childElement attributeAt: #slot put: nameString.
	^ self appendChild: childElement
]

{ #category : #querying }
CpTemplateComponent >> childAtSlotNamed: nameString [

	"Answer the first child element (in document order) of the receiver
	which is located in the specified template slot or nil if no such child is present"

	^ (self childrenAtSlotNamed: nameString)
		ifNotEmpty: [ :children | children first ]
		ifEmpty: [ nil ]
]

{ #category : #querying }
CpTemplateComponent >> childrenAtSlotNamed: nameString [

	"Answer an Array with the child elements (in document order) of the receiver
	which are located in the specified template slot"

	^ self children select: [ :each | (each attributeAt: #slot) = nameString ]
]

{ #category : #'adding/removing' }
CpTemplateComponent >> insertChild: childElement before: siblingElement atSlotNamed: nameString [

	"Insert the specified element as child of the receiver before the specified sibling
	and in the specified template slot"

	childElement attributeAt: #slot put: nameString.
	^ self insertChild: childElement before: siblingElement
]

{ #category : #'adding/removing' }
CpTemplateComponent >> removeChildrenAtSlotNamed: nameString [

	"Remove all children at the specified slot name"

	self children do: [ :each |
		(each attributeAt: #slot) = nameString
			ifTrue: [ self removeChild: each ] ]
]

{ #category : #'adding/removing' }
CpTemplateComponent >> replaceChild: childElement atSlotNamed: nameString [

	"Set the specified element as child of the receiver in the specified template slot.
	Any existing children in the same slot will be removed."

	^ self
		removeChildrenAtSlotNamed: nameString ;
		appendChild: childElement atSlotNamed: nameString
]

{ #category : #'adding/removing' }
CpTemplateComponent >> replaceChild: childElement with: replacementElement atSlotNamed: nameString [

	"Replace the specified child element with the specified replacement element
	and place it in the specified template slot.
	Answer the new (replacement) child.
	An error is raised if the (original) child element is not position at specified slot."

	(childElement attributeAt: #slot) = nameString
		ifFalse: [ self error: 'Failed to replace a child element, because it is not present at the specified slot' ].
	replacementElement attributeAt: #slot put: nameString.
	^ self replaceChild: childElement with: replacementElement
]
