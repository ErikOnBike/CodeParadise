"
I am a flag/boolean value definition of a Property in a PropertyModel.
I can be used to add a Boolean value to a Property in a PropertyModel.
You can use me to mark a Property readonly or hidden for example.
"
Class {
	#name : #CynPropertyFlag,
	#superclass : #CynPropertyDefinition,
	#instVars : [
		'name'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #'instance creation' }
CynPropertyFlag class >> named: aSymbol [

	^ self basicNew
		initializeWithName: aSymbol ;
		yourself
]

{ #category : #'instance creation' }
CynPropertyFlag class >> new [

	self errorNewReplacedBy: #named:
]

{ #category : #comparing }
CynPropertyFlag >> = anObject [

	^ self class = anObject class
		and: [ self name = anObject name ]
]

{ #category : #comparing }
CynPropertyFlag >> hash [

	^ name hash
]

{ #category : #initialization }
CynPropertyFlag >> initializeWithName: aSymbol [

	self initialize.

	name := aSymbol
]

{ #category : #testing }
CynPropertyFlag >> isPropertyFlag [

	^ true
]

{ #category : #testing }
CynPropertyFlag >> isPropertyFlag: aSymbol [

	^ name = aSymbol
]

{ #category : #accessing }
CynPropertyFlag >> name [

	^ name
]

{ #category : #printing }
CynPropertyFlag >> printOn: aStream [

	aStream
		nextPutAll: self class name ;
		nextPut: $( ;
		nextPutAll: name ;
		nextPut: $)
]
