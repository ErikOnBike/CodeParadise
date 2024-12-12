Class {
	#name : #CpPropertyFlag,
	#superclass : #CpPropertyDefinition,
	#instVars : [
		'name'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #'instance creation' }
CpPropertyFlag class >> named: aSymbol [

	^ self basicNew
		initializeWithName: aSymbol ;
		yourself
]

{ #category : #'instance creation' }
CpPropertyFlag class >> new [

	self errorNewReplacedBy: #named:
]

{ #category : #comparing }
CpPropertyFlag >> = anObject [

	^ self class = anObject class
		and: [ self name = anObject name ]
]

{ #category : #comparing }
CpPropertyFlag >> hash [

	^ name hash
]

{ #category : #initialization }
CpPropertyFlag >> initializeWithName: aSymbol [

	self initialize.

	name := aSymbol
]

{ #category : #testing }
CpPropertyFlag >> isPropertyFlag [

	^ true
]

{ #category : #testing }
CpPropertyFlag >> isPropertyFlag: aSymbol [

	^ name = aSymbol
]

{ #category : #accessing }
CpPropertyFlag >> name [

	^ name
]

{ #category : #printing }
CpPropertyFlag >> printOn: aStream [

	aStream
		nextPutAll: self class name ;
		nextPut: $( ;
		nextPutAll: name ;
		nextPut: $)
]
