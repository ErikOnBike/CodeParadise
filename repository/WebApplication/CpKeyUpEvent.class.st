Class {
	#name : #CpKeyUpEvent,
	#superclass : #CpKeyEvent,
	#category : #'WebApplication-Events'
}

{ #category : #accessing }
CpKeyUpEvent class >> type [

	^ #keyup
]

{ #category : #visiting }
CpKeyUpEvent >> accept: aVisitor [

	aVisitor keyUp: self
]

{ #category : #sending }
CpKeyUpEvent >> sendTo: anObject [

	anObject handleKeyUpEvent: self
]
