Class {
	#name : #Fui2Element,
	#superclass : #CpHtmlElement,
	#category : #'CodeParadise-WebApplication-Fomantic-Elements'
}

{ #category : #accessing }
Fui2Element class >> allStates [

	"Answer a collection (of Symbols) representing all states of the receiver"

	^ #()
]

{ #category : #accessing }
Fui2Element class >> allTypes [

	"Answer a collection (of Symbols) representing all types of the receiver"

	^ #()
]

{ #category : #accessing }
Fui2Element class >> allVariations [

	"Answer a collection (of Symbols) representing all variations of the receiver"

	^ #()
]

{ #category : #'private - accessing' }
Fui2Element >> addClass: aSymbol at: usageIndex [

	"Add a HTML class name (aSymbol) to the receiver at the specified usage index.
	HTML classes are stored per usage (Type, State and Variation).
	If the receiver already has the class specified, nothing happens."

	self addClass: aSymbol rejecting: #() at: usageIndex
]

{ #category : #'private - accessing' }
Fui2Element >> addClass: aSymbol rejecting: aCollection at: usageIndex [

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
self crTrace: aSymbol, ' classesChanged ', classesChanged printString.
	"Update receiver's class attribute (if changed)"
	classesChanged
		ifFalse: [ ^ self ].
	classes at: usageIndex put: usageClasses.
	self classes: classes
]

{ #category : #'accessing - state' }
Fui2Element >> addState: aSymbol [

	"Add specified state to the receiver"

	self addClass: aSymbol at: 2
]

{ #category : #'accessing - type' }
Fui2Element >> addType: aSymbol [

	"Add specified type to the receiver"

	self addClass: aSymbol at: 1
]

{ #category : #'accessing - variation' }
Fui2Element >> addVariation: aSymbol [

	"Add specified variation to the receiver"

	self addClass: aSymbol at: 3
]

{ #category : #'private - accessing' }
Fui2Element >> classes [

	"Answer an Array with an OrderedCollection of class names (Symbols) of the receiver as elements.
	The Array has 3 elements for class names representing Type, States and Variations (with values
	as defined by Fomantic docs).

	For example the tag <div class='ui read-only checked slider checkbox'>...</div> will result in:
		Array
			with: (OrderedCollection with: #slider)
			with: (OrderedCollection with: #'read-only' with: #checked)
			with: (OrderedCollection new).

	This means the element has Type: #slider, States: #'read-only' and #checked and no Variation.
	"

	^ self classesFrom: ((self attributeAt: #class) ifNil: [ '' ])

]

{ #category : #'private - accessing' }
Fui2Element >> classes: anArray [

	"Update the HTML class attribute of the receiver using the class names
	specified. anArray should have 3 elements each being an OrderedCollection
	with class names (Symbols).

	The result is a class attribute following the rule:
		'ui <type-name> <state-name1> ... <state-nameX> <variation-name1> ... <variation-nameY> <type>'

	The previous order is not strictly necessary, but beware that some State or Variation
	classes can consist of two names like 'left icon' or 'very padded'.

	<type-name> is typically a subtype (like a #slider for main type #checkbox).
	All three Type, State and Variation classes can be empty (ie have default values).
	"

	self attributeAt: #class put: (String streamContents: [ :stream |
		stream nextPutAll: 'ui'.
		self
			printClasses: (anArray at: 1) on: stream ;
			printClasses: (anArray at: 2) on: stream ;
			printClasses: (anArray at: 3) on: stream.
		stream
			space ;
			nextPutAll: self class type ])
]

{ #category : #'private - accessing' }
Fui2Element >> classesFrom: aString [

	| classes readStream |

	classes := Array
		with: OrderedCollection new		"Type"
		with: OrderedCollection new		"States"
		with: OrderedCollection new.	"Variations"

	readStream := ReadStream on: (aString findTokens: ' ').
	[ readStream atEnd ] whileFalse: [

		| token |

		token := readStream lookAheadAt: 1.
		(token = 'ui' or: [ token = self class type ])
			ifTrue: [ readStream skip ]
			ifFalse: [
				(self storeClassFrom: token into: classes)
					ifTrue: [ readStream skip ]
					ifFalse: [

						"Token might be combined token like 'left icon' or 'very padded'"
						token := token, ' ', (readStream lookAheadAt: 2).
						(self storeClassFrom: token into: classes)
							ifTrue: [ readStream skip: 2 ]
							ifFalse: [

								"Unknown token"
								self crTrace: 'Unknown class "', readStream peek, '" for Fomantic UI element ', self class type.
								readStream skip ] ] ] ].

	^ classes
]

{ #category : #'private - behavior' }
Fui2Element >> performOnElement: behavior [

	"Perform the specified behavior (a Dictionary or Symbol) on the receiver's element"

	^ self performOnElement: behavior as: self class type
]

{ #category : #'private - behavior' }
Fui2Element >> performOnElement: behavior as: type [

	"Perform the specified behavior (a Dictionary or Symbol) on the receiver's element with the specified type (a Symbol)"

	<primitive: 'primitiveFUIElementPerformOnElement:as:' module: 'CpFomanticPlugin'>
	self primitiveFailed

]

{ #category : #'private - accessing' }
Fui2Element >> printClasses: aCollection on: aStream [

	"Print all HTML class names (Symbols) in the Collection on the specified stream"

	aCollection do: [ :each |
		aStream
			nextPut: Character space ; 
			nextPutAll: each ]
]

{ #category : #'private - accessing' }
Fui2Element >> removeClass: aSymbol at: usageIndex [

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

{ #category : #'accessing - state' }
Fui2Element >> removeState: aSymbol [

	"Remove specified state from the receiver"

	self removeClass: aSymbol at: 2
]

{ #category : #'accessing - type' }
Fui2Element >> removeType: aSymbol [

	"Remove specified type from the receiver"

	self removeClass: aSymbol at: 1
]

{ #category : #'accessing - variation' }
Fui2Element >> removeVariation: aSymbol [

	"Remove specified variation from the receiver"

	self removeClass: aSymbol at: 3

]

{ #category : #'accessing - state' }
Fui2Element >> setState: aSymbol ofStates: aCollection [

	"Add specified state to the receiver replacing any occurence of states
	as specified (aCollection of Symbols). This is to set a state from a collection
	of mutually exclusive states."

	self addClass: aSymbol rejecting: aCollection at: 2
]

{ #category : #'accessing - type' }
Fui2Element >> setType: aSymbol ofTypes: aCollection [

	"Add specified type to the receiver replacing any occurence of types
	as specified (aCollection of Symbols). This is to set a type from a collection
	of mutually exclusive types."

	self addClass: aSymbol rejecting: aCollection at: 1
]

{ #category : #'accessing - variation' }
Fui2Element >> setVariation: aSymbol ofVariations: aCollection [

	"Add specified variation to the receiver replacing any occurence of variation
	as specified (aCollection of Symbols). This is to set a variation from a collection
	of mutually exclusive variations."

	self addClass: aSymbol rejecting: aCollection at: 3

]

{ #category : #'accessing - state' }
Fui2Element >> states [

	"Answer the state values of the receiver"

	^ self classes at: 2
]

{ #category : #'private - accessing' }
Fui2Element >> storeClassFrom: aString into: classes [

	| className |

	className := aString asSymbol.

	(self class allTypes includes: className)
		ifTrue: [
			(classes at: 1) add: className.
			^ true ]
		ifFalse: [
			(self class allStates includes: className)
				ifTrue: [
					(classes at: 2) add: className.
					^ true ]
				ifFalse: [
					(self class allVariations includes: className)
						ifTrue: [
							(classes at: 3) add: className.
							^ true ] ] ].

	^ false
]

{ #category : #'accessing - type' }
Fui2Element >> types [

	"Answer the type values of the receiver"

	^ self classes at: 1
]

{ #category : #'accessing - variation' }
Fui2Element >> variations [

	"Answer the variation values of the receiver"

	^ self classes at: 3
]
