Class {
	#name : #CpPointerDownEvent,
	#superclass : #CpPointerEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpPointerDownEvent >> accept: aVisitor [

	aVisitor pointerDown: self
]

{ #category : #sending }
CpPointerDownEvent >> sendTo: anObject [

	anObject handlePointerDownEvent: self
]
