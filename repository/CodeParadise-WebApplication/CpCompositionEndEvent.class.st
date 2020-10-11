Class {
	#name : #CpCompositionEndEvent,
	#superclass : #CpCompositionEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpCompositionEndEvent >> sendTo: anObject [

	anObject handleCompositionEndEvent: self
]
