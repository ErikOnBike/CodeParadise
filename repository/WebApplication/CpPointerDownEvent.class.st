Class {
	#name : #CpPointerDownEvent,
	#superclass : #CpPointerEvent,
	#category : #'WebApplication-Events'
}

{ #category : #visiting }
CpPointerDownEvent >> accept: aVisitor [

	aVisitor pointerDown: self
]

{ #category : #sending }
CpPointerDownEvent >> sendTo: anObject [

	anObject handlePointerDownEvent: self
]
