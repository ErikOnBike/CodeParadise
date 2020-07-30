Class {
	#name : #CpKeyPressEvent,
	#superclass : #CpKeyEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpKeyPressEvent >> accept: aVisitor [

	aVisitor keyPress: self
]

{ #category : #sending }
CpKeyPressEvent >> sendTo: anObject [

	anObject handleKeyPressEvent: self
]
