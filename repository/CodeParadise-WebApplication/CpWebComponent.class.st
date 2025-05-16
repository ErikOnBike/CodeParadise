"
I am a HTML element and I represent a WebComponent aka a CustomElement.
See https://developer.mozilla.org/en-US/docs/Web/Web_Components 

I register myself with the browser so my instances can be created using a custom tag name. This tag name is based on my (class) name. See #tagName.

In contrast with my superclass CpDomElement I do allow text content to be set (using #textContent:) while preserving
slotted Elements (not being the default/unnamed slot). Since it is not possible to specify a slot for text content
(ie it does not have a tag to specify the slot name in), there is no method to set the text content for a slot.
Use a HTML element (like <span>) to create an element which can be slotted and give it the required text content.
Eg. through: myComponent appendChild: 'Hello world' asHtmlElement atSlotNamed: #mySlot

"
Class {
	#name : #CpWebComponent,
	#superclass : #CpHtmlElement,
	#category : #'CodeParadise-WebApplication-DOM'
}

{ #category : #accessing }
CpWebComponent class >> all [

	"Answer a collection containing all instances of the receiver in the current document"

	^ self document
		allDescendantsMatching: self asCssSelector
]

{ #category : #converting }
CpWebComponent class >> asCssSelector [

	^ self tagName

]

{ #category : #'instance creation' }
CpWebComponent class >> basicNew [

	"Answer a new (non-initialized) basic instance of the receiver"

	^ self basicNewWithTag: self tagName
]

{ #category : #'instance creation' }
CpWebComponent class >> content: anElement [

	"Answer a new instance of the receiver with the specified DOM element content"

	^ self new
		appendChild: anElement ;
		yourself
]

{ #category : #accessing }
CpWebComponent class >> first [

	"Answer the first instance of the receiver in the current document
	or nil if none exists"

	^ self document
		firstDescendantMatching: self asCssSelector
]

{ #category : #testing }
CpWebComponent class >> hasAbstractTag [

	^ self classSide includesSelector: #isAbstractTag
]

{ #category : #tags }
CpWebComponent class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #primitives }
CpWebComponent class >> isRegistered: aString [

	"Answer whether the specified tag name (a String) is registered as a WebComponent in the browser
	(relevant for external WebComponent libraries)"

	<primitive: 'primitiveWebComponentIsRegistered:' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #testing }
CpWebComponent class >> isThirdPartyElement [

	"Answer whether the receiver is a third party WebComponent.

	Third party elements don't need a JS constructor (they are provided by the third party library)."

	^ false
]

{ #category : #accessing }
CpWebComponent class >> last [

	"Answer the last instance of the receiver in the current document
	or nil if none exists"

	^ self all
		ifNotEmpty: [ :matches | matches last ]
		ifEmpty: [ nil ]
]

{ #category : #'instance creation' }
CpWebComponent class >> markupContent: aString [

	"Answer a new instance of the receiver with the specified markup content"

	^ self new
		markupContent: aString ;
		yourself
]

{ #category : #'instance creation' }
CpWebComponent class >> new [

	"Answer a new instance of the receiver.
	Although not allowed on the receiver, new instances of the receiver's subclasses
	are allowed to be created, because the receiver knows its own tag."

	self hasAbstractTag
		ifTrue: [ self error: self name, ' is abstract and cannot be instantiated' ].
	CpClientEnvironment isRunning
		ifFalse: [ self error: 'Trying to instantiate a View on the server (maybe a Presenter is expected)' ].

	^ self basicNew
		initialize ;
		yourself
]

{ #category : #'class initialization' }
CpWebComponent class >> postInstall [

	"Register the receiver as a WebComponent in the web browser.

	Implementation:
	During registration a Boolean is provided to indicate whether a
	specific #initialize method is present. This is done to prevent too
	many calls to an 'empty' initialize method. This initialization is
	used when creating instances explicitly in a template or when using
	#markupContent: to create instances through HTML code.
	For third party elements, this mechanism can't be installed because
	we lack access to the elements internals (in general).
	First perform the registration, then proceed with calling super's
	implementation. This ensures that when #postInstallOnce is executed
	the receiver is already registered."

	| hasInitialize |

	self hasAbstractTag
		ifFalse: [

			"The #initialize method is first present on the Object class in the tiny image"
			hasInitialize := (self instanceSide lookupSelector: #initialize) methodClass ~= Object.

			self registerWithInitialize: hasInitialize thirdParty: self isThirdPartyElement ].

	super postInstall
]

{ #category : #primitives }
CpWebComponent class >> registerWithInitialize: initializeBoolean thirdParty: thirdPartyBoolean [

	"Register the receiver as a WebComponent class
	with a Boolean indicating whether the receiver (instances)
	require initialization. This is 'needed' to prevent too many
	calls to an initialization method which does nothing (i.e. the
	default Object >> #initialize).
	The second Boolean provided indicates whether the receiver is from
	a third party library, in which case JS WebComponents do NOT need
	be created, because it is done by the library itself. Also there is
	no generic way to handle #initialize on such objects. It will be
	called when instantiating component specifically, but not when they
	are part of a template."

	<primitive: 'primitiveWebComponentRegisterWithInitialize:thirdParty:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #accessing }
CpWebComponent class >> tagName [

	"Answer a tag name based on the receiver's (ie class) name which will be used
	as tag for the receiver's instances inside the DOM.
	
	DO NOT OVERRIDE this method in subclasses.

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

	^ (self name withoutSuffix: #View) asKebabCase
]

{ #category : #'instance creation' }
CpWebComponent class >> textContent: aString [

	"Answer a new instance of the receiver with the specified text content"

	^ self new
		textContent: aString ;
		yourself
]

{ #category : #accessing }
CpWebComponent class >> whenDefinedAll: aCollection do: aBlock [

	"Perform the specified Block once all the specified WebComponents are defined
	(allowing third-party WebComponents to be present before using them).

	Implementation:
	The method ignores the reference to the CpBrowserCustomElementRegistry
	class to prevent another class from being put into the image. Please
	add this class in the relevant #beLoaded method (either of a specific
	component or more generally in the WebClient class for your application)
	if using this method."

	<ignoreReference: #CpBrowserCustomElementRegistry>
	<ignoreReference: #CpJavaScriptPromise>

	| registry |

	registry := CpBrowserCustomElementRegistry current.

	"Perform Promise.all on the collection of Promises per WebComponent (class)"
	(CpJavaScriptPromise allSettled: (aCollection collect: [ :each | registry whenDefined: each tagName ]))
		then: aBlock
]

{ #category : #accessing }
CpWebComponent class >> whenDefinedDo: aBlock [

	"Perform the specified Block once the receiver is defined
	(allowing third-party WebComponents to be present before using them).

	Implementation:
	The method ignores the reference to the CpBrowserCustomElementRegistry
	class to prevent another class from being put into the image. Please
	add this class in the relevant #beLoaded method (either of a specific
	component or more generally in the WebClient class for your application)
	if using this method."

	<ignoreReference: #CpBrowserCustomElementRegistry>

	(CpBrowserCustomElementRegistry current whenDefined: self tagName)
		then: aBlock
]

{ #category : #private }
CpWebComponent >> allElementsDo: aBlock [

	"Evaluate the specified Block on the receiver and all elements attached to the receiver.
	This means all child elements and the child elements of these child elements.
	It also includes all elements in the Shadow DOM.
	This can include a huge amount of Element. Use with care!"

	self shadowRoot ifNotNil: [ :shadowRoot | shadowRoot allElementsDo: aBlock ].

	super allElementsDo: aBlock
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

{ #category : #copying }
CpWebComponent >> clone [

	"Answer a (deep) clone of the receiver.
	Explicitly set textContent, since this is specific for WebComponents with slots."

	| clone |

	clone := super clone.

	"In case there is no element in the default/unnamed slot, clone text content"
	(clone firstChildAtSlotNamed: nil) ifNil: [
		self textContent ifNotEmpty: [ :text |
			clone textContent: text ] ].

	^ clone
]

{ #category : #querying }
CpWebComponent >> firstChildAtSlotNamed: nameString [

	"Answer the first child element (in document order) of the receiver
	which is located in the specified template slot or nil if no such child is present"

	^ (self childrenAtSlotNamed: nameString)
		ifNotEmpty: [ :children | children first ]
		ifEmpty: [ nil ]
]

{ #category : #testing }
CpWebComponent >> hasTemplate [

	^ false
]

{ #category : #'adding/removing' }
CpWebComponent >> insertChild: childElement before: siblingElement atSlotNamed: nameString [

	"Insert the specified element as child of the receiver before the specified sibling
	and in the specified template slot"

	childElement slot: nameString.
	^ self insertChild: childElement before: siblingElement
]

{ #category : #testing }
CpWebComponent >> isWebComponent [

	^ true
]

{ #category : #querying }
CpWebComponent >> lastChildAtSlotNamed: nameString [

	"Answer the last child element (in document order) of the receiver
	which is located in the specified template slot or nil if no such child is present"

	^ (self childrenAtSlotNamed: nameString)
		ifNotEmpty: [ :children | children last ]
		ifEmpty: [ nil ]
]

{ #category : #querying }
CpWebComponent >> partNamed: aString [

	"Answer the part with the specified name"

	^ self shadowedFirstDescendantMatching: '[part="', aString, '"]'
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

	^ self shadowRoot allDescendantsMatching: cssSelectorString
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

{ #category : #querying }
CpWebComponent >> shadowedWhen: anAnnouncementClass send: aSymbol to: anObject [

	"Add subscription to the shadow DOM for the specified announcement"

	^ self shadowRoot when: anAnnouncementClass send: aSymbol to: anObject
]

{ #category : #content }
CpWebComponent >> textContent [

	"Answer the textual content of the receiver.
	This will answer an aggregated value for all descendants (in the default/unnamed slot).
	Text from Elements slotted in a named slot will not be part of the result."

	<primitive: 'primitiveWebComponentTextContent' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #content }
CpWebComponent >> textContent: aString [

	"Set the text of the receiver to the specified value.
	Any existing content for the default slot is removed, including any child elements (at the
	default/unnamed slot). Elements slotted in a named slot will not be changed."

	<primitive: 'primitiveWebComponentTextContent:' module: 'CpDOMPlugin'>
	self primitiveFailed
]
