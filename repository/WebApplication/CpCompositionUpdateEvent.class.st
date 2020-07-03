Class {
	#name : #CpCompositionUpdateEvent,
	#superclass : #CpCompositionEvent,
	#category : #'WebApplication-Events'
}

{ #category : #accessing }
CpCompositionUpdateEvent class >> type [

	^ #compositionupdate
]

{ #category : #visiting }
CpCompositionUpdateEvent >> accept: aVisitor [

	aVisitor compositionUpdate: self
]

{ #category : #sending }
CpCompositionUpdateEvent >> sendTo: anObject [

	anObject handleCompositionUpdateEvent: self
]
