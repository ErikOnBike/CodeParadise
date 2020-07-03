Class {
	#name : #CpPointerUpEvent,
	#superclass : #CpPointerEvent,
	#category : #'WebApplication-Events'
}

{ #category : #accessing }
CpPointerUpEvent class >> type [

	^ #pointerup
]

{ #category : #visiting }
CpPointerUpEvent >> accept: aVisitor [

	aVisitor pointerUp: self
]

{ #category : #sending }
CpPointerUpEvent >> sendTo: anObject [

	anObject handlePointerUpEvent: self
]
