"
I am a SlideContent Presenter specialized in TextContent.
I support a TextContentModel and use TextContentView.
"
Class {
	#name : #CpTextContentPresenter,
	#superclass : #CpSlideContentPresenter,
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #view }
CpTextContentPresenter >> renderView [

	self view textContent: self model text
]
