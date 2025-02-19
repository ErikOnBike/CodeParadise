Class {
	#name : #CpDemoExecutableCodeContentPresenter,
	#superclass : #CpDemoCodeContentPresenter,
	#category : #'CodeParadise-WebApplication-Presentation-Examples'
}

{ #category : #'user interaction' }
CpDemoExecutableCodeContentPresenter >> doIt [

	self model doIt.

	self view renderMessage: 'Code executed'
]

{ #category : #view }
CpDemoExecutableCodeContentPresenter >> viewCreated [

	super viewCreated.

	self view when: CpDemoCodeDoIt send: #doIt to: self
]
