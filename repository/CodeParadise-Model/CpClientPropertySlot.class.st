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
CpClientPropertySlot >> hasDefinition [

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
