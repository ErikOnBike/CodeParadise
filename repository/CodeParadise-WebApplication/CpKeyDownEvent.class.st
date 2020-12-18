"
I am a KeyDown event. I will be dispatched when a key is pressed down as well as when a key
is kept down. In the latter case I will be dispatched repeatedly at the interval set for
the device I'm running on.

"
Class {
	#name : #CpKeyDownEvent,
	#superclass : #CpKeyEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpKeyDownEvent >> sendTo: anObject [

	anObject handleKeyDownEvent: self
]
