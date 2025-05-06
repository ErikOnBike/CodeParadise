Class {
	#name : #CpSubmitEvent,
	#superclass : #CpEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #'as yet unclassified' }
CpSubmitEvent >> submitter [

	"An HTMLElement object which identifies the button or other element which was invoked to trigger the form being submitted."

	^ self propertyAt: #submitter
]
