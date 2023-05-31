"
I am a CarouselSlide Presenter.
I support a SlideModel and use a CarouselSlideView.

"
Class {
	#name : #CpCarouselSlidePresenter,
	#superclass : #CpPresenter,
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #view }
CpCarouselSlidePresenter >> renderView [

	"Render view of the receiver"

	self renderChildViewForModel: self slideModel

]

{ #category : #model }
CpCarouselSlidePresenter >> slideModel [

	^ self model
]
