Class {
	#name : #CpPointerDownEvent,
	#superclass : #CpPointerEvent,
	#category : #'WebApplication-Events'
}

{ #category : #accessing }
CpPointerDownEvent class >> type [

	^ #pointerdown
]

{ #category : #visiting }
CpPointerDownEvent >> accept: aVisitor [

	aVisitor pointerDown: self
]

{ #category : #sending }
CpPointerDownEvent >> sendTo: anObject [

	anObject handlePointerDownEvent: self
]
