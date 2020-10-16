Class {
	#name : #CpKeyUpEvent,
	#superclass : #CpKeyEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpKeyUpEvent >> sendTo: anObject [

	anObject handleKeyUpEvent: self
]
