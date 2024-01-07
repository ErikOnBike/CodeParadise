Class {
	#name : 'CpHtmlContentPresenter',
	#superclass : 'CpSlideContentPresenter',
	#category : 'CodeParadise-WebApplication-Presentation-Presenter',
	#package : 'CodeParadise-WebApplication-Presentation',
	#tag : 'Presenter'
}

{ #category : 'view' }
CpHtmlContentPresenter >> renderView [

	self view markupContent: self model html
]
