"
I am an abstract base class to create so called 'Option' Objects.
I represent the typical Object structures in JavaScript which are
used to provide input to a method. My subclasses would typically
have getters and setters for the explicit option values. This way
the Smalltalk compiler can help out with the possible fields.

Some generic #at: and #at:put: methods are also present for convenience.
"
Class {
	#name : #CpAbstractOptions,
	#superclass : #Object,
	#instVars : [
		'options'
	],
	#category : #'CodeParadise-JavaScript-Support'
}

{ #category : #converting }
CpAbstractOptions >> asDictionary [

	^ options asDictionary
]

{ #category : #converting }
CpAbstractOptions >> asJsonObjectValue [

	^ options asJsonObjectValue
]

{ #category : #converting }
CpAbstractOptions >> asRelaxedJsonObjectValue [

	^ options asRelaxedJsonObjectValue
]

{ #category : #accessing }
CpAbstractOptions >> at: aSymbol [

	^ options at: aSymbol
]

{ #category : #accessing }
CpAbstractOptions >> at: aSymbol ifAbsent: aBlock [

	^ options at: aSymbol ifAbsent: aBlock
]

{ #category : #accessing }
CpAbstractOptions >> at: aSymbol ifAbsentPut: aBlock [

	^ options at: aSymbol ifAbsentPut: aBlock
]

{ #category : #accessing }
CpAbstractOptions >> at: aSymbol put: anObject [

	^ options at: aSymbol put: anObject
]

{ #category : #testing }
CpAbstractOptions >> includesKey: aSymbol [

	^ options includesKey: aSymbol
]

{ #category : #initialization }
CpAbstractOptions >> initialize [

	super initialize.

	"Assume the options can contain JavaScriptFunctions"
	options := CpJsonObject newRelaxed
]

{ #category : #accessing }
CpAbstractOptions >> keys [

	^ options keys
]

{ #category : #enumerating }
CpAbstractOptions >> keysAndValuesDo: aBlock [

	options keysAndValuesDo: aBlock
]

{ #category : #enumerating }
CpAbstractOptions >> keysDo: aBlock [

	options keysDo: aBlock
]

{ #category : #actions }
CpAbstractOptions >> merge: anObject [

	"Merge the specified Dictionary-like object into the receiver"

	anObject keysAndValuesDo: [ :key :value |
		options at: key put: value ]
]

{ #category : #printing }
CpAbstractOptions >> printOn: aStream [

	aStream
		nextPutAll: self class name ;
		nextPut: $( ;
		print: options ;
		nextPut: $)
]

{ #category : #accessing }
CpAbstractOptions >> removeKey: aSymbol [

	^ options removeKey: aSymbol
]

{ #category : #accessing }
CpAbstractOptions >> removeKey: aSymbol ifAbsent: aBlock [

	^ options removeKey: aSymbol ifAbsent: aBlock
]
