"
I am a DOM Updater based on a HTML Template.
I am responsible for creating or updating DOM subtrees based on a HTML template and data provided in a
Dictionary like object. The HTML template preferable is a HTML <template> element (because by default it
will not show in the DOM), but other HTML elements are accepted as well. The data object only needs to
understand the message #at:ifAbsent: (so it is easy to create or add this method to an existing object).

I collaborate with DataUpdaters to implement my behavior.

IMPORTANT: Do NOT update the resultig DOM subtree of the DOM Updater manually. It can accidentally
remove some internal properties making the DOM updater incorrectly update other parts of the DOM
(or worse crash), because no error checking is performed (or even possible).
Also be careful not to use any libraries which do automagic DOM manipulation on those DOM subtrees.

Currently a limited set of data updates is possible:
- textContent: replace textContent inside the DOM subtree with the text from the data
- attribute content: replace the attribute value in a HTML element with the text from the data
- class toggling: toggle a class on or off based on a Boolean value from the data
- set style: set a value from the data as style in a HTML element
- set property: set a value from the data as property of a HTML element
- add event hander: add an event handler (expecting data is BlockClosure or cullable)

Examples of the above (in same order):
 <template><h1>\{\{text\}\}</h1></template>
 <template><h1 title=""\{\{title\}\}"">My header</h1></template>
 <template><h1 classed-hide=""\{\{isHidden\}\}"">My header</h1></template>
 <template><h1 style-display=""\{\{styleDisplay\}\}"">My header</h1></template>
 <template><input id=""accept"" type=""checkbox"" property-checked=""\{\{isChecked\}\}""><label for=""accept"">Accept consequences?</label></template>
 <template><button event-click=""{{handlerBlock}}"">Click me!</button></template>

In the last 4 items, the attribute name consists of a 'type' and a reference to some class, style,
property or event respectively. ""style-display"" refers to the ""display"" style. ""property-checked"" refers
to the ""checked"" property. Etc. The event name should be the kebabed-version of the class name.
Be aware that this means you need to use 'mouse-over' and not the JS type 'mouseover'.
The event is culled to the event handler. If you need to have access to the data object which was
attached to the DOM subtree, consider using the following on your template (the 'yourself' data point is special
(only) in a property data point and refers to the full data object):
 <template><div><button event-click=""{{click}}"" property-data=""{{yourself}}"">Click me</button></div></template>
The following Block could be used in this case to extract the data from the <button> element:
 [ :event | | data | date := event currentTarget propertyAt: #data. self traceCr: 'Data is ', data printString ] 

Multiple data update references can be present on the same element (for example):
 <template><li class=""\{\{itemType\}\}"" classed-hide=""\{\{isHidden\}\}"">\{\{itemText\}\}</li></template>

See also example in: CpDomExamplesWebClientBehavior >> #exampleDomUpdater

Implementation:
The DomUpdater like the CpDomElement and children is focussed on Elements and ignores Nodes (mostly).
This means that only text content inside an Element is allowed (as data point), if no other Elements
are present as a child of that Element. The following is therefore not supported:
	`<span>\{\{someData\}\}<a href=""#"">BROKEN LINK!</a></span>` BAD EXAMPLE!
The example above has text content AND an Element (the `<a>`) inside the `<span>` element, which is
NOT allowed in a template.

The DomUpdater will scan the provided template element and create a collection of DataUpdaters for
the data updates found. When creating or updating a DOM subtree (using some provided data) these
DataUpdates will be used to update only relevant parts of the DOM subree and not fully recreate
the whole DOM subtree.
"
Class {
	#name : #CpTemplateBasedDomUpdater,
	#superclass : #Object,
	#instVars : [
		'template',
		'dataUpdaters'
	],
	#category : #'CodeParadise-WebApplication-Support'
}

{ #category : #'class initialization' }
CpTemplateBasedDomUpdater class >> beLoaded [

	"Load the base DataUpdaters. Applications should load their specific variants."

	CpAttributeDataUpdater beLoaded.
	CpTextDataUpdater beLoaded
]

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
CpTemplateBasedDomUpdater >> addAttributeDataUpdaterNamed: aString for: anElement [

	"Add an attribute based DataUpdater if present in the specified Element.
	Remove the data point reference once added."

	| key |

	key := self keyFrom: (anElement attributeAt: aString).
	key ifNil: [ ^ self ].

	self
		addDataUpdater: (CpAttributeDataUpdater key: key matchingName: aString)
		for: anElement.

	anElement removeAttributeAt: aString
]

{ #category : #private }
CpTemplateBasedDomUpdater >> addDataUpdater: aDataUpdater for: anElement [

	| index |

	dataUpdaters add: aDataUpdater.
	index := dataUpdaters size.

	self addDataUpdaterIndex: index to: anElement.

	anElement addClass: self markerClassName
]

{ #category : #private }
CpTemplateBasedDomUpdater >> addDataUpdaterIndex: anInteger to: anElement [

	"The DataUpdater indices are kept in an attribute on the Element
	(as a space separated list)"

	anElement
		attributeAt: self indexAttributeName
		put: ((anElement attributeAt: self indexAttributeName)
			ifNotNil: [ :indices |
				String streamContents: [ :stream |
					stream
						nextPutAll: indices ;
						space ;
						print: anInteger ] ]
			ifNil: [ anInteger printString ])
]

{ #category : #private }
CpTemplateBasedDomUpdater >> addTextDataUpdaterFor: anElement [

	"Add a text based DataUpdater if present in the specified Element.
	Remove the data point reference once added."

	| key |

	key := self keyFrom: anElement localTextContent.
	key ifNil: [ ^ self ].

	self
		addDataUpdater: (CpTextDataUpdater key: key)
		for: anElement.

	anElement textContent: ''
]

{ #category : #private }
CpTemplateBasedDomUpdater >> allMarkedElementsIn: anElement do: aBlock [

	"Evaluate the Block with the receiver and all its children
	which are marked (i.e. have DataUpdaters attached)"

	(anElement isClassed: self markerClassName)
		ifTrue: [ aBlock value: anElement ].

	self markedElementsIn: anElement do: aBlock
]

{ #category : #rendering }
CpTemplateBasedDomUpdater >> createDomIn: anElement before: aChildElement with: aDictionary [

	"Create a new DOM subtree for the specified (Dictionary like) object.
	The subtree will be inserted in the specified Element at the specified
	location (before the child Element or at the end if nil is provided as
	the child Element's value).
	Answer the first child Element created, this is the reference point
	for updating the subtree later on using #updateDomFor:in:
	When the subtree is created in a known location, the answered Element
	does not need to be used. A regular reference to a CpDomElement can
	be used during updating as well."

	| subtree newElement refElement prevElement |

	"Create a new DOM subtree (will always have a <div> as parent)"
	subtree := template apply: #cloneNode withArguments: { true }.

	"Move the indices to a property on all elements in the DOM subtree"
	self moveIndicesToPropertyIn: subtree.

	"Render data onto the subtree"
	self renderData: aDictionary on: subtree firstChild.

	"Move subtree into final position.
	To ensure correct order (also when aChildElement is nil) always
	insert from last to first subtree child and use the previous
	inserted element as reference point (except for first one which
	is specified explicitly by caller)."
	refElement := aChildElement.
	newElement := subtree lastChild.
	[ newElement isNotNil ] whileTrue: [
		"Get the previous Element before the Element is moved and this info is lost"
		prevElement := newElement previousSibling.
		refElement
			ifNotNil: [ anElement insertChild: newElement before: refElement ]
			ifNil: [ anElement appendChild: newElement ].
		refElement := newElement.
		newElement := prevElement ].

	^ refElement
]

{ #category : #rendering }
CpTemplateBasedDomUpdater >> createDomIn: anElement with: aDictionary [

	^ self createDomIn: anElement before: nil with: aDictionary
]

{ #category : #private }
CpTemplateBasedDomUpdater >> createTemplateFrom: anElement [

	"Create a new DOM subtree with the template element's content (or
	the element itself if it ain't a <template> but a regular element).
	All subtree content is wrapped in a single <div> element for convenience.
	This allows a template with multiple children to be respresented
	by a single element. The DOM subtree can then be annotated with markers
	for the update/render process. The markers will allow for fast updates,
	because it does not require the full parsing of the original template
	anymore.

	Implementation:
	The annotation is a Collection of integer values. These integers are an
	index into a Collection of DataUpdaters. When rendering data onto a DOM
	subtree, the appropriate DataUpdaters are called for that particular
	Element. At first the indices are stored as an attribute on the Element.
	Once rendered in the (connected) document DOM, the indices will be
	stored in a property of the Element. When creating a copy of the template
	in the (connected) document DOM, properties are not copied. So we need
	to keep it in an attribute so it will get copied (cloned)."

	| childNodes index childNode |

	"Start with empty <div>"
	template := CpHtmlElement newWithTag: #div.

	"Copy Nodes child by child"
	childNodes := ((anElement propertyAt: #content) ifNil: [ anElement ]) propertyAt: #childNodes.
	index := 0.
	[ (childNode := childNodes apply: #item withArguments: { index }) isNotNil ] whileTrue: [

		"Deep clone child node (so we don't have to recurse ourselves)"
		template apply: #appendChild withArguments: { childNode apply: #cloneNode withArguments: { true } }.
		index := index + 1 ].

	"Walk the template and store the DataUpdaters"
	self scanTree: template
]

{ #category : #accessing }
CpTemplateBasedDomUpdater >> indexAttributeName [

	"Answer the name of the attribute where indices are stored"

	^ #'cp-du-idx'
]

{ #category : #initialization }
CpTemplateBasedDomUpdater >> initialize [

	super initialize.

	dataUpdaters := OrderedCollection new
]

{ #category : #initialization }
CpTemplateBasedDomUpdater >> initializeWithElement: anElement [

	self initialize.

	self createTemplateFrom: anElement.
	
]

{ #category : #private }
CpTemplateBasedDomUpdater >> keyFrom: aString [
	"Answer a DataUpdater key (the reference to the data)
	or nil if no key is present"

	| key |

	aString ifNil: [ ^ nil ].

	key := aString trim.
	((key beginsWith: '{{') and: [ key endsWith: '}}' ])
		ifFalse: [ ^ nil ].

	^ key copyFrom: 3 to: key size - 2
]

{ #category : #private }
CpTemplateBasedDomUpdater >> markedElementsIn: anElement do: aBlock [

	"Evaluate the Block for all the children of the specied Element
	which are marked (i.e. have DataUpdaters attached)"

	(anElement allDescendantsMatching: '.', self markerClassName) do: aBlock
]

{ #category : #accessing }
CpTemplateBasedDomUpdater >> markerClassName [

	"Answer the (HTML) class name to mark Elements which have an DataUpdater attached"

	^ #'cp-du-marker'
]

{ #category : #private }
CpTemplateBasedDomUpdater >> moveIndicesToPropertyIn: anElement [

	"Move the DataUpdater indices from attribute to property in the
	subtree of the specified Element (i.e. all its children).

	Implementation:
	Use the same property name as the attribute name. The attribute
	contains a String with space separated index value. Convert this
	to a Collection of integer values for easy and quick iteration
	later when updating/rendering."

	self markedElementsIn: anElement do: [ :each |
		each
			propertyAt: self indexAttributeName
			put: ((each attributeAt: self indexAttributeName)
				ifNotNil: [ :indices | (indices findTokens: ' ') collect: [ :eachIndex | eachIndex asNumber ] ]).
		each removeAttributeAt: self indexAttributeName ]
]

{ #category : #private }
CpTemplateBasedDomUpdater >> renderData: aDictionary on: anElement [

	"Render the specified data onto the DOM subtree specified by the
	given reference Element. The Element MUST be the first Element of
	the subtree. If necessary rendering will continu on siblings of
	this Element.
	For example the following template:
		<template>
			<li>{{oddItem}}</li>
			<li>{{evenItem}}</li>
		</template>
	The #renderData:on: method should be called with the first <li>
	element. The second element will be rendered too by the mechanism
	implemented in #renderRemaining:data:on:"

	self renderRemaining: dataUpdaters size data: aDictionary on: anElement
]

{ #category : #private }
CpTemplateBasedDomUpdater >> renderRemaining: anInteger data: aDictionary on: anElement [

	"Render the remaining count of the specified data onto the DOM subtree
	specified by the given reference Element.

	Implementation:
	When more data needs to be rendered then possible within the specified
	Element, continu onto its next sibling. See also comment in #renderData:on:"

	| remaining |

	remaining := anInteger.

	self allMarkedElementsIn: anElement do: [ :each |
		self updatersOn: each do: [ :eachUpdater |
			eachUpdater renderData: aDictionary on: each.
			remaining := remaining - 1 ] ].

	remaining = 0
		ifTrue: [ ^ self ].

	anElement nextSibling
		ifNotNil: [ :nextSibling | self renderRemaining: remaining data: aDictionary on: nextSibling ]
		ifNil: [ self warnCr: 'Template shape does not match the origin anymore' ]
]

{ #category : #private }
CpTemplateBasedDomUpdater >> scanTree: anElement [

	"Scan the specified DOM subtree and add DataUpdaters"

	"Check attributes (MUST be first, since it might add new attributes!)"
	anElement attributeNames do: [ :each |
		self addAttributeDataUpdaterNamed: each for: anElement ].

	"Check text content"
	self addTextDataUpdaterFor: anElement.

	anElement children do: [ :each | self scanTree: each ]
]

{ #category : #rendering }
CpTemplateBasedDomUpdater >> updateChildrenOf: anElement with: aSequenceableCollection [

	"Create and/or update the children of the specified Element using the Collection of data.
	It is assumed the template of the receiver has a single element (and therefore each child
	of the specified Element is an instance of the template)."

	| children |

	template children size = 1 ifFalse: [
		self error: 'Only single element templates are supported' ].

	children := anElement children.

	"Add or update children"
	aSequenceableCollection withIndexDo: [ :each :index |
			index <= children size
				ifTrue: [ self updateDomIn: (children at: index) with: each ]
				ifFalse: [ self createDomIn: anElement with: each ] ].

	"Remove any remaining children (if the data has shrunk)"
	children size to: aSequenceableCollection size + 1 by: -1 do: [ :index |
		(children at: index) destroy ]
]

{ #category : #rendering }
CpTemplateBasedDomUpdater >> updateDomIn: anElement with: aDictionary [

	"Update the existing DOM subtree for the specified (Dictionary like) object.
	Make sure the DOM subtree has NOT been altered 'manually' or by some other
	tool/library, because updating will refer to Elements in the subtree using a
	'known' location derived during creation of the initial creation of the
	DOM subtree."

	self renderData: aDictionary on: anElement
]

{ #category : #private }
CpTemplateBasedDomUpdater >> updatersOn: anElement do: aBlock [

	"Evaluate the specified Block for all updaters in the specified Element.

	Implementation:
	The indices of the DataUpdaters are stored in a property with the same
	name as the attribute."

	| indices |

	indices := (anElement propertyAt: self indexAttributeName)
		ifNil: [ ^ self ].

	"Evaluate the Block for each DataUpdater in turn"
	indices do: [ :index | aBlock value: (dataUpdaters at: index) ]
]
