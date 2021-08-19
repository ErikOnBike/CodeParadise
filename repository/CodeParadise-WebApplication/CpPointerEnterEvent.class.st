Class {
	#name : #CpPointerEnterEvent,
	#superclass : #CpPointerEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpPointerEnterEvent >> sendTo: anObject [

	anObject handlePointerEnterEvent: self
]
