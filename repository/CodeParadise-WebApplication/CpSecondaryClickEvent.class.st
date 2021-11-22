Class {
	#name : #CpSecondaryClickEvent,
	#superclass : #CpClickEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #initialization }
CpSecondaryClickEvent >> initializeWithMouseEvent: aMouseEvent elements: aCollection [

	super initializeWithMouseEvent: aMouseEvent elements: aCollection.

	buttons := 2.
	modifiers := 0

]
