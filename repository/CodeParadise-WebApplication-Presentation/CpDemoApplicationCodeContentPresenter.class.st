Class {
	#name : #CpDemoApplicationCodeContentPresenter,
	#superclass : #CpDemoCodeContentPresenter,
	#category : #'CodeParadise-WebApplication-Presentation-Examples'
}

{ #category : #'user interaction' }
CpDemoApplicationCodeContentPresenter >> openInspector [

	"Open a new Inspector on the application"

	self application openInspector
]

{ #category : #view }
CpDemoApplicationCodeContentPresenter >> viewCreated [

	super viewCreated.

	self view when: CpDemoCodeOpenInspector send: #openInspector to: self
]
