"
I am a SlidePresenter.
I support a SlideModel and use a model specific view.
"
Class {
	#name : #CpSlidePresenter,
	#superclass : #CpPresenter,
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #model }
CpSlidePresenter >> contentModel [

	^ self model content
]

{ #category : #view }
CpSlidePresenter >> renderView [

	"Render view of the receiver"

	self renderChildViewForModel: self contentModel atSlotNamed: #content
]

{ #category : #'user interaction' }
CpSlidePresenter >> slideSelected: aSlide [

	self parent slideSelected: aSlide
]
