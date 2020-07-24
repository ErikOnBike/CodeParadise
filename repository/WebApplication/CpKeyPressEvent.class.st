Class {
	#name : #CpKeyPressEvent,
	#superclass : #CpKeyEvent,
	#category : #'WebApplication-Events'
}

{ #category : #visiting }
CpKeyPressEvent >> accept: aVisitor [

	aVisitor keyPress: self
]

{ #category : #sending }
CpKeyPressEvent >> sendTo: anObject [

	anObject handleKeyPressEvent: self
]
