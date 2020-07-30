Class {
	#name : #CpCompositionStartEvent,
	#superclass : #CpCompositionEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpCompositionStartEvent >> accept: aVisitor [

	aVisitor compositionStart: self
]

{ #category : #sending }
CpCompositionStartEvent >> sendTo: anObject [

	anObject handleCompositionStartEvent: self
]
