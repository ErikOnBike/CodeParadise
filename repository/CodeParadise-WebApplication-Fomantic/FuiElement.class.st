Class {
	#name : 'FuiElement',
	#superclass : 'CpHtmlElement',
	#category : 'CodeParadise-WebApplication-Fomantic-Elements',
	#package : 'CodeParadise-WebApplication-Fomantic',
	#tag : 'Elements'
}

{ #category : 'accessing' }
FuiElement class >> allStates [

	"Answer a collection (of Symbols) representing all states of the receiver"

	^ #()
]

{ #category : 'accessing' }
FuiElement class >> allTypes [

	"Answer a collection (of Symbols) representing all types of the receiver"

	^ #()
]

{ #category : 'accessing' }
FuiElement class >> allVariations [

	"Answer a collection (of Symbols) representing all variations of the receiver"

	^ #()
]

{ #category : 'accessing' }
FuiElement class >> baseElementTagName [

	"Answer the HTML element tag name the receiver is based upon.
	Preferably use a Symbol here, to reduce number of object instances.
	Eg: #div or #span or #button"

	self subclassResponsibility
]

{ #category : 'accessing' }
FuiElement class >> cssSelector [

	"Answer the CSS selector (a String) which specifies the receiver should
	be used as representation for DOM elements matching that CSS selector"

	^ '.ui.', self elementName
]

{ #category : 'accessing' }
FuiElement class >> elementClass [

	"Answer the minimal CSS class representing the receiver
	(ie no Types, States or Variations are taken into account)"

	^ 'ui ', self elementName
]

{ #category : 'accessing' }
FuiElement class >> elementName [

	"Answer the (Fomantic) name of the receiver.
	Current implementation assumes the Class name represents the element name.
	Eg: FuiButton -> button, FuiInput -> input"

	<primitive: 'primitiveFuiElementElementName' module: 'CpFomanticPlugin'>
	self primitiveFailed

]

{ #category : 'class initialization' }
FuiElement class >> installFomanticPlugin [

	"Install the Fomantic plugin which allows HTML elements to be
	mapped to Smalltalk classes"

	CpHtmlElement documentAddScript: '"use strict";
		Squeak.registerExternalModule("CpFomanticPlugin", {
			getModuleName: function() {  return "CpFomanticPlugin"; },
			interpreterProxy: null,
			domPlugin: null,
			elementClassMap: [],
			setInterpreter: function(anInterpreter) {
				this.interpreterProxy = anInterpreter;
				this.domPlugin = Squeak.externalModules.CpDOMPlugin;
				this.systemPlugin = Squeak.externalModules.CpSystemPlugin;

				// Add element class mapper which allows to specify which Smalltalk class
				// represents a given DOM element
				let elementClassMap = this.elementClassMap;
				this.domPlugin.addElementClassMapper(function(domElement) {
					let classList = domElement.classList;
					if(classList && classList.contains("ui")) {
						for(let i = 0; i < elementClassMap.length; i++) {
							if(classList.contains(elementClassMap[i].elementName)) {
								// Answer Smalltalk class
								return elementClassMap[i].elementClass;
							}
						}
					}
					return null;
				});
				return true;
			},
			elementNameFromClass: function(fuiElementClass) {
				return fuiElementClass.className().replace(/^Fui/, "").toLowerCase();
			},
			withJQuery: function(callback) {
				// jQuery and Fomantic might not be loaded yet, retry until loaded
				if(window.jQuery && window.jQuery.prototype.calendar) {
					return callback(window.jQuery);
				} else {
					console.debug("Waiting for Fomantic library to load");
					let thisHandle = this;
					window.setTimeout(function() {
						thisHandle.withJQuery(callback);
					}, 100);
				}
			},
			"primitiveFuiElementElementName": function(argCount) {
				if(argCount !== 0) return false;
				let receiver = this.interpreterProxy.stackValue(argCount);
				let elementName = this.elementNameFromClass(receiver);
				return this.domPlugin.answer(argCount, elementName);
			},
			"primitiveFuiElementRegister": function(argCount) {
				if(argCount !== 0) return false;
				let receiver = this.interpreterProxy.stackValue(argCount);
				let elementName = this.elementNameFromClass(receiver);
				this.elementClassMap.push({ elementName: elementName, elementClass: receiver });
				this.domPlugin.answerSelf(argCount);
			},
			"primitiveFuiElementNewWithTag:": function(argCount) {
				if(argCount !== 1) return false;
				let tagName = this.interpreterProxy.stackValue(0).asString();
				if(!tagName) return false;
				let receiver = this.interpreterProxy.stackValue(argCount);

				// Create DOM element with the CSS class (denoting its type) of the receiver
				let domElement = document.createElement(tagName);
				domElement.setAttribute("class", "ui " + this.elementNameFromClass(receiver));

				// Answer instance through DOM plugin since it will cache instances					
				return this.domPlugin.answer(argCount, this.domPlugin.instanceForElement(domElement));
			},
			"primitiveFuiElementPerformOnElement:as:": function(argCount) {
				if(argCount !== 2) return false;
				let properties = this.systemPlugin.asJavascriptObject(this.interpreterProxy.stackValue(1));
				let elementName = this.interpreterProxy.stackValue(0).asString();
				if(!elementName) return false;
				let receiver = this.interpreterProxy.stackValue(argCount);

				// Perform behavior
				let result = this.withJQuery(function(jQuery) {
					let jQueryElement = jQuery(receiver.domElement);
					try {
						return jQueryElement[elementName](properties);
					} catch(e) {
						throw Error("Unsupported elementName " + elementName + " or error " + e.message);
					}
				});

				// If result looks like the component itself, answer "self"
				if(typeof result[elementName] === "function") {
					result = receiver;
				}
				return this.domPlugin.answer(argCount, result);
			}
		});'
]

{ #category : 'class initialization' }
FuiElement class >> loadFomantic [

	"Load Fomantic library ("

	CpHtmlElement
		documentAddExternalScript: 'https://cdn.jsdelivr.net/npm/jquery@3.3.1/dist/jquery.min.js' ;
		documentAddStylesheet: 'https://cdn.jsdelivr.net/npm/fomantic-ui@2.8.7/dist/semantic.min.css' ;
		documentAddExternalScript: 'https://cdn.jsdelivr.net/npm/fomantic-ui@2.8.7/dist/semantic.min.js'
]

{ #category : 'instance creation' }
FuiElement class >> new [

	"Answer a new instance of the receiver.

	Beware: do NOT use CpDomElement >> #newWithTag: to create Fomantic instances manually.
	This does not work properly. FuiElement has a special #newWithTag: implementation."

	^ self newWithTag: self baseElementTagName
]

{ #category : 'class initialization' }
FuiElement class >> newWithTag: aString [

	"Create a new instance of the receiver using the specified tag"

	<primitive: 'primitiveFuiElementNewWithTag:' module: 'CpFomanticPlugin'>
	self primitiveFailed

]

{ #category : 'class initialization' }
FuiElement class >> postInstall [

	super postInstall.

	self = FuiElement
		ifTrue: [ self loadFomantic ; installFomanticPlugin ]
		ifFalse: [ self register ]
]

{ #category : 'class initialization' }
FuiElement class >> register [

	"Register the receiver as a Fomantic element"

	<primitive: 'primitiveFuiElementRegister' module: 'CpFomanticPlugin'>
	self primitiveFailed

]

{ #category : 'private - accessing' }
FuiElement class >> storeClassFrom: aString into: classes [

	"Store the specified CSS class into the Array of classes
	(indexed 1 -> Types, 2 -> States, 3 -> Variations).
	Answer a Boolean stating whether the specified CSS class is recognized and
	stored appropriately."

	| className |

	className := aString asSymbol.

	(self allTypes includes: className)
		ifTrue: [
			(classes at: 1) add: className.
			^ true ]
		ifFalse: [
			(self allStates includes: className)
				ifTrue: [
					(classes at: 2) add: className.
					^ true ]
				ifFalse: [
					(self allVariations includes: className)
						ifTrue: [
							(classes at: 3) add: className.
							^ true ] ] ].

	^ false
]

{ #category : 'private - accessing' }
FuiElement >> addClass: aSymbol at: usageIndex [

	"Add a HTML class name (aSymbol) to the receiver at the specified usage index.
	HTML classes are stored per usage (Type, State and Variation).
	If the receiver already has the class specified, nothing happens."

	self addClass: aSymbol rejecting: #() at: usageIndex
]

{ #category : 'private - accessing' }
FuiElement >> addClass: aSymbol rejecting: aCollection at: usageIndex [

	"Add a HTML class name (aSymbol) to the receiver at the specified usage index.
	Reject any existing classes within aCollection (representing mutually
	exclusive values).
	HTML class names are stored per usage (Type, State and Variation).
	If the receiver already has the class name specified, nothing happens."

	| classes usageClasses classesChanged |

	classes := self classes.
	usageClasses := classes at: usageIndex.

	"First remove any existing (mutually exclusive) class values"
	aCollection
		ifNotEmpty: [ usageClasses := usageClasses reject: [ :each | aCollection includes: each ] ].
	classesChanged := (classes at: usageIndex) size ~= usageClasses size.

	"Add class if not already present"
	(aSymbol notNil and: [ (usageClasses includes: aSymbol) not ])
		ifTrue: [
			usageClasses add: aSymbol.
			classesChanged := true ].

	"Update receiver's class attribute (if changed)"
	classesChanged
		ifFalse: [ ^ self ].
	classes at: usageIndex put: usageClasses.
	self classes: classes
]

{ #category : 'accessing - state' }
FuiElement >> addState: aSymbol [

	"Add specified state to the receiver"

	self addClass: aSymbol at: 2
]

{ #category : 'accessing - type' }
FuiElement >> addType: aSymbol [

	"Add specified type to the receiver"

	self addClass: aSymbol at: 1
]

{ #category : 'accessing - variation' }
FuiElement >> addVariation: aSymbol [

	"Add specified variation to the receiver"

	self addClass: aSymbol at: 3
]

{ #category : 'private - accessing' }
FuiElement >> classes [

	"Answer an Array with an OrderedCollection of class names (Symbols) of the receiver as elements.
	The Array has 3 elements for class names representing Type, States and Variations (with values
	as defined by Fomantic docs).

	For example the tag <div class='ui checkbox read-only checked slider'>...</div> will result in:
		Array
			with: (OrderedCollection with: #slider)
			with: (OrderedCollection with: #'read-only' with: #checked)
			with: (OrderedCollection new).

	This means the element has Type: #slider, States: #'read-only' and #checked and no Variation.
	"

	^ self classesFrom: ((self attributeAt: #class) ifNil: [ '' ])

]

{ #category : 'private - accessing' }
FuiElement >> classes: anArray [

	"Update the HTML class attribute of the receiver using the class names
	specified. anArray should have 3 elements each being an OrderedCollection
	with class names (Symbols).

	The result is a class attribute following the rule:
		'ui <type> <type-name> <state-name1> ... <state-nameX> <variation-name1> ... <variation-nameY>'

	The previous order is not strictly necessary, but beware that some State or Variation
	classes can consist of two names like 'left icon' or 'very padded'.

	<type-name> is typically a subtype (like a #slider for main type #checkbox).
	All three Type, State and Variation classes can be empty (ie have default values).
	"

	self attributeAt: #class put: (String streamContents: [ :stream |
		stream nextPutAll: self class elementClass.

		"Add Types, States. Variations"
		self
			printClasses: (anArray at: 1) on: stream ;
			printClasses: (anArray at: 2) on: stream ;
			printClasses: (anArray at: 3) on: stream ])
]

{ #category : 'private - accessing' }
FuiElement >> classesFrom: aString [

	| classes readStream |

	classes := Array
		with: OrderedCollection new		"Type"
		with: OrderedCollection new		"States"
		with: OrderedCollection new.	"Variations"

	readStream := ReadStream on: (aString findTokens: ' ').
	[ readStream atEnd ] whileFalse: [

		| token |

		token := readStream lookAheadAt: 0.
		(token = 'ui' or: [ token = self class elementName ])
			ifTrue: [ readStream skip ]
			ifFalse: [
				(self storeClassFrom: token into: classes)
					ifTrue: [ readStream skip ]
					ifFalse: [

						"Token might be combined token like 'left icon' or 'very padded'"
						token := token, ' ', (readStream lookAheadAt: 1) printString.
						(self storeClassFrom: token into: classes)
							ifTrue: [ readStream skip: 2 ]
							ifFalse: [

								"Unknown token"
								self crTrace: 'Unknown class "', readStream peek printString, '" for Fomantic UI element ', self class elementName.
								readStream skip ] ] ] ].

	^ classes
]

{ #category : 'private - testing' }
FuiElement >> hasClass: aSymbol at: usageIndex [

	"Answer whether a HTML class name (aSymbol) is present on the receiver
	at the specified usage index.
	HTML class names are stored per usage (Type, State and Variation)."

	^ (self classes at: usageIndex)
		includes: aSymbol
]

{ #category : 'testing - variation' }
FuiElement >> hasVariation: aSymbol [

	"Answer whether the receiver is in the specified variation"

	^ self hasClass: aSymbol at: 3
]

{ #category : 'testing - state' }
FuiElement >> isInState: aSymbol [

	"Answer whether the receiver is in the specified state"

	^ self hasClass: aSymbol at: 2
]

{ #category : 'testing - type' }
FuiElement >> isType: aSymbol [

	"Answer whether the receiver is in the specified type"

	^ self hasClass: aSymbol at: 1
]

{ #category : 'private - behavior' }
FuiElement >> performOnElement: behavior [

	"Perform the specified behavior (a Dictionary or Symbol) on the receiver's element"

	^ self performOnElement: behavior as: self class elementName
]

{ #category : 'private - behavior' }
FuiElement >> performOnElement: behavior as: type [

	"Perform the specified behavior (a Dictionary or Symbol) on the receiver's element with the specified type (a Symbol)"

	<primitive: 'primitiveFuiElementPerformOnElement:as:' module: 'CpFomanticPlugin'>
	self primitiveFailed

]

{ #category : 'private - accessing' }
FuiElement >> printClasses: aCollection on: aStream [

	"Print all HTML class names (Symbols) in the Collection on the specified stream"

	aCollection do: [ :each |
		aStream
			nextPut: Character space ; 
			nextPutAll: each ]
]

{ #category : 'private - accessing' }
FuiElement >> removeClass: aSymbol at: usageIndex [

	"Remove a HTML class name (aSymbol) from the receiver at the specified usage index.
	HTML class names are stored per usage (Type, State and Variation).
	If the receiver does not have the class specified, nothing happens."

	| classes usageClasses |
	
	classes := self classes.
	usageClasses := classes at: usageIndex.

	"Remove and update the receiver's class attribute (if changed)"
	usageClasses remove: aSymbol ifAbsent: [ ^ self ].
	classes at: usageIndex put: usageClasses.
	self classes: classes
]

{ #category : 'accessing - state' }
FuiElement >> removeState: aSymbol [

	"Remove specified state from the receiver"

	self removeClass: aSymbol at: 2
]

{ #category : 'accessing - type' }
FuiElement >> removeType: aSymbol [

	"Remove specified type from the receiver"

	self removeClass: aSymbol at: 1
]

{ #category : 'accessing - variation' }
FuiElement >> removeVariation: aSymbol [

	"Remove specified variation from the receiver"

	self removeClass: aSymbol at: 3

]

{ #category : 'accessing - variation' }
FuiElement >> removeVariations: aCollection [

	"Remove specified variations from the receiver"

	self addClass: nil rejecting: aCollection at: 3
]

{ #category : 'accessing - state' }
FuiElement >> setState: aSymbol ofStates: aCollection [

	"Add specified state to the receiver replacing any occurence of states
	as specified (aCollection of Symbols). This is to set a state from a collection
	of mutually exclusive states."

	self addClass: aSymbol rejecting: aCollection at: 2
]

{ #category : 'accessing - type' }
FuiElement >> setType: aSymbol ofTypes: aCollection [

	"Add specified type to the receiver replacing any occurence of types
	as specified (aCollection of Symbols). This is to set a type from a collection
	of mutually exclusive types."

	self addClass: aSymbol rejecting: aCollection at: 1
]

{ #category : 'accessing - variation' }
FuiElement >> setVariation: aSymbol ofVariations: aCollection [

	"Add specified variation to the receiver replacing any occurence of variation
	as specified (aCollection of Symbols). This is to set a variation from a collection
	of mutually exclusive variations."

	self addClass: aSymbol rejecting: aCollection at: 3

]

{ #category : 'accessing - state' }
FuiElement >> states [

	"Answer the state values of the receiver"

	^ self classes at: 2
]

{ #category : 'private - accessing' }
FuiElement >> storeClassFrom: aString into: classes [

	^ self class storeClassFrom: aString into: classes
]

{ #category : 'accessing - type' }
FuiElement >> types [

	"Answer the type values of the receiver"

	^ self classes at: 1
]

{ #category : 'accessing - variation' }
FuiElement >> variations [

	"Answer the variation values of the receiver"

	^ self classes at: 3
]
