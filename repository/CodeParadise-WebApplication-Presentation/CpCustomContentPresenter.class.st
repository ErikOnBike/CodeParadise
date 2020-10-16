"
I am a SlideContent Presenter for custom content.
I support a CustomContentModel and use a model specific view.
"
Class {
	#name : #CpCustomContentPresenter,
	#superclass : #CpSlideContentPresenter,
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #view }
CpCustomContentPresenter >> renderView [

	self view render
		
]

{ #category : #view }
CpCustomContentPresenter >> viewClass [

	^ self model viewClass
]
