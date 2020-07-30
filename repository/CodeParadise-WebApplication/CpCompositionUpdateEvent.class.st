Class {
	#name : #CpCompositionUpdateEvent,
	#superclass : #CpCompositionEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpCompositionUpdateEvent >> accept: aVisitor [

	aVisitor compositionUpdate: self
]

{ #category : #sending }
CpCompositionUpdateEvent >> sendTo: anObject [

	anObject handleCompositionUpdateEvent: self
]
