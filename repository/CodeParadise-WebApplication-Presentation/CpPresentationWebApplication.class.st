Class {
	#name : #CpPresentationWebApplication,
	#superclass : #CpMvpWebApplication,
	#instVars : [
		'presentation'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Application'
}

{ #category : #accessing }
CpPresentationWebApplication >> applicationModel [

	"Answer the Model for the receiver"

	^ self presentation
]

{ #category : #presenter }
CpPresentationWebApplication >> applicationPresenterClass [

	^ CpPresentationPresenter
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
