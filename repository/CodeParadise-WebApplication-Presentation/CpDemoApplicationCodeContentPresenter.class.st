Class {
	#name : #CpDemoApplicationCodeContentPresenter,
	#superclass : #CpDemoCodeContentPresenter,
	#category : #'CodeParadise-WebApplication-Presentation-Examples'
}

{ #category : #'user interaction' }
CpDemoApplicationCodeContentPresenter >> openInspector [

	"Open a new Inspector on the application showing the code of the receiver's model"

	self application openInspectorEvaluatorWithSelectedText: self model code

]

{ #category : #view }
CpDemoApplicationCodeContentPresenter >> viewCreated [

	super viewCreated.

	self view when: CpDemoCodeOpenInspector send: #openInspector to: self
]
