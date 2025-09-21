"
I am a DOM Updater based on a HTML Template.
I am responsible for creating or updating DOM subtrees based on a HTML template (by default a HTML
 <template> element, but other HTML elements are accepted as well) and some data provided in a
Dictionary like object. The data object only needs to understand the message: #at:ifAbsent:

IMPORTANT: Do NOT update the result of the DOM Updater manually. It will likely change the position
of Nodes in the created DOM subtree and therefore make the updater incorrectly update other parts of
the DOM (or worse crash, because no error checking is performed).
Also be careful not to use any libraries which do automagic DOM manipulation on those DOM subtrees.

Currently a limited set of data updates is possible:
- textContent: replace textContent inside the DOM subtree with the text from the data
- attribute content: replace the attribute value in a HTML element with the text from the data
- class toggling: toggle a class on or off based on a Boolean value from the data
- set style: set a value from the data as style in a HTML element
- set property: set a value from the data as property of a HTML element

Examples of the above (in same order):
 <template><h1>{{text}}</h1></template>
 <template><h1 title=""{{title}}"">My header</h1></template>
 <template><h1 classed-hide=""{{isHidden}}"">My header</h1></template>
 <template><h1 style-display=""{{styleDisplay}}"">My header</h1></template>
 <template><input id=""accept"" type=""checkbox"" property-checked=""{{isChecked}}""><label for=""accept"">Accept consequences?</label></template>

In the last 3 items, the attribute name consists of a 'type' and a reference to some class, style,
property respectively. ""style-display"" refers to the ""display"" style. ""property-checked"" refers
to the ""checked"" property. Etc.

See also example in: CpDomExamplesWebClientBehavior >> #exampleDomUpdater

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

The DomUpdater will scan the provided template element and create a collection of data points (data keys
and locations of the Node within the DOM subtree). When creating or updating a DOM subtree (using some
provided data) these data points will be used to update only relevant parts of the DOM subree and not
fully recreate everything.
"
Class {
	#name : #CpTemplateBasedDomUpdater,
	#superclass : #Object,
	#instVars : [
		'element',
		'template',
		'dataPoints'
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

	Implementation:
	Do NOT change the order in which Nodes are added. It is relied
	upon by the render methods: first attributes, then regular children.
	This is relevant for the #firstChildNodeOf: and #sibling:of: methods."

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
CpTemplateBasedDomUpdater >> createDomFor: aDictionary in: aNode [

	^ self createDomFor: aDictionary in: aNode before: nil
]

{ #category : #rendering }
CpTemplateBasedDomUpdater >> createDomFor: aDictionary in: aNode before: aChildNode [

	"Create a new DOM subtree for the specified (Dictionary like) object.
	The subtree will be inserted in the specified Node at the specified
	location (before the child Node or at the end if nil is provided as
	the child Node's value).
	Answer the first child Node created, this is the reference point
	for updating the subtree later on using #updateDomFor:in:
	When the subtree is created in a known location, the answered Node
	does not need to be used. A regular reference to a CpDomElement can
	be used during updating as well."

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
		newNode := prevNode ].

	^ refNode
]

{ #category : #private }
CpTemplateBasedDomUpdater >> createTemplate [

	"Create a new DOM subtree with the template element's content (or
	the element itself if it ain't a <template> but regular element).
	All subtree content is wrapped in a single <div> element for convenience.
	This allows a template with multiple children to be respresented
	by a single element."

	| childNodes index childNode |

	"Start with empty <div>"
	template := CpHtmlElement newWithTag: #div.

	"Copy Nodes child by child"
	childNodes := ((element propertyAt: #content) ifNil: [ element ]) propertyAt: #childNodes.
	index := 0.
	[ (childNode := childNodes apply: #item withArguments: { index }) isNotNil ] whileTrue: [

		"Deep clone child node (so we don't have to recurse ourselves)"
		template apply: #appendChild withArguments: { childNode apply: #cloneNode withArguments: { true } }.
		index := index + 1 ]
]

{ #category : #private }
CpTemplateBasedDomUpdater >> firstChildNodeOf: aNode [

	"Answer the first child Node of the specified Node.
	In contrast with default Node behaviour, include attribute Nodes as well.
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
	subtree and not its parent, it's an anchor point)."

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
	Create a collection of data points (data key and a Node access path) which later allows
	the data to be quickly rendered inside the DOM subtree."

	dataPoints ifNotNil: [ ^ self ].

	"Create a DOM subtree as a template (which can then be changed without touching the original element)"
	self createTemplate.

	"Walk the template and store the data points (with key and access path)"
	dataPoints := OrderedCollection new.
	self scanTree: template accessPath: ByteArray new
]

{ #category : #private }
CpTemplateBasedDomUpdater >> renderData: aDictionary on: aNode [

	"Render the specified data onto the DOM subtree specified by the
	given reference Node. The Node MUST be the first Node of the subtree.
	A data point has a key into the data object and an access path to
	select the Node within the DOM subtree."

	dataPoints do: [ :each |
		self
			renderValue: (aDictionary at: each key ifAbsent: [ nil ])
			in: (self nodeIn: aNode atPath: each value) ]
]

{ #category : #private }
CpTemplateBasedDomUpdater >> renderValue: anObject in: aNode [

	"Render the specified value in the given Node.
	For attribute based Nodes, handle the rendering specifically.
	See class comment for an explanation and a few example templates."

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
				ifTrue: [ (aNode propertyAt: #ownerElement) styleAt: (name allButFirst: 6) put: anObject asString ]
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

	"Scan the specified subtree and add data points for data references found.
	The data point consists of a data key and an access path. The access path
	is a list of indices to find the correct node within the DOM subtree.
	The indices are 0-based because of using JS functions.

	Implementation:
	The scanning starts with the parent for the template content. This parent
	itself will never become part of the actual document DOM. When rendering
	the data we will need to refer to the first node in the DOM subtree (i.e.
	we will not refer to the parent), because we might be rendered in a list
	and this will not be the first child. Instead of using the parent we use
	the first child as anchor point when rendering. As a result the method
	#nodeIn:atPath: will work from that anchor and will therefore first start
	iterating in siblings, instead of children."

	| nodeType key |

	(self childNodesOf: aNode) withIndexDo: [ :each :index |
		nodeType := each propertyAt: #nodeType.

		"Element node"
		nodeType = 1
			ifTrue: [
				"Scan children (adding next index to access path, 0-based)"
				self scanTree: each accessPath: (anArray copyWith: index - 1) ]
			ifFalse: [

		"Attribute node or Text node"
		(nodeType = 2 or: [ nodeType = 3 ])
			ifTrue: [
				"Check if the text content has a key reference"
				key := (each propertyAt: #nodeValue) trim.
				((key beginsWith: '{{') and: [ key endsWith: '}}' ])
					ifTrue: [
						"Store data point (key referenced and access path, 0-based)"
						key := key copyFrom: 3 to: key size - 2.
						dataPoints add: key -> (anArray copyWith: index - 1) ] ] ] ]
]

{ #category : #private }
CpTemplateBasedDomUpdater >> sibling: anInteger of: aNode [

	"Answer the n-th sibling (0-based indexing) of the specified Node.
	Assume the n-th sibling exists and aNode is the first Node (itself is sibling at index 0).
	In contrast with default Node behaviour, include attribute Nodes as well.
	See also #childNodesOf:"

	| remainingIndex nextNode attributes length |

	anInteger = 0
		ifTrue: [ ^ aNode ].

	"Handle attributes first"
	(aNode propertyAt: #nodeType) = 2
		ifTrue: [
			attributes := (aNode propertyAt: #ownerElement) propertyAt: #attributes.
			length := attributes propertyAt: #length.
			anInteger < length
				ifTrue: [ ^ attributes apply: #item withArguments: { anInteger } ].
			remainingIndex := anInteger - length.
			nextNode := (aNode propertyAt: #ownerElement) propertyAt: #firstChild ]
		ifFalse: [
			remainingIndex := anInteger.
			nextNode := aNode ].

	"Regular Node (with parent)"
	(nextNode propertyAt: #parentNode)
		ifNotNil: [ :parentNode | ^ (parentNode propertyAt: #childNodes) apply: #item withArguments: { remainingIndex } ].

	"Regular Node (without parent)"
	remainingIndex timesRepeat: [ nextNode := nextNode propertyAt: #nextSibling ].

	^ nextNode
]

{ #category : #rendering }
CpTemplateBasedDomUpdater >> updateDomFor: aDictionary in: aNode [

	"Update the existing DOM subtree for the specified (Dictionary like) object.
	Make sure the DOM subtree has NOT been altered 'manually' or by some other
	tool/library, because updating will refer to Nodes in the subtree using a
	'known' location derived during creation of the initial creation of the
	DOM subtree."

	self prepare.

	"Render data onto the subtree"
	self renderData: aDictionary on: aNode
]
