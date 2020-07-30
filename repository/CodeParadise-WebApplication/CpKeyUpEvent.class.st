Class {
	#name : #CpKeyUpEvent,
	#superclass : #CpKeyEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpKeyUpEvent >> accept: aVisitor [

	aVisitor keyUp: self
]

{ #category : #sending }
CpKeyUpEvent >> sendTo: anObject [

	anObject handleKeyUpEvent: self
]
