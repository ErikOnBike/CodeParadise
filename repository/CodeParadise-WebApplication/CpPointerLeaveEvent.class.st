Class {
	#name : #CpPointerLeaveEvent,
	#superclass : #CpPointerEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpPointerLeaveEvent >> sendTo: anObject [

	anObject handlePointerLeaveEvent: self
]
