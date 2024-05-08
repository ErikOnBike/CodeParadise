Class {
	#name : 'SlInputEvent',
	#superclass : 'SlEvent',
	#category : 'CodeParadise-WebApplication-Shoelace-Events',
	#package : 'CodeParadise-WebApplication-Shoelace',
	#tag : 'Events'
}

{ #category : 'event handling' }
SlInputEvent >> handleEventForField: aSymbol inView: aView [

	"Let the specified view handle the receiver event"

	aView handleInputEvent: self forField: aSymbol
]
