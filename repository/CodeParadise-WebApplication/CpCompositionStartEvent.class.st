Class {
	#name : #CpCompositionStartEvent,
	#superclass : #CpCompositionEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpCompositionStartEvent >> sendTo: anObject [

	anObject handleCompositionStartEvent: self
]
