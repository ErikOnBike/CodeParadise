Class {
	#name : #CpTextContentPresenter,
	#superclass : #CpSlideContentPresenter,
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #accessing }
CpTextContentPresenter class >> defaultViewClass [

	^ CpTextContentView
]

{ #category : #view }
CpTextContentPresenter >> renderView [

	self view textContent: self model text
]
