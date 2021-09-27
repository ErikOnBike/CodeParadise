Class {
	#name : #CpPointerMoveEvent,
	#superclass : #CpPointerEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #testing }
CpPointerMoveEvent >> autoPropagate [

	"The receiver should always automatically propagate after being dispatched.
	Pointer movement is a very low level event used in different places."

	^ true
]
