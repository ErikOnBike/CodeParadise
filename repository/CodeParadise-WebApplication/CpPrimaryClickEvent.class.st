Class {
	#name : #CpPrimaryClickEvent,
	#superclass : #CpClickEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #initialization }
CpPrimaryClickEvent >> initializeWithMouseEvent: aMouseEvent [

	super initializeWithMouseEvent: aMouseEvent.

	buttons := 1.
	modifiers := 0
]
