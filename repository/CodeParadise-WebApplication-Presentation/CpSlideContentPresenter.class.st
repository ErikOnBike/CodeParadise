"
I am a SlideContent Presenter.
I support a SlideContentModel and use a model specific View.
"
Class {
	#name : 'CpSlideContentPresenter',
	#superclass : 'CpPresenter',
	#category : 'CodeParadise-WebApplication-Presentation-Presenter',
	#package : 'CodeParadise-WebApplication-Presentation',
	#tag : 'Presenter'
}

{ #category : 'user interaction' }
CpSlideContentPresenter >> slideSelected: aSlide [

	self parent slideSelected: aSlide
]
