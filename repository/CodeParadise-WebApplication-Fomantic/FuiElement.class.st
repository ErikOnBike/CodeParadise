Class {
	#name : #FuiElement,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'classes'
	],
	#category : #'CodeParadise-WebApplication-Fomantic-Elements'
}

{ #category : #'web resources' }
FuiElement class >> style [

	<webResource: #css>

	^ '@import "https://cdn.jsdelivr.net/npm/fomantic-ui@2.8.6/dist/semantic.min.css";'
]

{ #category : #accessing }
FuiElement class >> type [

	"Answer a Symbol specifying the (Javascript) type of the receiver"

	self subclassResponsibility
]

{ #category : #'private - accessing' }
FuiElement >> addClass: aSymbol at: usageIndex [

	"Add a DOM class (aSymbol) to the receiver at the specified index.
	DOM classes are stored per usage (State, Type and Variation).
	If the receiver already has the class specified, nothing happens.

	Implementation: see #addClass:rejecting:at:"

	self addClass: aSymbol rejecting: #() at: usageIndex
]

{ #category : #'private - accessing' }
FuiElement >> addClass: aSymbol rejecting: aCollection at: usageIndex [

	"Add a DOM class (aSymbol) to the receiver at the specified index.
	Reject any existing classes within aCollection (representing mutually
	exclusive values).
	DOM classes are stored per usage (State, Type and Variation).
	If the receiver already has the class specified, nothing happens.

	Implementation:
	Use an OrderedCollection instead of a Set because the number of elements will be low
	and a Set will be too heavy. 
	Use lazy initialization to keep Object instantiation limited."

	| usageClasses |

	classes ifNil: [ classes := Array new: 3 ].

	(usageClasses := classes at: usageIndex)
		ifNil: [

			"No classes present, simply add new collection containing the requested value"
			aSymbol
				ifNotNil: [ classes at: usageIndex put: (OrderedCollection with: aSymbol) ].
			^ self ].

	"First remove any existing (mutually exclusive) class values"
	aCollection ifNotEmpty: [
		usageClasses := usageClasses reject: [ :each | aCollection includes: each ].
		classes at: usageIndex put: usageClasses ].

	"Add class if not already present"
	aSymbol ifNil: [ ^ self ].
	(usageClasses includes: aSymbol)
		ifFalse: [ usageClasses add: aSymbol ]
]

{ #category : #'accessing - state' }
FuiElement >> addState: aSymbol [

	"Add specified state to the receiver"

	self addState: aSymbol deferUpdates: false
]

{ #category : #'accessing - state' }
FuiElement >> addState: aSymbol deferUpdates: aBoolean [

	"Add specified state to the receiver.
	Update the DOM as specified (only update if aBoolean is false)."

	self addClass: aSymbol at: 1.
	aBoolean ifFalse: [ self updateDom ]
]

{ #category : #'accessing - type' }
FuiElement >> addType: aSymbol [

	"Add specified type to the receiver"

	self addType: aSymbol deferUpdates: false
]

{ #category : #'accessing - type' }
FuiElement >> addType: aSymbol deferUpdates: aBoolean [

	"Add specified type to the receiver.
	Update the DOM as specified (only update if aBoolean is false)."

	self addClass: aSymbol at: 2.
	aBoolean ifFalse: [ self updateDom ]
]

{ #category : #'accessing - variation' }
FuiElement >> addVariation: aSymbol [

	"Add specified variation to the receiver"

	self addVariation: aSymbol deferUpdates: false
]

{ #category : #'accessing - variation' }
FuiElement >> addVariation: aSymbol deferUpdates: aBoolean [

	"Add specified variation to the receiver.
	Update the DOM as specified (only update if aBoolean is false)."

	self addClass: aSymbol at: 3.
	aBoolean ifFalse: [ self updateDom ]
]

{ #category : #accessing }
FuiElement >> announcer [

	^ announcer
]

{ #category : #'private - accessing' }
FuiElement >> classesAt: usageIndex [

	"Answer the DOM classes (Collection of Symbols) of the receiver at the specified index.
	DOM classes are stored per usage (State, Type and Variation).
	DO NOT modify the result of this method. Use #addClass:at: or #removeClass:at: instead.

	Implementation: see comment in #addClass:rejecting:at:"

	classes ifNil: [ ^ #() ].

	^ (classes at: usageIndex) ifNil: [ #() ]
]

{ #category : #initialization }
FuiElement >> initialize [

	super initialize.

	announcer := Announcer new
]

{ #category : #'private - behavior' }
FuiElement >> performOnElement: behavior [

	"Perform the specified behavior (a Dictionary or Symbol) on the receiver's element"

	^ self performOnElement: behavior as: self class type
]

{ #category : #'private - behavior' }
FuiElement >> performOnElement: behavior as: type [

	"Perform the specified behavior (a Dictionary or Symbol) on the receiver's element with the specified type (a Symbol)"

	<primitive: 'primitiveFUIElementPerformOnElement:as:' module: 'CpFomanticPlugin'>
	self primitiveFailed

]

{ #category : #'private - accessing' }
FuiElement >> printClassesAt: usageIndex on: aStream [

	"Print all DOM classes (Symbols) of the receiver at the specified index.
	DOM classes are stored per usage (State, Type and Variation).

	Implementation: see comment in #addClass:rejecting:at:"

	self withClassesAt: usageIndex do: [ :each |
		aStream
			nextPut: Character space ; 
			nextPutAll: each ]
]

{ #category : #initialization }
FuiElement >> release [

	announcer ifNotNil: [
		announcer subscriptions reset.
		announcer := nil ].
	classes := nil.

	super release
]

{ #category : #'private - accessing' }
FuiElement >> removeClass: aSymbol at: usageIndex [

	"Remove a DOM class (aSymbol) from the receiver at the specified index.
	DOM classes are stored per usage (State, Type and Variation).
	If the receiver does not have the class specified, nothing happens.

	Implementation: see comment in #addClass:rejecting:at:"

	classes ifNil: [ ^ self ].

	(classes at: usageIndex)
		ifNotNil: [ :usageClasses | usageClasses remove: aSymbol ifAbsent: [ "ignore absence" ] ]
]

{ #category : #'accessing - state' }
FuiElement >> removeState: aSymbol [

	"Remove specified state from the receiver"

	self removeState: aSymbol deferUpdates: false
]

{ #category : #'accessing - state' }
FuiElement >> removeState: aSymbol deferUpdates: aBoolean [

	"Remove specified state from the receiver.
	Update the DOM as specified (only update if aBoolean is false)."

	self removeClass: aSymbol at: 1.
	aBoolean ifFalse: [ self updateDom ]
]

{ #category : #'accessing - type' }
FuiElement >> removeType: aSymbol [

	"Remove specified type from the receiver"

	self removeType: aSymbol deferUpdates: false
]

{ #category : #'accessing - type' }
FuiElement >> removeType: aSymbol deferUpdates: aBoolean [

	"Remove specified type from the receiver.
	Update the DOM as specified (only update if aBoolean is false)."

	self removeClass: aSymbol at: 2.
	aBoolean ifFalse: [ self updateDom ]
]

{ #category : #'accessing - variation' }
FuiElement >> removeVariation: aSymbol [

	"Remove specified variation from the receiver"

	self removeVariation: aSymbol deferUpdates: false
]

{ #category : #'accessing - variation' }
FuiElement >> removeVariation: aSymbol deferUpdates: aBoolean [

	"Remove specified variation from the receiver.
	Update the DOM as specified (only update if aBoolean is false)."

	self removeClass: aSymbol at: 3.
	aBoolean ifFalse: [ self updateDom ]
]

{ #category : #'accessing - state' }
FuiElement >> setState: aSymbol ofStates: aCollection [

	"Add specified state to the receiver replacing any occurence of states
	as specified (aCollection of Symbols). This is to set a state from a collection
	of mutually exclusive states."

	self setState: aSymbol ofStates: aCollection deferUpdates: false
]

{ #category : #'accessing - state' }
FuiElement >> setState: aSymbol ofStates: aCollection deferUpdates: aBoolean [

	"Add specified state to the receiver replacing any occurence of states
	as specified (aCollection of Symbols). This is to set a state from a collection
	of mutually exclusive states.
	Update the DOM as specified (only update if aBoolean is false)."

	self addClass: aSymbol rejecting: aCollection at: 1.
	aBoolean ifFalse: [ self updateDom ]
]

{ #category : #'accessing - type' }
FuiElement >> setType: aSymbol ofTypes: aCollection [

	"Add specified type to the receiver replacing any occurence of types
	as specified (aCollection of Symbols). This is to set a type from a collection
	of mutually exclusive types."

	self setType: aSymbol ofTypes: aCollection deferUpdates: false
]

{ #category : #'accessing - type' }
FuiElement >> setType: aSymbol ofTypes: aCollection deferUpdates: aBoolean [

	"Add specified type to the receiver replacing any occurence of types
	as specified (aCollection of Symbols). This is to set a type from a collection
	of mutually exclusive types.
	Update the DOM as specified (only update if aBoolean is false)."

	self addClass: aSymbol rejecting: aCollection at: 2.
	aBoolean ifFalse: [ self updateDom ]
]

{ #category : #'accessing - variation' }
FuiElement >> setVariation: aSymbol ofVariations: aCollection [

	"Add specified variation to the receiver replacing any occurence of variation
	as specified (aCollection of Symbols). This is to set a variation from a collection
	of mutually exclusive variations."

	self setVariation: aSymbol ofVariations: aCollection deferUpdates: false 
]

{ #category : #'accessing - variation' }
FuiElement >> setVariation: aSymbol ofVariations: aCollection deferUpdates: aBoolean [

	"Add specified variation to the receiver replacing any occurence of variation
	as specified (aCollection of Symbols). This is to set a variation from a collection
	of mutually exclusive variations.
	Update the DOM as specified (only update if aBoolean is false)."

	self addClass: aSymbol rejecting: aCollection at: 3.
	aBoolean ifFalse: [ self updateDom ]
]

{ #category : #accessing }
FuiElement >> shadowElement [

	"Answer the shadow DOM's element (this is the first element within the shadow DOM) of the receiver"

	<primitive: 'primitiveFUIElementShadowElement' module: 'CpFomanticPlugin'>
	self primitiveFailed

]

{ #category : #'accessing - state' }
FuiElement >> states [

	"Answer the state values of the receiver"

	^ self classesAt: 1
]

{ #category : #'accessing - type' }
FuiElement >> types [

	"Answer the type values of the receiver"

	^ self classesAt: 2
]

{ #category : #updating }
FuiElement >> updateDom [

	"Update the DOM of the receiver based on its state.
	Fomantic's visual state is specified by an element's class attribute.
	Therefore update the class attribute of the receiver.
	DOM classes are stored per usage (State, Type and Variation).

	Implementation: see comment in #addClass:at:"

	self shadowElement attributeAt: #class put: (String streamContents: [ :stream |
		stream nextPutAll: 'ui'.
		self
			printClassesAt: 1 on: stream ;
			printClassesAt: 2 on: stream ;
			printClassesAt: 3 on: stream.
		stream
			space ;
			nextPutAll: self class type ])
]

{ #category : #'accessing - variation' }
FuiElement >> variations [

	"Answer the variation values of the receiver"

	^ self classesAt: 3
]

{ #category : #'private - accessing' }
FuiElement >> withClassesAt: usageIndex do: aBlock [

	"Evaluate the specified block for all DOM classes (Symbols) of the receiver at the specified index.
	DOM classes are stored per usage (State, Type and Variation).

	Implementation: see comment in #addClass:rejecting:at:"

	classes ifNil: [ ^ self ].

	(classes at: usageIndex)
		ifNotNil: [ :usageClasses | usageClasses do: aBlock ]
]
