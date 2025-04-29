"
I am a value definition of a Property in a PropertyModel.
I can be used to add values to a Property in a PropertyModel.
To distinguish between different values, I have a name too.
You can use me to add (UI) labels to Properties for example
(using the name #label).

"
Class {
	#name : #CynPropertyValue,
	#superclass : #CynPropertyDefinition,
	#instVars : [
		'name',
		'value'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #'instance creation' }
CynPropertyValue class >> name: aSymbol value: anObject [

	^ self basicNew
		initializeWithName: aSymbol value: anObject ;
		yourself
]

{ #category : #'instance creation' }
CynPropertyValue class >> new [

	self errorNewReplacedBy: #name:value:
]

{ #category : #comparing }
CynPropertyValue >> = anObject [

	^ self class = anObject class
		and: [ self name = anObject name
			and: [ self value = anObject value ] ]
]

{ #category : #comparing }
CynPropertyValue >> hash [

	^ name hash bitXor: value hash
]

{ #category : #initialization }
CynPropertyValue >> initializeWithName: aSymbol value: anObject [

	self initialize.

	name := aSymbol.
	value := anObject
]

{ #category : #testing }
CynPropertyValue >> isPropertyValue [

	^ true
]

{ #category : #testing }
CynPropertyValue >> isPropertyValue: aSymbol [

	^ name = aSymbol
]

{ #category : #accessing }
CynPropertyValue >> name [

	^ name
]

{ #category : #printing }
CynPropertyValue >> printOn: aStream [

	aStream
		nextPutAll: self class name ;
		nextPut: $( ;
		nextPutAll: name ;
		nextPutAll: ': ' ;
		print: value ;
		nextPut: $)
]

{ #category : #accessing }
CynPropertyValue >> value [

	^ value
]
