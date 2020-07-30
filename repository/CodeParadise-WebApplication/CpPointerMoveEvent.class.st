Class {
	#name : #CpPointerMoveEvent,
	#superclass : #CpPointerEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpPointerMoveEvent >> accept: aVisitor [

	aVisitor pointerMove: self
]

{ #category : #sending }
CpPointerMoveEvent >> sendTo: anObject [

	anObject handlePointerMoveEvent: self
]
