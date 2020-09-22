Class {
	#name : #CpHtmlContentPresenter,
	#superclass : #CpSlideContentPresenter,
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #accessing }
CpHtmlContentPresenter class >> defaultViewClass [

	^ CpHtmlContentView
]

{ #category : #view }
CpHtmlContentPresenter >> renderView [

	self view markupContent: self model html
]
