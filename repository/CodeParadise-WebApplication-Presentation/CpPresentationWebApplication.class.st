Class {
	#name : #CpPresentationWebApplication,
	#superclass : #CpMvpWebApplication,
	#instVars : [
		'presentation'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Application'
}

{ #category : #presenter }
CpPresentationWebApplication >> applicationPresenterClass [

	^ CpPresentationApplicationPresenter
]

{ #category : #model }
CpPresentationWebApplication >> createPresentationModel [

	"Create and answer the PresentationModel for the presentation"

	self subclassResponsibility
]

{ #category : #actions }
CpPresentationWebApplication >> initialize [

	"Set up the receiver with a single presenter and single model"

	super initialize.

	"Create PresentionModel and start it (sets first slide)"
	presentation := self createPresentationModel.
	presentation start
]

{ #category : #presenter }
CpPresentationWebApplication >> preferredPresenterClass [

	"Answer the preferred Presenter class for the content of the receiver"

	^ CpPresentationPresenter
]

{ #category : #accessing }
CpPresentationWebApplication >> presentation [

	^ presentation
]
