Class {
	#name : #CpKeyPressEvent,
	#superclass : #CpKeyEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpKeyPressEvent >> sendTo: anObject [

	anObject handleKeyPressEvent: self
]
