Class {
	#name : #CpPointerUpEvent,
	#superclass : #CpPointerEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #testing }
CpPointerUpEvent >> autoPropagate [

	"The receiver should always automatically propagate after being dispatched.
	Pointer movement is a very low level event used in different "

	^ true
]
