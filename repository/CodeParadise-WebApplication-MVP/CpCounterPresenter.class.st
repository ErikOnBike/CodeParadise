"
I am a Presenter for a Counter Model.
"
Class {
	#name : #CpCounterPresenter,
	#superclass : #CpPresenter,
	#category : #'CodeParadise-WebApplication-MVP-Examples'
}

{ #category : #accessing }
CpCounterPresenter class >> defaultViewClass [

	^ CpCounterView
]

{ #category : #view }
CpCounterPresenter >> createView [

	super createView.

	self view
		when: CpCounterDecrease do: [ self model decrease ] ;
		when: CpCounterIncrease do: [ self model increase ].

	self eventHandler registerInterestIn: self view.

	^ self view
]

{ #category : #model }
CpCounterPresenter >> modelChanged: aSymbol [

	super modelChanged: aSymbol.

	self renderView
]

{ #category : #view }
CpCounterPresenter >> renderView [

	self view renderValue: self model value
]
