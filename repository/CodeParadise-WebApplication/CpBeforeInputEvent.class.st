Class {
	#name : #CpBeforeInputEvent,
	#superclass : #CpInputEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpBeforeInputEvent >> accept: aVisitor [

	aVisitor beforeInput: self
]

{ #category : #sending }
CpBeforeInputEvent >> sendTo: anObject [

	anObject handleBeforeInputEvent: self
]
