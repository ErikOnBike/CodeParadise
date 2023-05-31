"
I am a SlidePresenter specialized in TitledSlides.
I support a TitledSlideModel and use a TitledSlideView.
"
Class {
	#name : #CpTitledSlidePresenter,
	#superclass : #CpSlidePresenter,
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #view }
CpTitledSlidePresenter >> renderView [

	"Render view of the receiver"

	super renderView.

	self view renderTitle: self model title
]
