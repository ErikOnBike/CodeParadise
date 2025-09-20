"
I am a DOM Updater based on a HTML Template.
I am responsible for creating or updating DOM subtrees based on a HTML template (i.e. <template>)
and some data provided in a Dictionary like object. The data object only needs to understand the
message: #at:ifAbsent:

IMPORTANT: Do NOT update the result of the DOM Updater manually. It will likely change the position
of Nodes in the created DOM subtree and therefore make the updater incorrectly update other parts of
the DOM.
Also be careful not to use any libraries which do this.

Currently a limited set of data updates is possible:
- textContent: replace textContent inside the DOM subtree with the text from the data
- attribute content: replace the attribute value in a HTML element with the text from the data
- class toggling: toggle a class on or off based on a Boolean value from the data
- set style: set a value from the data as style in a HTML element
- set property: set a value from the data as property of a HTML element

Examples of the above (in order):
<template><h1>{{text}}</h1></template>
<template><h1 title=""{{title}}"">My header</h1></template>
<template><h1 classed-hide=""{{isHidden}}"">My header</h1></template>
<template><h1 style-display=""{{styleDisplay}}"">My header</h1></template>
<template><input id=""accept"" type=""checkbox"" property-checked=""{{isChecked}}""><label for=""accept"">Accept consequences?</label></template>

In the last 3 items, the attribute name consists of a 'type' and a reference to some class, style,
property respectively. ""style-display"" refers to the ""display"" style. ""property-checked"" refers
to the ""checked"" property. Etc.

Implementation:
The DomUpdater does not use the standard CpDomElement methods to iterate over templates and elements.
The CpDomElement and children are focussed on Elements and ignore Nodes (mostly). For many situations
this is perfectly fine. The DomUpdater tries to be a little more forgiving and allows for example text
Nodes around an Element (instead of only within an Element). In the strict form of CpDomElement, text
content can only be present inside an Element if there are no other Elements present inside that
Element. Or to put it differently, an Element has either text content or one or more Elements (but not
both). This stricter model is easier to navigate and update. In HTML there is a need for both Nodes and
Elements to allow this less strict form to be implemented. In XML this less strict form is called the
""Mixed Content"" mode.

The DomUpdater will scan the provided template element in create an internal mapping of keys to Nodes.
When creating or updating a DOM subtree (using some provided data) this mapping will be used to update
only relevant parts of the DOM subree and not fully recreate everything.
"
Class {
	#name : #CpTemplateBasedDomUpdater,
	#superclass : #Object,
	#instVars : [
		'element',
		'template',
		'mapping'
	],
	#category : #'CodeParadise-WebApplication-Support'
}

{ #category : #'instance creation' }
CpTemplateBasedDomUpdater class >> new [

	self errorNewReplacedBy: #on:
]

{ #category : #'instance creation' }
CpTemplateBasedDomUpdater class >> on: anElement [

	"Create a new instance of the receiver on the HTML template element specified"

	^ self basicNew
		initializeWithElement: anElement ;
		yourself
]

{ #category : #private }
CpTemplateBasedDomUpdater >> childNodesOf: aNode [

	"Answer a collection of child Nodes for the specified Node.
	In contrast with default Node behaviour, include attribute Nodes
	as well.
	Do NOT change the order in which Nodes are added. It is relied
	upon by the render methods: first attributes, then children.
	This is relevant for the #firstChildNodeOf: method."

	| nodeCollection attributes attr childNodes childNode index |

	nodeCollection := OrderedCollection new.

	"Collect attributes on an Element"
	(aNode propertyAt: #nodeType) = 1
		ifTrue: [
			attributes := aNode propertyAt: #attributes.
			index := 0.
			[ (attr := attributes apply: #item withArguments: { index }) isNotNil ] whileTrue: [
				nodeCollection add: attr.
				index := index + 1 ] ].

	"Collect other child nodes"
	childNodes := aNode propertyAt: #childNodes.
	index := 0.
	[ (childNode := childNodes apply: #item withArguments: { index }) isNotNil ] whileTrue: [
		nodeCollection add: childNode.
		index := index + 1 ].

	^ nodeCollection
]

{ #category : #rendering }
CpTemplateBasedDomUpdater >> createDomFor: aDictionary in: aNode before: aChildNode [

	"Create a new DOM subtree for the specified (Dictionary like) object.
	The subtree will be inserted in the specified Node at the specified
	location (before the child Node or at the end if nil is provided as
	the child Node's value)."

	| subtree newNode refNode prevNode |

	self prepare.

	"Create a new DOM subtree (will always have a <div> as parent)"
	subtree := template apply: #cloneNode withArguments: { true }.

	"Render data onto the subtree"
	self renderData: aDictionary on: (subtree propertyAt: #firstChild).

	"Move subtree into final position.
	To ensure correct order (also when aChildNode is nil) always
	insert from last to first subtree child and use the previous
	inserted element as reference point (except for first one which
	is specified explicitly by caller)."
	refNode := aChildNode.
	newNode := subtree propertyAt: #lastChild.
	[ newNode isNotNil ] whileTrue: [
		"Get the previous Node before the Node is moved and this info is lost"
		prevNode := newNode propertyAt: #previousSibling.
		aNode apply: #insertBefore withArguments: { newNode . refNode }.
		refNode := newNode.
		newNode := prevNode ]
]

{ #category : #private }
CpTemplateBasedDomUpdater >> createTemplate [

	"Create a new DOM subtree with the template element's content.
	All content is wrapped in a single <div> element for convenience.
	This allows a template with multiple children to be respresented
	by a single element."

	| childNodes index childNode |

	"Start with empty <div>"
	template := CpHtmlElement newWithTag: #div.

	"Copy Nodes child by child"
	childNodes := (element propertyAt: #content) propertyAt: #childNodes.
	index := 0.
	[ (childNode := childNodes apply: #item withArguments: { index }) isNotNil ] whileTrue: [

		"Deep clone child node"
		template apply: #appendChild withArguments: { childNode apply: #cloneNode withArguments: { true } }.
		index := index + 1 ]
]

{ #category : #private }
CpTemplateBasedDomUpdater >> firstChildNodeOf: aNode [

	"Answer the first child Node of the specified Node.
	In contrast with default Node behaviour, include attribute Nodes
	as well.
	See also #childNodesOf:"

	| attributes attr childNodes |

	"Try attributes on an Element"
	(aNode propertyAt: #nodeType) = 1
		ifTrue: [
			attributes := aNode propertyAt: #attributes.
			(attr := attributes apply: #item withArguments: { 0 }) ifNotNil: [
				^ attr ] ].

	"Try other child nodes"
	childNodes := aNode propertyAt: #childNodes.
	^ childNodes apply: #item withArguments: { 0 }
]

{ #category : #initialization }
CpTemplateBasedDomUpdater >> initializeWithElement: anElement [

	self initialize.

	element := anElement
]

{ #category : #private }
CpTemplateBasedDomUpdater >> nodeIn: aNode atPath: anArray [

	"Find the Node at the specified location from the given Node.
	The location is given as a list of indices (0-based for JS).
	See #scanTree:accessPath: for an explanation of the reason
	why searching starts in siblings and not in children (short:
	because the specified Node is the first child of the DOM
	subtree and not its parent)."

	| nextNode |

	"Select the next Node"
	nextNode := self sibling: anArray first of: aNode.

	"Check if we're done already"
	anArray size = 1
		ifTrue: [ ^ nextNode ].

	"Go into the next node...and repeat"
	^ self
		nodeIn: (self firstChildNodeOf: nextNode)
		atPath: anArray allButFirst
]

{ #category : #private }
CpTemplateBasedDomUpdater >> prepare [

	"Prepare the receiver for creating and updating DOM subtree.

	Implementation:
	Create a mapping which allows a Dictionary like object to be quickly
	rendered inside the DOM subtree."

	mapping ifNotNil: [ ^ self ].

	"Create a DOM subtree as a template (which can be changed without touching element)"
	self createTemplate.

	"Walk the template and find mappable elements"
	mapping := OrderedCollection new.

	self scanTree: template accessPath: ByteArray new
]

{ #category : #private }
CpTemplateBasedDomUpdater >> renderData: aDictionary on: aNode [

	"Render the specified data onto the DOM subtree specified
	by the given reference Node. The Node is the first Node of
	the subtree.

	Implementation:
	The specified reference Node might have (next) siblings which are
	part of the subtree (but we don't actually know the shape of the
	subtree, it might be part of the larger DOM when updating).
	The actual shape is however not needed, because we already know
	the location of the items we need to render (as long as it has
	not been updated by some other mechanism!)."

	mapping do: [ :each |
		self
			renderValue: (aDictionary at: each key ifAbsent: [ nil ])
			in: (self nodeIn: aNode atPath: each value) ]
]

{ #category : #private }
CpTemplateBasedDomUpdater >> renderValue: anObject in: aNode [

	| nodeType name |

	nodeType := aNode propertyAt: #nodeType.

	"Render attribute"
	nodeType = 2
		ifTrue: [
			"Toggle class"
			name := aNode propertyAt: #nodeName.
			(name beginsWith: 'classed-')
				ifTrue: [ (aNode propertyAt: #ownerElement) classed: (name allButFirst: 8) if: anObject ]
				ifFalse: [
			
			"Property"
			(name beginsWith: 'property-')
				ifTrue: [ (aNode propertyAt: #ownerElement) propertyAt: (name allButFirst: 9) put: anObject ]
				ifFalse: [

			"Style"
			(name beginsWith: 'style-')
				ifTrue: [ (aNode propertyAt: #ownerElement) styleAt: (name allButFirst: 6) put: anObject ]
				ifFalse: [

			"Regular content (I'm in the #ifFalse: branch here!)"
			 aNode propertyAt: #nodeValue put: (anObject ifNil: [ '' ]) asString ] ] ] ]
		ifFalse: [

	"Render text content"
	nodeType = 3
		ifTrue: [ aNode propertyAt: #nodeValue put: (anObject ifNil: [ '' ]) asString ] ]
]

{ #category : #private }
CpTemplateBasedDomUpdater >> scanTree: aNode accessPath: anArray [

	"Scan the specified subtree and add any mappings of data references found.
	A list of indices is kept to find the correct node within the DOM subtree.
	The indices are 0-based because of using JS functions.

	Implementation:
	The scanning starts with the parent for the template content. This parent
	itself will never become part of the actual document DOM. When rendering
	the data we will need to refer to the first node in the DOM subtree,
	because we might be rendered in a list and this will not be the first child.
	Instead of using the parent we use the first child as anchor point when
	rendering. As a result the method #nodeIn:atPath: will work from that anchor
	and therefore first start iterating in siblings, instead of children."

	| nodeType key |

	(self childNodesOf: aNode) withIndexDo: [ :each :index |
		nodeType := each propertyAt: #nodeType.

		"Element node"
		nodeType = 1
			ifTrue: [
				"Scan children (adding next index to access path)"
				self scanTree: each accessPath: (anArray copyWith: index - 1) ]
			ifFalse: [

		"Attribute node or Text node"
		(nodeType = 2 or: [ nodeType = 3 ])
			ifTrue: [
				"Check if the text content has a key reference"
				key := (each propertyAt: #nodeValue) trim.
				((key beginsWith: '{{') and: [ key endsWith: '}}' ])
					ifTrue: [
						key := key copyFrom: 3 to: key size - 2.
						mapping add: key -> (anArray copyWith: index - 1) ] ] ] ]
]

{ #category : #private }
CpTemplateBasedDomUpdater >> sibling: anInteger of: aNode [

	| nextNode |

	anInteger = 0
		ifTrue: [ ^ aNode ].

	"Handle attributes specifically"
	(aNode propertyAt: #nodeType) = 2
		ifTrue: [ ^ ((aNode propertyAt: #ownerElement) propertyAt: #attributes) apply: #item withArguments: { anInteger } ].

	"Default way iterating the siblings"
	nextNode := aNode.
	anInteger timesRepeat: [ nextNode := nextNode propertyAt: #nextSibling ].

	^ nextNode
]
