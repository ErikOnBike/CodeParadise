Class {
	#name : #CpPointerUpEvent,
	#superclass : #CpPointerEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpPointerUpEvent >> accept: aVisitor [

	aVisitor pointerUp: self
]

{ #category : #sending }
CpPointerUpEvent >> sendTo: anObject [

	anObject handlePointerUpEvent: self
]
