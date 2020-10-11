Class {
	#name : #CpPointerMoveEvent,
	#superclass : #CpPointerEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpPointerMoveEvent >> sendTo: anObject [

	anObject handlePointerMoveEvent: self
]
