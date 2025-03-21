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

{ #category : #initialization }
CpAbstractOptions >> initialize [

	super initialize.

	"Assume the options can contain JavaScriptFunctions"
	options := CpJsonObject newRelaxed
]

{ #category : #enumerating }
CpAbstractOptions >> keysAndValuesDo: aBlock [

	options keysAndValuesDo: aBlock
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
