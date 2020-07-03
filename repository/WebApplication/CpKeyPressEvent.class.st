Class {
	#name : #CpKeyPressEvent,
	#superclass : #CpKeyEvent,
	#category : #'WebApplication-Events'
}

{ #category : #accessing }
CpKeyPressEvent class >> type [

	^ #keypress
]

{ #category : #visiting }
CpKeyPressEvent >> accept: aVisitor [

	aVisitor keyPress: self
]

{ #category : #sending }
CpKeyPressEvent >> sendTo: anObject [

	anObject handleKeyPressEvent: self
]
