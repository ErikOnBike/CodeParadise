Class {
	#name : #CpPrimaryClickEvent,
	#superclass : #CpClickEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #initialization }
CpPrimaryClickEvent >> initializeWithMouseEvent: aMouseEvent elements: aCollection [

	super initializeWithMouseEvent: aMouseEvent elements: aCollection.

	buttons := 1.
	modifiers := 0
]
