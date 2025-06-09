"
I am a PropertySlot for a PropertyModel. I define/describe a single Property within a PropertyModel.
I know my name in the PropertyModel and I maintain a collection of PropertyDefinitions.
"
Class {
	#name : #CynClientPropertySlot,
	#superclass : #Object,
	#instVars : [
		'name',
		'definitions'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #'instance creation' }
CynClientPropertySlot class >> named: aSymbol [

	^ self basicNew
		initializeWithName: aSymbol ;
		yourself
]

{ #category : #accessing }
CynClientPropertySlot class >> propertyCategory [

	"Answer the property category.

	BE AWARE: this will become a selector for a class side method in a PropertyModel."

	self subclassResponsibility
]

{ #category : #comparing }
CynClientPropertySlot >> = anObject [ 

	^ name = anObject name
		and: [ definitions = anObject definitions ]
]

{ #category : #accessing }
CynClientPropertySlot >> addAllDefinitions: aCollection [

	"Add a Collection of new definitions"

	aCollection do: [ :each |
		self addDefinition: each ].

	^ aCollection
]

{ #category : #accessing }
CynClientPropertySlot >> addDefinition: aPropertyDefinition [

	"Add a new definition"

	definitions ifNil: [ definitions := Set new ].

	^ definitions add: aPropertyDefinition
]

{ #category : #accessing }
CynClientPropertySlot >> addFlag: aSymbolOrPropertyFlag [

	"Add the specified flag (either a Symbol representing the PropertyFlag or a PropertyFlag).

	Implementation:
	To prevent adding many extension methods, a specific check for #isSymbol is made here."

	self addDefinition: (aSymbolOrPropertyFlag isSymbol
		ifTrue: [ CynPropertyFlag named: aSymbolOrPropertyFlag ]
		ifFalse: [ aSymbolOrPropertyFlag ])
]

{ #category : #accessing }
CynClientPropertySlot >> constraints [

	"Answer a Collection of constraints from my definitions"

	^ definitions
		ifNotNil: [ definitions select: [ :each | each isPropertyConstraint ] ]
		ifNil: [ #() ]
]

{ #category : #accessing }
CynClientPropertySlot >> constraintsDo: aBlock [

	"Evaluate the specified Block for each constraints in my definitions"

	definitions ifNil: [ ^ self ].

	definitions do: [ :each |
		each isPropertyConstraint
			ifTrue: [ aBlock value: each ] ]
]

{ #category : #private }
CynClientPropertySlot >> definitions [

	"Private method to allow comparing the receiver"

	^ definitions
]

{ #category : #accessing }
CynClientPropertySlot >> definitionsDo: aBlock [

	"Evaluate the specified Block for all definitions"

	definitions ifNil: [ ^ self ].

	definitions do: aBlock
]

{ #category : #testing }
CynClientPropertySlot >> hasDefinitions [

	"Answer whether the receiver has actual definitions"

	^ definitions isEmptyOrNil not
]

{ #category : #testing }
CynClientPropertySlot >> hasFlag: aSymbolOrPropertyFlag [

	"Answer whether the "

	| flagName |
	
	flagName := aSymbolOrPropertyFlag isSymbol
		ifTrue: [ aSymbolOrPropertyFlag ]
		ifFalse: [ aSymbolOrPropertyFlag name ].

	self definitionsDo: [ :each |
		(each isPropertyFlag: flagName)
			ifTrue: [ ^ true ] ].

	^ false
]

{ #category : #comparing }
CynClientPropertySlot >> hash [

	^ name hash bitXor: definitions hash
]

{ #category : #initialization }
CynClientPropertySlot >> initializeWithName: aSymbol [

	self initialize.

	name := aSymbol
]

{ #category : #testing }
CynClientPropertySlot >> isCalculated [

	^ false
]

{ #category : #accessing }
CynClientPropertySlot >> name [

	^ name
]

{ #category : #accessing }
CynClientPropertySlot >> name: aSymbol [

	name := aSymbol
]

{ #category : #accessing }
CynClientPropertySlot >> nameAndValueIn: anObject do: aBlock [

	aBlock value: name value: (self read: anObject)
]

{ #category : #printing }
CynClientPropertySlot >> printOn: aStream [

	aStream
		nextPutAll: self class name ;
		nextPutAll: ': ' ;
		nextPutAll: (name ifNil: [ '<no name>' ]) ;
		nextPutAll: ' -> ' ;
		print: definitions
]

{ #category : #accessing }
CynClientPropertySlot >> propertyValue: aSymbol ifAbsent: aBlock [

	"Answer the value of the (first) property of the receiver with the specified name.
	If such a property does not exist answer the evaluation of Block."

	definitions ifNil: [ ^ aBlock value ].

	^ definitions
		detect: [ :each | each isPropertyValue: aSymbol ]
		ifFound: [ :property | property value ]
		ifNone: aBlock
]

{ #category : #accessing }
CynClientPropertySlot >> read: anObject [

	self subclassResponsibility
]

{ #category : #accessing }
CynClientPropertySlot >> valueIn: anObject do: aBlock [

	aBlock value: (self read: anObject)
]

{ #category : #accessing }
CynClientPropertySlot >> write: aValue to: anObject [

	self subclassResponsibility
]
