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

{ #category : #converting }
CpWebComponent class >> asCssSelector [

	^ self tagName

]

{ #category : #accessing }
CpWebComponent class >> first [

	"Answer the first instance of the receiver in the current document
	or nil if none exists"

	^ self document
		firstDescendantMatching: self asCssSelector
]

{ #category : #primitives }
CpWebComponent class >> isRegistered: aString [

	"Answer whether the specified tag name (a String) is registered as a WebComponent in the browser
	(relevant for external WebComponent libraries)"

	<primitive: 'primitiveWebComponentIsRegistered:' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #accessing }
CpWebComponent class >> last [

	"Answer the last instance of the receiver in the current document
	or nil if none exists"

	^ (self document allDescendantsMatching: self asCssSelector)
		ifNotEmpty: [ :matches | matches last ]
		ifEmpty: [ nil ]
]

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

{ #category : #'adding/removing' }
CpWebComponent >> appendChild: childElement atSlotNamed: nameString [

	"Append the specified element as child of the receiver in the specified template slot"

	childElement slot: nameString.
	^ self appendChild: childElement
]

{ #category : #querying }
CpWebComponent >> childrenAtSlotNamed: nameString [

	"Answer an Array with the child elements (in document order) of the receiver
	which are located in the specified template slot"

	^ self children select: [ :each | each slot = nameString ]
]

{ #category : #querying }
CpWebComponent >> firstChildAtSlotNamed: nameString [

	"Answer the first child element (in document order) of the receiver
	which is located in the specified template slot or nil if no such child is present"

	^ (self childrenAtSlotNamed: nameString)
		ifNotEmpty: [ :children | children first ]
		ifEmpty: [ nil ]
]

{ #category : #'adding/removing' }
CpWebComponent >> insertChild: childElement before: siblingElement atSlotNamed: nameString [

	"Insert the specified element as child of the receiver before the specified sibling
	and in the specified template slot"

	childElement slot: nameString.
	^ self insertChild: childElement before: siblingElement
]

{ #category : #'adding/removing' }
CpWebComponent >> removeChildrenAtSlotNamed: nameString [

	"Remove all children at the specified slot name"

	self children do: [ :each |
		each slot = nameString
			ifTrue: [ self removeChild: each ] ]
]

{ #category : #'adding/removing' }
CpWebComponent >> replaceAllChildrenWith: childElement atSlotNamed: nameString [

	"Set the specified element as child of the receiver in the specified template slot.
	Any existing children in the same slot will be removed."

	^ self
		removeChildrenAtSlotNamed: nameString ;
		appendChild: childElement atSlotNamed: nameString
]

{ #category : #'adding/removing' }
CpWebComponent >> replaceChild: childElement with: replacementElement atSlotNamed: nameString [

	"Replace the specified child element with the specified replacement element
	and place it in the specified template slot.
	Answer the new (replacement) child.
	An error is raised if the (original) child element is not positioned at specified slot."

	childElement slot = nameString
		ifFalse: [ self error: 'Failed to replace a child element, because it is not present at the specified slot' ].
	replacementElement slot: nameString.
	^ self replaceChild: childElement with: replacementElement
]

{ #category : #'adding/removing' }
CpWebComponent >> replaceChildAtIndex: anInteger with: replacementElement atSlotNamed: nameString [

	"Replace the child at the specified location with the specified replacement element
	and place it in the specified template slot.
	Answer the new (replacement) child.
	An error is raised if the specified location is not used."

	| childElement |

	childElement := (self childrenAtSlotNamed: nameString) at: anInteger ifAbsent: [ self error: 'No child present at specified location' ].

	^ self replaceChild: childElement with: replacementElement atSlotNamed: nameString
]

{ #category : #querying }
CpWebComponent >> shadowRoot [

	"Answer the receiver's shadowRoot element or nil if the receiver does not have a shadowRoot"

	<primitive: 'primitiveWebComponentShadowRoot' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #querying }
CpWebComponent >> shadowedAllDescendantsMatching: cssSelectorString [

	"Answer all elements inside the shadow DOM matching the specified CSS selector"

	^ self shadowRoot firstDescendantMatching: cssSelectorString
]

{ #category : #querying }
CpWebComponent >> shadowedElementWithId: aString [

	"Answer the element inside the shadow DOM having the specified id"

	^ self shadowRoot elementWithId: aString
]

{ #category : #querying }
CpWebComponent >> shadowedFirstDescendantMatching: cssSelectorString [

	"Answer the first element inside the shadow DOM matching the specified CSS selector"

	^ self shadowRoot firstDescendantMatching: cssSelectorString
]
