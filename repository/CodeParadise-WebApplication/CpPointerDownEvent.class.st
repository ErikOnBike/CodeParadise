Class {
	#name : #CpPointerDownEvent,
	#superclass : #CpPointerEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpPointerDownEvent >> sendTo: anObject [

	anObject handlePointerDownEvent: self
]
