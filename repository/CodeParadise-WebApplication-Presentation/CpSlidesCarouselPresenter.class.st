"
I am a SlideCarouselPresenter.
I support a SlideDeckModel and use a SlideCarouselView.

"
Class {
	#name : #CpSlidesCarouselPresenter,
	#superclass : #CpPresenter,
	#instVars : [
		'slidePresenters',
		'currentSlideIndex'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #accessing }
CpSlidesCarouselPresenter class >> defaultViewClass [

	^ CpSlidesCarouselView
]

{ #category : #presenter }
CpSlidesCarouselPresenter >> createSlidePresenterFor: aSlideModel at: anInteger [

	"Add a new Slide presenter at the specified location.

	Implementation:
	This method is executed in order, therefore slide presenters
	can be added when a 'missing' presenter is encountered."

	| slidePresenter |

	slidePresenter := self
		createChildPresenter: CpCarouselSlidePresenter
		forModel: aSlideModel.

	anInteger <= self slidePresenters size
		ifTrue: [
			(self slidePresenters at: anInteger) destroy.
			self slidePresenters at: anInteger put: slidePresenter ]
		ifFalse: [ self slidePresenters add: slidePresenter ]
]

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

{ #category : #deleting }
CpSlidesCarouselPresenter >> destroy [

	"Destroy the receiver, but first its children"

	self destroySlidePresenters.

	super destroy
]

{ #category : #presenter }
CpSlidesCarouselPresenter >> destroySlidePresenters [.

	"Destroy the Slide Presenters of the receiver's presentation"

	slidePresenters
		ifEmpty: [ ^ self ].

	slidePresenters do: [ :each | each destroy ].
	slidePresenters removeAll
]

{ #category : #initialization }
CpSlidesCarouselPresenter >> initialize [

	super initialize.

	slidePresenters := OrderedCollection new
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

	"Delegate rendering to child presenter(s)"
	self updateSlidesPresenters.
	self slidePresenters do: [ :each | each renderView ].

	"Render the receiver AFTER the children have been rendered"
	self renderCurrentSlide

]

{ #category : #model }
CpSlidesCarouselPresenter >> slideModels [

	^ self model slideDeck slides
]

{ #category : #presenter }
CpSlidesCarouselPresenter >> slidePresenters [

	^ slidePresenters
]

{ #category : #presenter }
CpSlidesCarouselPresenter >> updateSlide: aSlideModel atPresenterIndex: anInteger [

	"Update the Slide Presenter of a single slide item.
	If necessary a new Presenter is created or the existing is updated.

	Implementation:
	This method is executed in order, therefore slide presenters
	can be added when a 'missing' presenter is encountered."

	| slidePresenter |

	slidePresenter := self slidePresenters at: anInteger ifAbsent: [ nil ].
	slidePresenter
		ifNotNil: [
				slidePresenter model ~= aSlideModel
					ifTrue: [ slidePresenter model: aSlideModel ] ]
		ifNil: [ self createSlidePresenterFor: aSlideModel at: anInteger ]
]

{ #category : #presenter }
CpSlidesCarouselPresenter >> updateSlidesPresenters [

	"Update the Slide Presenters for the receiver's presentation.
	If necessary a new Presenters are created or existing is updated."

	| slideModels |

	(slideModels := self slideModels)
		ifEmpty: [ ^ self destroySlidePresenters ].

	"Remove superfluous presenters and views"
	[ slideModels size < self slidePresenters size ] whileTrue: [
		self slidePresenters last destroy.
		self slidePresenters removeLast ].

	slideModels withIndexDo: [ :each :index | self updateSlide: each atPresenterIndex: index ]
]
