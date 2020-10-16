Class {
	#name : #CpBeforeInputEvent,
	#superclass : #CpInputEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpBeforeInputEvent >> sendTo: anObject [

	anObject handleBeforeInputEvent: self
]
