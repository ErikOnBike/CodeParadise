Class {
	#name : #CpCompositionUpdateEvent,
	#superclass : #CpCompositionEvent,
	#category : #'WebApplication-Events'
}

{ #category : #visiting }
CpCompositionUpdateEvent >> accept: aVisitor [

	aVisitor compositionUpdate: self
]

{ #category : #sending }
CpCompositionUpdateEvent >> sendTo: anObject [

	anObject handleCompositionUpdateEvent: self
]
