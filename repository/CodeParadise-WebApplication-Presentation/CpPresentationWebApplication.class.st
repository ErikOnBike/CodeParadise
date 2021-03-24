Class {
	#name : #CpPresentationWebApplication,
	#superclass : #CpMvpWebApplication,
	#category : #'CodeParadise-WebApplication-Presentation-Application'
}

{ #category : #model }
CpPresentationWebApplication >> createPresentationModel [

	"Create and answer the PresentationModel for the presentation"

	self subclassResponsibility
]

{ #category : #actions }
CpPresentationWebApplication >> load [

	"Set up the receiver with a single presenter and single model"

	| presentation |

	super load.

	"Create PresentionModel and start it (sets first slide)"
	presentation := self createPresentationModel.
	presentation start.

	"Create presentation presenter and add it to the receiver.
	This presenter will be installed when #load or #reload is called on the receiver."
	self applicationPresenter createChildPresenterForModel: presentation
]
