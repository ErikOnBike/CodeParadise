Class {
	#name : #SlSelectionChangeEvent,
	#superclass : #SlEvent,
	#category : #'CodeParadise-WebApplication-Shoelace-Events'
}

{ #category : #accessing }
SlSelectionChangeEvent >> selection [

	"Answer a collection of the receiver's tree items which is stored in the event detail dictionary"

	^ self detail at: 'selection' ifAbsent: [ nil ]
]
