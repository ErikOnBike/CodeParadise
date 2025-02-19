Class {
	#name : #CpPresentationWebApplication,
	#superclass : #CpMvpWebApplication,
	#instVars : [
		'presentation'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Application'
}

{ #category : #tags }
CpPresentationWebApplication class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #accessing }
CpPresentationWebApplication >> applicationModel [

	"Answer the Model for the receiver"

	^ self presentation
]

{ #category : #model }
CpPresentationWebApplication >> createPresentationModel [

	"Create and answer the PresentationModel for the presentation"

	self subclassResponsibility
]

{ #category : #initialization }
CpPresentationWebApplication >> initialize [

	"Set up the receiver with a single presenter and single model"

	super initialize.

	"Create PresentionModel and start it (sets first slide)"
	presentation := self createPresentationModel.
	presentation start
]

{ #category : #accessing }
CpPresentationWebApplication >> presentation [

	^ presentation
]
