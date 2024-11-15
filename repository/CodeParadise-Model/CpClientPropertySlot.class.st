"
I am a PropertySlot for a PropertyModel. I define/describe a single Property with a PropertyModel.
My definitions are name/value pairs. Names are Symbols representing the 'feature' of the Property
and the value can be any Object.
For flags I have two convenience methods #addFlag: and #hasFlag: to allow to set a `true` value
for a specific feature. This could be used to mark required properties for example. You can't
remove a flag, since it is meant to describe all Property instances (please use a conditional
mechanism if the flag should not be set in all situations).

"
Class {
	#name : #CpClientPropertySlot,
	#superclass : #Object,
	#instVars : [
		'name',
		'definition'
	],
	#category : #'CodeParadise-Model-Property'
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
		and: [ definition = anObject definition ]
]

{ #category : #accessing }
CpClientPropertySlot >> addDefinition: anAssociation [

	"Add a new definition"

	definition ifNil: [ definition := Dictionary new ].

	^ definition add: anAssociation
]

{ #category : #accessing }
CpClientPropertySlot >> addFlag: aSymbol [

	self definitionAt: aSymbol put: true
]

{ #category : #private }
CpClientPropertySlot >> definition [

	^ definition
]

{ #category : #accessing }
CpClientPropertySlot >> definitionAt: aSymbol [

	"Answer the value for the specified definition or nil if none is present"

	^ definition
		ifNotNil: [ definition at: aSymbol ifAbsent: [ nil ] ]
]

{ #category : #accessing }
CpClientPropertySlot >> definitionAt: aSymbol put: anObject [

	"Set the specified definition"

	definition ifNil: [ definition := Dictionary new ].

	^ definition at: aSymbol put: anObject
]

{ #category : #accessing }
CpClientPropertySlot >> definitionsDo: aBlock [

	"Evaluate the specified Block for all definitions.
	The Block should accept two arguments: key and value."

	definition ifNil: [ ^ self ].

	definition keysAndValuesDo: aBlock
]

{ #category : #testing }
CpClientPropertySlot >> hasDefinitions [

	"Answer whether the receiver has actual definitions"

	^ definition isEmptyOrNil not
]

{ #category : #testing }
CpClientPropertySlot >> hasFlag: aSymbol [

	^ (self definitionAt: aSymbol) = true
]

{ #category : #comparing }
CpClientPropertySlot >> hash [

	^ name hash bitXor: definition hash
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
		print: definition
]
