"
I am a base class for event handling. I can be used as a delegate for the BrowserEventHandler.
"
Class {
	#name : #CpBaseEventHandler,
	#superclass : #Object,
	#category : #'CodeParadise-WebApplication-Core'
}

{ #category : #events }
CpBaseEventHandler >> handleEvent: anEvent [

	"Subclasses should add meaningful behavior"
]
