"
I am a PropertySlot for a PropertyModel. I define/describe a single Property within a PropertyModel.
I know my name in the PropertyModel and I maintain a collection of PropertyDefinitions.
"
Class {
	#name : #CpClientPropertySlot,
	#superclass : #Object,
	#instVars : [
		'name',
		'definitions'
	],
	#category : #'CodeParadise-Canyon-Model'
}

{ #category : #'instance creation' }
CpClientPropertySlot class >> named: aSymbol [

	^ self basicNew
		initializeWithName: aSymbol ;
		yourself
]

{ #category : #comparing }
CpClientPropertySlot >> = anObject [ 

	^ name = anObject name
		and: [ definitions = anObject definitions ]
]

{ #category : #accessing }
CpClientPropertySlot >> addAllDefinitions: aCollection [

	"Add a Collection of new definitions"

	aCollection do: [ :each |
		self addDefinition: each ].

	^ aCollection
]

{ #category : #accessing }
CpClientPropertySlot >> addDefinition: aPropertyDefinition [

	"Add a new definition"

	definitions ifNil: [ definitions := Set new ].

	^ definitions add: aPropertyDefinition
]

{ #category : #accessing }
CpClientPropertySlot >> addFlag: aSymbolOrPropertyFlag [

	"Add the specified flag (either a Symbol representing the PropertyFlag or a PropertyFlag).

	Implementation:
	To prevent adding many extension methods, a specific check for #isSymbol is made here."

	self addDefinition: (aSymbolOrPropertyFlag isSymbol
		ifTrue: [ CpPropertyFlag named: aSymbolOrPropertyFlag ]
		ifFalse: [ aSymbolOrPropertyFlag ])
]

{ #category : #private }
CpClientPropertySlot >> definitions [

	"Private method to allow comparing the receiver"

	^ definitions
]

{ #category : #accessing }
CpClientPropertySlot >> definitionsDo: aBlock [

	"Evaluate the specified Block for all definitions"

	definitions ifNil: [ ^ self ].

	definitions do: aBlock
]

{ #category : #testing }
CpClientPropertySlot >> hasDefinitions [

	"Answer whether the receiver has actual definitions"

	^ definitions isEmptyOrNil not
]

{ #category : #testing }
CpClientPropertySlot >> hasFlag: aSymbolOrPropertyFlag [

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
CpClientPropertySlot >> hash [

	^ name hash bitXor: definitions hash
]

{ #category : #initialization }
CpClientPropertySlot >> initializeWithName: aSymbol [

	self initialize.

	name := aSymbol
]

{ #category : #accessing }
CpClientPropertySlot >> name [

	^ name
]

{ #category : #accessing }
CpClientPropertySlot >> name: aSymbol [

	name := aSymbol
]

{ #category : #printing }
CpClientPropertySlot >> printOn: aStream [

	aStream
		nextPutAll: self class name ;
		nextPutAll: ': ' ;
		nextPutAll: (name ifNil: [ '<no name>' ]) ;
		nextPutAll: ' -> ' ;
		print: definitions
]
