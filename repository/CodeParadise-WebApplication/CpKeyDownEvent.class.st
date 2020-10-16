Class {
	#name : #CpKeyDownEvent,
	#superclass : #CpKeyEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpKeyDownEvent >> sendTo: anObject [

	anObject handleKeyDownEvent: self
]
