Class {
	#name : #CpMouseMoveEvent,
	#superclass : #CpMouseEvent,
	#category : #'WebApplication-Events'
}

{ #category : #accessing }
CpMouseMoveEvent class >> type [

	^ #mousemove
]

{ #category : #visiting }
CpMouseMoveEvent >> accept: aVisitor [

	aVisitor mouseMove: self
]

{ #category : #sending }
CpMouseMoveEvent >> sendTo: anObject [

	anObject handleMouseMoveEvent: self
]
