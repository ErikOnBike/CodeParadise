Class {
	#name : #CpEvent,
	#superclass : #Object,
	#instVars : [
		'timeStamp'
	],
	#category : #'WebApplication-Events'
}

{ #category : #visiting }
CpEvent >> accept: aVisitor [

	self subclassResponsibility
]

{ #category : #converting }
CpEvent >> asAnnouncement [

	^ CpEventAnnouncement event: self
]

{ #category : #testing }
CpEvent >> isPointerEvent [

	^ false
]

{ #category : #testing }
CpEvent >> isTextEntryEvent [

	"Answer whether the receiver is an interesting Event from text entry perspective"

	^ false
]

{ #category : #printing }
CpEvent >> printOn: aStream [

	self class name printOn: aStream.
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
