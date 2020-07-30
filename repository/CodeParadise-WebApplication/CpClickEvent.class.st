Class {
	#name : #CpClickEvent,
	#superclass : #CpPointerEvent,
	#instVars : [
		'clickPoint'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpClickEvent >> accept: aVisitor [

	aVisitor click: self
]

{ #category : #accessing }
CpClickEvent >> clickPoint [

	^ clickPoint
]

{ #category : #accessing }
CpClickEvent >> clickPoint: aPoint [

	clickPoint := aPoint
]

{ #category : #printing }
CpClickEvent >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ', clickPoint: '.
	self clickPoint printOn: aStream
]

{ #category : #sending }
CpClickEvent >> sendTo: anObject [

	anObject handleClickEvent: self
]
