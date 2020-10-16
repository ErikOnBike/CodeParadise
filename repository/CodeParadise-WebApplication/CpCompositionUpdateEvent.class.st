Class {
	#name : #CpCompositionUpdateEvent,
	#superclass : #CpCompositionEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpCompositionUpdateEvent >> sendTo: anObject [

	anObject handleCompositionUpdateEvent: self
]
