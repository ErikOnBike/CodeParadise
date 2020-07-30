Class {
	#name : #CpKeyDownEvent,
	#superclass : #CpKeyEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpKeyDownEvent >> accept: aVisitor [

	aVisitor keyDown: self
]

{ #category : #sending }
CpKeyDownEvent >> sendTo: anObject [

	anObject handleKeyDownEvent: self
]
