Class {
	#name : #CpSecondaryClickEvent,
	#superclass : #CpClickEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #initialization }
CpSecondaryClickEvent >> initializeWithMouseEvent: aMouseEvent [

	super initializeWithMouseEvent: aMouseEvent.

	buttons := 2.
	modifiers := 0

]
