Class {
	#name : #CpEvent,
	#superclass : #Object,
	#instVars : [
		'timeStamp'
	],
	#category : #'WebApplication-Events'
}

{ #category : #'instance creation' }
CpEvent class >> buildFrom: aDictionary [

	| type |

	type := aDictionary at: #type ifAbsent: [ self error: 'DOM event should have a type' ].

	self allSubclassesDo: [ :each |
		(each canHandleType: type)
			ifTrue: [ ^ each newFrom: aDictionary ] ].

	self error: 'DOM event has unknown type: ', type printString
]

{ #category : #testing }
CpEvent class >> canHandleType: type [

	^ self type = type
]

{ #category : #'instance creation' }
CpEvent class >> newFrom: aDictionary [

	^ self new
		timeStamp: (aDictionary at: #timeStamp ifAbsent: [ nil ]) ;
		yourself
]

{ #category : #accessing }
CpEvent class >> type [

	self subclassResponsibility
]

{ #category : #visiting }
CpEvent >> accept: aVisitor [

	self subclassResponsibility
]

{ #category : #converting }
CpEvent >> asAnnouncement [

	^ CpEventAnnouncement event: self
]

{ #category : #testing }
CpEvent >> isInputEvent [

	^ false
]

{ #category : #testing }
CpEvent >> isPointerEvent [

	^ false
]

{ #category : #printing }
CpEvent >> printOn: aStream [

	self class name printOn: aStream.
	aStream nextPutAll: ', type: '.
	self type printOn: aStream.
	aStream nextPutAll: ', timeStamp: '.
	self timeStamp printOn: aStream
]

{ #category : #sending }
CpEvent >> sendTo: anObject [

	self subclassResponsibility
]

{ #category : #accessing }
CpEvent >> timeStamp [

	"Answer the relative timestamp (a Number) for when the receiver was triggered"

	^ timeStamp
]

{ #category : #accessing }
CpEvent >> timeStamp: aNumber [

	"Set the relative timestamp for when the receiver was triggered"

	timeStamp := aNumber
]

{ #category : #accessing }
CpEvent >> type [

	^ self class type
]
