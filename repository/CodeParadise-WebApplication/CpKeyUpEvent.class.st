"
I am a KeyUp event. I will be dispatched when a key is released.
In certain situations a KeyUp will not be dispatched (and this will probably
depend on the device I'm running on). For example when the browser window
looses focus because of switching to another window (while holding key down).
"
Class {
	#name : #CpKeyUpEvent,
	#superclass : #CpKeyEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpKeyUpEvent >> sendTo: anObject [

	anObject handleKeyUpEvent: self
]
