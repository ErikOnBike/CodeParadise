"
I represent a DOM element in a web browser document (ie a page or tab).
See https://developer.mozilla.org/en-US/docs/Web/API/Element.

I select, add and/or remove DOM elements inside a browser document. I get and set the element's class, id, attributes, styles and properties. I also get and set the content of DOM elements. I differentiate between text content and markup content. 

My instances and my behavior differ from Javascript DOM elements in a few ways:
- My method names are (and therefore interface is) sometimes slightly different than the Javascript DOM interface. Instead of the DOM method 'innerHTML' I respond to the messages #markupContent and #markupContent: because that is a more consistent name, for example in combination with SVG elements.
- I only support the higher level DOM Element interface and do not support the low level Node interface.
- For a more consistent usage of DOM Elements, I do not support elements which have both text content (which is a DOM Node) as well as child elements. If the first child element is added to an existing element, its text content will be removed/replaced by the new child element. Selecting existing elements which do have both text content and child elements will not remove the existing text content though. Adding additional elements to such an element will also not remove the text content. Text content is only replaced by a child element on appending the first child element. Appending elements with both text content and child elements through #markupContent: is also not prevented.

Examples (are mostly HTML based for understandability):
Create a 'div' tag and set its class field to 'block':
	[[[ (CpDomElement newWithTag: #div) addClass: #block ]]]

Replace all 'span' tags classed 'icon' with a copy of an image (without creating a copy the image would be moved to a new location on each invocation of #replaceChild:with:):
	[[[
		| image |
		image := CpDomElement document firstDescendantMatching: '#icon-image'.
		(CpDomElement document allDescendantsMatching: 'span.icon') do: [ :each |
			each parent replaceChild: each with: image clone ]
	]]]

Implementation:
Almost all my methods are implemented using primitives, because I am the glue layer between the Smalltalk code and the browser DOM.
"
Class {
	#name : #CpDomElement,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#category : #'CodeParadise-WebApplication-DOM'
}

{ #category : #'instance creation' }
CpDomElement class >> basicNewWithTag: tagString [

	"Create a new instance of the receiver or one of the receiver's subclasses using the specified tag.
	If the specified tag contains a (known) prefix, an instance for that prefix type is answered.
	See also #registerNamespace:forPrefix:"

	<primitive: 'primitiveDomElementNewWithTag:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #'accessing - state' }
CpDomElement class >> beLoaded [

	CpDomRectangle beLoaded
]

{ #category : #'acccessing-ui' }
CpDomElement class >> document [

	"Answer an instance of the receiver representing the current (browser tab) document"

	<primitive: 'primitiveDomElementDocument' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #'acccessing-ui' }
CpDomElement class >> elementsFromPoint: aPoint [

	"Answer an Array with instances of the receiver representing the elements at the specified point"

	<primitive: 'primitiveDomElementElementsFromPoint:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #'instance creation' }
CpDomElement class >> new [

	"Instances of the receiver are created through #newWithTag: or when querying children of existing DOM elements
	or are created by querying the DOM using #firstDescendantMatching: or #allDescendantsMatching:
	Subclasses might override this behavior and create specific instances."

	self requiresInstantiationWithTag
		ifTrue: [ self error: 'Instances of the receiver should be created using ', #newWithTag: ]
		ifFalse: [ ^ super new ]
]

{ #category : #'instance creation' }
CpDomElement class >> newWithTag: tagString [

	"Create a new instance of the receiver or one of the receiver's subclasses using the specified tag.
	If the specified tag contains a (known) prefix, an instance for that prefix type is answered.
	See also #registerNamespace:forPrefix:"

	^ (self basicNewWithTag: tagString)
		initialize ;
		yourself
]

{ #category : #'class initialization' }
CpDomElement class >> postInstall [

	"Register a namespace for the receiver"

	super postInstall.

	(self classSide includesSelector: #namespace)
		ifTrue: [ self registerNamespace: self namespace forPrefix: self prefix ]
]

{ #category : #support }
CpDomElement class >> registerNamespace: namespaceString forPrefix: prefixString [

	"Register the specified namespace with the given prefix.
	Once a namespace is registered, creating a new instance using the matching prefix will result in
	an instance of the class which registered the namespace and prefix.
	Namespaces are required for creating SVG or MathML elements within the HTML DOM for example.
	See also https://developer.mozilla.org/en-US/docs/Web/API/document/createElementNS"

	<primitive: 'primitiveDomElementRegisterNamespace:forPrefix:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #testing }
CpDomElement class >> requiresInstantiationWithTag [

	^ true
]

{ #category : #support }
CpDomElement class >> tag: tagString withPrefix: prefixString [

	"Answer a full tag name created by a simple tag and a prefix: <prefix>:<tag>"

	| fullTag |

	fullTag := String new: tagString size + 1 + prefixString size.
	fullTag
		replaceFrom: 1 to: prefixString size with: prefixString ;
		at: prefixString size + 1 put: $: ;
		replaceFrom: prefixString size + 2 to: fullTag size with: tagString.

	^ fullTag
]

{ #category : #'tag/id/classes' }
CpDomElement >> addClass: aString [

	"Add the specified class value to the receiver.
	If the receiver already has the specified class, nothing will happen."

	<primitive: 'primitiveDomElementAddClass:' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #'tag/id/classes' }
CpDomElement >> addClasses: aCollection [

	"Add the specified classes to the receiver."

	aCollection do: [ :each | self addClass: each ]

]

{ #category : #querying }
CpDomElement >> allAncestorsMatching: cssSelectorString [

	"Answer all ancestors of the receiver matching the specified CSS selector.
	The order of the elements is from the lowest (receiver) to the root (body) element."

	| ancestors ancestor |

	ancestors := OrderedCollection new.

	ancestor := self.
	[ (ancestor := ancestor firstAncestorMatching: cssSelectorString) isNotNil ] whileTrue: [
		ancestors add: ancestor ].

	^ ancestors
]

{ #category : #querying }
CpDomElement >> allDescendantsMatching: cssSelectorString [

	"Answer all descendants of the receiver matching the specified CSS selector.
	The order of the elements is based on their position within the document (tree, pre-order depth-first search).
	See also https://developer.mozilla.org/en-US/docs/Web/API/Element/querySelectorAll"

	<primitive: 'primitiveDomElementAllDescendantsMatching:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #animation }
CpDomElement >> animate: aCollection [

	"Animate the receiver using the specified keyframes"

	self apply: #animate withArguments: { aCollection }
]

{ #category : #animation }
CpDomElement >> animate: aCollection duration: anInteger [

	"Animate the receiver using the specified keyframes and options"

	self apply: #animate withArguments: { aCollection . anInteger }
]

{ #category : #animation }
CpDomElement >> animate: aCollection options: aDictionary [

	"Animate the receiver using the specified keyframes and options"

	self apply: #animate withArguments: { aCollection . aDictionary }
]

{ #category : #announcing }
CpDomElement >> announce: anAnnouncement [

	announcer ifNil: [ ^ self ].
	announcer announce: anAnnouncement
]

{ #category : #announcing }
CpDomElement >> announcer [

	^ announcer ifNil: [ announcer := CpDomElementAnnouncer newForElement: self ]
]

{ #category : #'adding/removing' }
CpDomElement >> appendChild: childElement [

	"Append childElement as a child of the receiver. Answer the child element.
	If the receiver already has children the child element will be added after the last child.
	Otherwise child element will be the first child of the receiver. In the later case,
	any textual content will be removed from the receiver. An element has either textual
	content or child elements as content.
	This is different than what the browser DOM supports, but more consistent wrt using
	DOM Elements instead of DOM Nodes.
	If the child element was child of another element, it will be moved to the receiver
	and no longer be accessible from its previous parent (that is, no clone is made)."

	<primitive: 'primitiveDomElementAppendChild:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #performing }
CpDomElement >> apply: aSymbol withArguments: anArray [

	"Perform the specified symbol as JS function on the receiver with the specified arguments.
	Always answers the receiver.

	Be aware that the JS function will be evaluated asynchronously. Meaning that any synchronous
	events (like #focusin after a #focus method) will not be executed directly. A synchronous
	execution would leave the VM stack unbalanced since events are handled with priority and
	would interfere with the primitive being executed itself."

	<primitive: 'primitiveDomElementApply:withArguments:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #attributes }
CpDomElement >> attributeAdd: nameString [

	"Set the specified attribute (without value) of the receiver.

	This is useful for attributes like 'selected' or 'readonly' which do not need a value."

	self attributeAt: nameString put: ''
]

{ #category : #attributes }
CpDomElement >> attributeAt: nameString [

	"Answer the value (a String) of the specified attribute of the receiver
	or nil if attribute is not present"

	<primitive: 'primitiveDomElementAttributeAt:' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #attributes }
CpDomElement >> attributeAt: nameString put: valueString [

	"Set the value of the specified attribute of the receiver.
	If the value nil is used the attribute is removed from the receiver."

	<primitive: 'primitiveDomElementAttributeAt:put:' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #sizing }
CpDomElement >> boundingClientRectangle [

	"Answer a DomRectangle describing the bounds of the receiver, relative to the visible screen"

	<primitive: 'primitiveDomElementBoundingClientRectangle' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #querying }
CpDomElement >> children [

	"Answer an Array with the child elements (in document order) of the receiver.
	If the receiver has no children, an empty Array is answered."

	<primitive: 'primitiveDomElementChildren' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #'tag/id/classes' }
CpDomElement >> classed: aSymbol if: aBoolean [

	"Either add or remove the specified class to/from the receiver based
	on the specified Boolean"

	aBoolean
		ifTrue: [ self addClass: aSymbol ]
		ifFalse: [ self removeClass: aSymbol ]
]

{ #category : #copying }
CpDomElement >> clone [

	"Answer a (deep) clone of the receiver.
	That is, the clone will have the same attributes and number of children as the receiver.
	The clone will not have a parent and therefore needs to be added to a visible element,
	before becoming visible."

	<primitive: 'primitiveDomElementClone' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #performing }
CpDomElement >> defer: aBlock [

	"Evaluate the specified block with a small delay.
	For example to prevent resulting events from overlapping."

	aBlock asTransition
		duration: 0 ;
		startDelayedBy: 10
]

{ #category : #removing }
CpDomElement >> destroy [

	"Remove the receiver from the DOM tree and release any dependents"

	"Remove receiver from parent (take it out of visible DOM)"
	self remove.

	"Destroy all children explicitly as well"
	self children do: [ :each | each destroy ].

	self release
]

{ #category : #querying }
CpDomElement >> elementWithId: aString [

	"Answer an instance of the receiver representing the element with the specified id.
	This method should be called from a root element (either the document or the shadow root)
	otherwise it will fail."

	<primitive: 'primitiveDomElementElementWithId:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #querying }
CpDomElement >> firstAncestorMatching: cssSelectorString [

	"Answer the first ancestor of the receiver matching the specified CSS selector.
	'First' is based on the position of the elements within the document (tree, pre-order depth-first search).
	Answer nil if no such ancestor is found."

	| ancestor |

	ancestor := self parent.
	[ ancestor isNotNil ] whileTrue: [
		(ancestor matches: cssSelectorString)
			ifTrue: [ ^ ancestor ].
		ancestor := ancestor parent ].

	^ nil
]

{ #category : #querying }
CpDomElement >> firstChild [

	"Answer the first child of the receiver or nil if none is present"

	^ self children
		ifNotEmpty: [ :children | children first ]
		ifEmpty: [ nil ]
]

{ #category : #querying }
CpDomElement >> firstDescendantMatching: cssSelectorString [

	"Answer the first descendant of the receiver matching the specified CSS selector.
	'First' is based on the position of the elements within the document (tree, pre-order depth-first search).
	Answer nil if no such descendant exists.
	See also https://developer.mozilla.org/en-US/docs/Web/API/Element/querySelector"

	<primitive: 'primitiveDomElementFirstDescendantMatching:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #'text input' }
CpDomElement >> focus [

	"Set the focus to the receiver (ie take focus)"

	self apply: #focus withArguments: #()
]

{ #category : #attributes }
CpDomElement >> hasAttributeAt: nameString [

	"Answer whether the receiver has a value set for the specified attribute"

	^ (self attributeAt: nameString) notNil
]

{ #category : #properties }
CpDomElement >> hasPropertyAt: nameString [

	"Answer whether the receiver has a value set for the specified property"

	^ (self propertyAt: nameString) notNil
]

{ #category : #styles }
CpDomElement >> hasStyleAt: nameString [

	"Answer whether the receiver has a value set for the specified style"

	^ (self styleAt: nameString) notNil
]

{ #category : #'tag/id/classes' }
CpDomElement >> id [

	"Answer the id of the receiver or nil if none is set"

	<primitive: 'primitiveDomElementId' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #'tag/id/classes' }
CpDomElement >> id: aString [

	"Set the id of the receiver to the specified value.
	A nil or an empty String value is allowed to make the receiver id-less.
	Element id's (if not nil nor empty) should be unique, but no checks are performed to guarantee this.
	The senders of this message should take care of assuring uniqueness of id's."

	<primitive: 'primitiveDomElementId:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #'adding/removing' }
CpDomElement >> insertChild: childElement before: siblingElement [

	"Insert childElement as a child of the receiver, directly before the existing sibling element.
	Answer the child element.
	If the child element was child of another element, it will be moved to the receiver
	and no longer be accessible from its previous parent (that is, no clone is made).
	In contrast with the DOM Node.insertBefore() method, siblingElement should not be nil.
	Use #appendChild to add a child element after the last existing child (or as a new first child).
	The primitive will fail if siblingElement is nil or not a child of the receiver."

	<primitive: 'primitiveDomElementInsertChild:before:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #'tag/id/classes' }
CpDomElement >> isClassed: aString [

	"Answer whether the receiver has the specified class value"

	<primitive: 'primitiveDomElementIsClassed:' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #'event handling' }
CpDomElement >> isListeningTo: anEventClass [

	"Answer whether the receiver is listening for the specified event type"

	^ anEventClass isListenedToOn: self
]

{ #category : #querying }
CpDomElement >> lastAncestorMatching: cssSelectorString [

	"Answer the last ancestor of the receiver matching the specified CSS selector.
	'Last' is based on the position of the elements within the document (tree, pre-order depth-first search).
	Be aware this is different than using :last-of-type or :last-child if multiple subtrees contain
	matching elements.
	Answer nil if no such ancestor is found."

	^ (self allAncestorsMatching: cssSelectorString)
		ifNotEmpty: [ :matches | matches last ]
		ifEmpty: [ nil ]
]

{ #category : #querying }
CpDomElement >> lastChild [

	"Answer the last child of the receiver or nil if none is present"

	^ self children
		ifNotEmpty: [ :children | children last ]
		ifEmpty: [ nil ]
]

{ #category : #querying }
CpDomElement >> lastDescendantMatching: cssSelectorString [

	"Answer the last descendant of the receiver matching the specified CSS selector.
	'Last' is based on the position of the elements within the document (tree, pre-order depth-first search).
	Be aware this is different than using :last-of-type or :last-child if multiple subtrees contain
	matching elements.
	Answer nil if no such descendant exists."

	^ (self allDescendantsMatching: cssSelectorString)
		ifNotEmpty: [ :matches | matches last ]
		ifEmpty: [ nil ]
]

{ #category : #content }
CpDomElement >> markupContent [

	"Answer a String representation of the DOM fragment of the receiver's children"

	<primitive: 'primitiveDomElementMarkupContent' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #content }
CpDomElement >> markupContent: aString [

	"Replace the receiver's children by the DOM fragment specified (using a String representation)"

	<primitive: 'primitiveDomElementMarkupContent:' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #querying }
CpDomElement >> matches: cssSelectorString [

	"Answer whether the receiver matches the specified CSS selector.
	See also https://developer.mozilla.org/en-US/docs/Web/API/Element/matches"

	<primitive: 'primitiveDomElementMatches:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #querying }
CpDomElement >> nextSibling [

	"Answer the receiver's next sibling element or nil if the receiver does not have one"

	<primitive: 'primitiveDomElementNextSibling' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #'event handling' }
CpDomElement >> noop [

	"No operation.

	Convenience method to allow event handlers to be no-ops.
	E.g. to prevent Views from passing through click/pointer down events:

		self shadowRoot when: CpPointerDownEvent send: #noop to: self"

]

{ #category : #querying }
CpDomElement >> parent [

	"Answer the receiver's parent element or nil if the receiver does not have a parent.
	When elements are created using #newWithTag: they do not have a parent yet and need
	to be added to a descendant of the [[[CpDomElement >> #document]]] to become visible."

	<primitive: 'primitiveDomElementParent' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #querying }
CpDomElement >> previousSibling [

	"Answer the receiver's previous sibling element or nil if the receiver does not have one"

	<primitive: 'primitiveDomElementPreviousSibling' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #printing }
CpDomElement >> printOn: aStream [

	aStream
		nextPutAll: self class name ;
		nextPutAll: '(<' ;
		nextPutAll: self tagName ;
		nextPutAll: '>)'
]

{ #category : #properties }
CpDomElement >> propertyAt: nameString [

	"Answer the value (String, Number, Boolean or nil) of the specified property of the receiver"

	<primitive: 'primitiveDomElementPropertyAt:' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #properties }
CpDomElement >> propertyAt: nameString put: anObject [

	"Set the value (String, Number, Boolean, nil or Dictionary) of the specified property of the receiver"

	<primitive: 'primitiveDomElementPropertyAt:put:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #dependencies }
CpDomElement >> release [

	announcer ifNotNil: [
		announcer subscriptions reset.
		announcer := nil ].

	super release
]

{ #category : #removing }
CpDomElement >> remove [

	"Remove the receiver from its parent"

	self parent ifNotNil: [ :parent | parent removeChild: self ]
]

{ #category : #attributes }
CpDomElement >> removeAttributeAt: attributeName [

	"Remove the specified attribute from the receiver.
	Nothing will happen if the receiver does not have the specified attribute."

	<primitive: 'primitiveDomElementRemoveAttributeAt:' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #'adding/removing' }
CpDomElement >> removeChild: childElement [

	"Remove the child element from the receiver. Answer the removed child.
	The primitive will fail if child element is not a child of the receiver."

	<primitive: 'primitiveDomElementRemoveChild:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #'adding/removing' }
CpDomElement >> removeChildren [

	self children do: [ :each | self removeChild: each ]
]

{ #category : #'tag/id/classes' }
CpDomElement >> removeClass: aString [

	"Remove the specified class value from the receiver.
	Nothing will happen if the receiver does not have the specified value."

	<primitive: 'primitiveDomElementRemoveClass:' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #'text input' }
CpDomElement >> removeFocus [

	"Set the focus to the receiver (ie take focus)"

	self apply: #blur withArguments: #()
]

{ #category : #'event handling' }
CpDomElement >> removeInterestIn: anAnnouncementClass [

	"Remove the interest for the specified AnnouncementClass from the receiver"

	^ self removeInterestIn: anAnnouncementClass for: self
]

{ #category : #'event handling' }
CpDomElement >> removeInterestIn: anAnnouncementClass for: anObject [

	"Remove the interest for the specified AnnouncementClass and specified
	subscriber from the receiver."

	^ self announcer removeInterestIn: anAnnouncementClass for: anObject
]

{ #category : #styles }
CpDomElement >> removeStyleAt: nameString [

	"Remove the specified style from the receiver, if one was explicitly set on the receiver.
	Styles given through a stylesheet rule can't be removed and have to be overwritten explicitly
	by setting these to the value #auto or #inheret using the method #styleAt:put:.
	Nothing will happen if the specified style is not set on the receiver."

	<primitive: 'primitiveDomElementRemoveStyleAt:' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #'adding/removing' }
CpDomElement >> replaceAllChildrenWith: childElement [

	"Set the specified element as child of the receiver.
	Any existing children will be removed."

	^ self
		removeChildren ;
		appendChild: childElement
]

{ #category : #'adding/removing' }
CpDomElement >> replaceChild: childElement with: replacementElement [

	"Replace the child element of the receiver with a replacement element.
	Answer the new (replacement) child element.
	If the replacement element was child of another element, it will be moved to the receiver
	and no longer be accessible from its previous parent (that is, no clone is made).
	The primitive will fail if child element is not a child of the receiver."

	<primitive: 'primitiveDomElementReplaceChild:with:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #'adding/removing' }
CpDomElement >> replaceChildAtIndex: anInteger with: replacementElement [

	"Replace the child element of the receiver at the specified location with a replacement element.
	Answer the new (replacement) child element.
	If the replacement element was child of another element, it will be moved to the receiver
	and no longer be accessible from its previous parent (that is, no clone is made).
	Raise an error if there is no child element at the specified location."

	| childElement |

	childElement := self children at: anInteger ifAbsent: [ self error: 'No child element at specified location' ].

	self replaceChild: childElement with: replacementElement
]

{ #category : #styles }
CpDomElement >> style [

	"Convenience method to retrieve style attribute"

	^ self attributeAt: #style
]

{ #category : #styles }
CpDomElement >> style: aString [

	"Convenience method to set style attribute"

	self attributeAt: #style put: aString
]

{ #category : #styles }
CpDomElement >> styleAt: nameString [

	"Answer the value (a String) of the specified style of the receiver or nil if such a style does not exist.
	The style value will be the one set explicitly on the element or its computed value if none is set.
	In the later case this value might be specified through a stylesheet rule.
	
	For example:
	myElement styleAt: #display."

	<primitive: 'primitiveDomElementStyleAt:' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #styles }
CpDomElement >> styleAt: nameString put: valueString [

	"Set the value of the specified style of the receiver.
	If the value nil is used, the explicit style is removed from the receiver
	(see als #removeStyleAt:)."

	<primitive: 'primitiveDomElementStyleAt:put:' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #performing }
CpDomElement >> syncApply: aSymbol withArguments: anArray [

	"Perform the specified symbol as JS function on the receiver with the specified arguments.
	Answer the result of the JS function. Use with care (read below)!

	Be aware that the JS function will be evaluated synchronously. This is less safe than
	using #apply:withArguments:. Only use this synchronous variant for performing getter
	functions or in places where it is certain that no events will be triggered. When in
	doubt and when the resulting value is not attainable otherwise, use #apply:withArguments."

	<primitive: 'primitiveDomElementSyncApply:withArguments:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #'tag/id/classes' }
CpDomElement >> tag [

	self
		deprecated: 'Please use #tagName instead.'
		transformWith: '`@receiver tag' -> '`@receiver tagName'.

	^ self tagName
]

{ #category : #'tag/id/classes' }
CpDomElement >> tagName [

	"Answer the tag of the receiver"

	<primitive: 'primitiveDomElementTagName' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #content }
CpDomElement >> textContent [

	"Answer the textual content of the receiver.
	This will answer an aggregated value for all descendants."

	<primitive: 'primitiveDomElementTextContent' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #content }
CpDomElement >> textContent: aString [

	"Set the text of the receiver to the specified value.
	Any existing content is removed, including any child elements."

	<primitive: 'primitiveDomElementTextContent:' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #'tag/id/classes' }
CpDomElement >> toggleClass: aString [

	"Toggle the specified class for the receiver"

	(self isClassed: aString)
		ifTrue: [ self removeClass: aString ]
		ifFalse: [ self addClass: aString ]

]

{ #category : #'event handling' }
CpDomElement >> unregisterAllInterest [

	"Remove interest in all (previously registered) events"

	<primitive: 'primitiveDomElementUnregisterAllInterest' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #announcing }
CpDomElement >> unsubscribe: anObject [

	"Unsubscribe the specified Object from Announcements of the receiver"

	^ self announcer unsubscribe: anObject
]

{ #category : #'event handling' }
CpDomElement >> when: anAnnouncementClass do: aBlock [

	"Let the sender subscribe to the specified announcement of the receiver.
	All CpEvents can also be listened to using this same method.
	CpEvents share the same protocol as Announcements.

	See Announcer>>#when:do:"

	^ self announcer when: anAnnouncementClass do: aBlock
]

{ #category : #'event handling' }
CpDomElement >> when: anAnnouncementClass send: aSymbol to: anObject [

	"Let the sender subscribe to the specified announcement of the receiver.
	All CpEvents can also be listened to using this same method.
	CpEvents share the same protocol as Announcements.

	See Announcer>>#when:send:to:"

	^ self announcer when: anAnnouncementClass send: aSymbol to: anObject
]
