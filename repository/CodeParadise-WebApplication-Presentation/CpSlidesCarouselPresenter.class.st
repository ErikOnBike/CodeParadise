"
I am a SlideCarouselPresenter.
I support a SlideDeckModel and use a SlideCarouselView.

"
Class {
	#name : #CpSlidesCarouselPresenter,
	#superclass : #CpPresenter,
	#instVars : [
		'currentSlideIndex'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #model }
CpSlidesCarouselPresenter >> currentSlide [

	| slideModels |

	slideModels := self slideModels.

	^ slideModels at: ((self currentSlideIndex - 1) \\ (slideModels size)) + 1
]

{ #category : #accessing }
CpSlidesCarouselPresenter >> currentSlideIndex [

	^ currentSlideIndex ifNil: [ currentSlideIndex := self slideModels indexOf: self model currentSlide ]
]

{ #category : #accessing }
CpSlidesCarouselPresenter >> currentSlideIndex: anInteger [

	currentSlideIndex := anInteger
]

{ #category : #'user interaction' }
CpSlidesCarouselPresenter >> nextSlide [

	"No need to take account wrapping, is done in #currentSlide"

	self currentSlideIndex: self currentSlideIndex + 1
]

{ #category : #'user interaction' }
CpSlidesCarouselPresenter >> previousSlide [

	"No need to take account wrapping, is done in #currentSlide"

	self currentSlideIndex: self currentSlideIndex - 1
]

{ #category : #view }
CpSlidesCarouselPresenter >> renderCurrentSlide [

	self view renderSlidesCenteredAround: self currentSlideIndex
]

{ #category : #view }
CpSlidesCarouselPresenter >> renderView [

	"Render view of the receiver"

	self renderAllChildViewsForModels: self slideModels usingPresenter: CpCarouselSlidePresenter.

	"Render the current slide AFTER the children have been rendered"
	self renderCurrentSlide
]

{ #category : #model }
CpSlidesCarouselPresenter >> slideModels [

	^ self model slideDeck slides
]
