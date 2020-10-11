Class {
	#name : #CpClickEvent,
	#superclass : #CpPointerEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpClickEvent >> sendTo: anObject [

	anObject handleClickEvent: self
]
