Class {
	#name : #CpKeyDownEvent,
	#superclass : #CpKeyEvent,
	#category : #'WebApplication-Events'
}

{ #category : #visiting }
CpKeyDownEvent >> accept: aVisitor [

	aVisitor keyDown: self
]

{ #category : #sending }
CpKeyDownEvent >> sendTo: anObject [

	anObject handleKeyDownEvent: self
]
