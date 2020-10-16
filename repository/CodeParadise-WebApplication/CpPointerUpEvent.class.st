Class {
	#name : #CpPointerUpEvent,
	#superclass : #CpPointerEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpPointerUpEvent >> sendTo: anObject [

	anObject handlePointerUpEvent: self
]
