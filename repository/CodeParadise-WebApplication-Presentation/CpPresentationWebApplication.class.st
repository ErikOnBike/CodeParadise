Class {
	#name : #CpPresentationWebApplication,
	#superclass : #CpMvpWebApplication,
	#category : #'CodeParadise-WebApplication-Presentation-Application'
}

{ #category : #accessing }
CpPresentationWebApplication class >> app [

	^ #presentation
]

{ #category : #accessing }
CpPresentationWebApplication class >> clientBehaviorClass [

	^ CpPresentationClientBehavior
]

{ #category : #actions }
CpPresentationWebApplication >> load [

	"Set up the receiver with a single presenter"

	super load.

	"Create presentation presenter.
	This presenter will be installed when #load or #reload is called on the receiver."
	self createPresenter: CpPresentationPresenter forModel: (self addModel: (CpPresentation titled: 'CodeParadise')).

	"Open an Inspector on the receiver to allow access to the ServerEnvironment, the Presentation Model and Presenter"
	self inspect
]
