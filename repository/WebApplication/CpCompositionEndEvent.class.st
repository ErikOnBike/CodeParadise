Class {
	#name : #CpCompositionEndEvent,
	#superclass : #CpCompositionEvent,
	#category : #'WebApplication-Events'
}

{ #category : #visiting }
CpCompositionEndEvent >> accept: aVisitor [

	aVisitor compositionEnd: self
]

{ #category : #sending }
CpCompositionEndEvent >> sendTo: anObject [

	anObject handleCompositionEndEvent: self
]
