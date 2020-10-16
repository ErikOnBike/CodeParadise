Class {
	#name : #CpFocusEvent,
	#superclass : #CpUserInterfaceEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpFocusEvent >> sendTo: anObject [

	anObject handleFocusEvent: self
]
