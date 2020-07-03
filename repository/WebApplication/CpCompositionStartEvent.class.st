Class {
	#name : #CpCompositionStartEvent,
	#superclass : #CpCompositionEvent,
	#category : #'WebApplication-Events'
}

{ #category : #accessing }
CpCompositionStartEvent class >> type [

	^ #compositionstart
]

{ #category : #visiting }
CpCompositionStartEvent >> accept: aVisitor [

	aVisitor compositionStart: self
]

{ #category : #sending }
CpCompositionStartEvent >> sendTo: anObject [

	anObject handleCompositionStartEvent: self
]
