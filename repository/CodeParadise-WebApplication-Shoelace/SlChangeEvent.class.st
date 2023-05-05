Class {
	#name : #SlChangeEvent,
	#superclass : #SlEvent,
	#category : #'CodeParadise-WebApplication-Shoelace-Events'
}

{ #category : #'event handling' }
SlChangeEvent >> handleEventForField: aSymbol inView: aView [

	"Let the specified view handle the receiver event"

	aView handleChangeEvent: self forField: aSymbol
]
