"
I am a Presenter for a Counter Model.
"
Class {
	#name : #CpCounterPresenter,
	#superclass : #CpPresenter,
	#category : #'CodeParadise-WebApplication-MVP-Examples'
}

{ #category : #model }
CpCounterPresenter >> modelDecrease [

	self model decrease
]

{ #category : #model }
CpCounterPresenter >> modelIncrease [

	self model increase
]

{ #category : #view }
CpCounterPresenter >> renderView [

	self view renderValue: self model value
]

{ #category : #view }
CpCounterPresenter >> viewCreated [

	super viewCreated.

	self view
		when: CpCounterIncrease send: #modelIncrease to: self ;
		when: CpCounterDecrease send: #modelDecrease to: self
]
