Class {
	#name : #CpHtmlContentPresenter,
	#superclass : #CpSlideContentPresenter,
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #view }
CpHtmlContentPresenter >> renderView [

	self view markupContent: self model html
]
