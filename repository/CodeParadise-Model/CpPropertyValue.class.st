Class {
	#name : #CpPropertyValue,
	#superclass : #CpPropertyDefinition,
	#instVars : [
		'name',
		'value'
	],
	#category : #'CodeParadise-Model-Property'
}

{ #category : #'instance creation' }
CpPropertyValue class >> name: aSymbol value: anObject [

	^ self basicNew
		initializeWithName: aSymbol value: anObject ;
		yourself
]

{ #category : #'instance creation' }
CpPropertyValue class >> new [

	self errorNewReplacedBy: #name:value:
]

{ #category : #comparing }
CpPropertyValue >> = anObject [

	^ self class = anObject class
		and: [ self name = anObject name
			and: [ self value = anObject value ] ]
]

{ #category : #comparing }
CpPropertyValue >> hash [

	^ name hash bitXor: value hash
]

{ #category : #initialization }
CpPropertyValue >> initializeWithName: aSymbol value: anObject [

	self initialize.

	name := aSymbol.
	value := anObject
]

{ #category : #testing }
CpPropertyValue >> isPropertyValue [

	^ true
]

{ #category : #testing }
CpPropertyValue >> isPropertyValue: aSymbol [

	^ name = aSymbol
]

{ #category : #accessing }
CpPropertyValue >> name [

	^ name
]

{ #category : #printing }
CpPropertyValue >> printOn: aStream [

	aStream
		nextPutAll: self class name ;
		nextPut: $( ;
		nextPutAll: name ;
		nextPutAll: ': ' ;
		print: value ;
		nextPut: $)
]

{ #category : #accessing }
CpPropertyValue >> value [

	^ value
]
