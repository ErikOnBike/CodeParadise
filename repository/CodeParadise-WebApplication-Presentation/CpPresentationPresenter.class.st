"
I am a Presentation Presenter.
I support a PresentationModel and use a PresentationView.
"
Class {
	#name : #CpPresentationPresenter,
	#superclass : #CpPresenter,
	#instVars : [
		'slidePresenter',
		'slidesCarouselPresenter'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #accessing }
CpPresentationPresenter class >> defaultViewClass [

	^ CpPresentationView
]

{ #category : #'presenter - slide' }
CpPresentationPresenter >> createSlidePresenter [

	"Create a new Slide Presenter for the receiver's model"

	| currentSlideModel |

	currentSlideModel := self currentSlideModel.

	self destroySlidePresenter.
	slidePresenter := self
		createChildPresenter: currentSlideModel preferredPresenterClass
		forModel: currentSlideModel
]

{ #category : #'presenter - carousel' }
CpPresentationPresenter >> createSlidesCarouselPresenter [

	"Create a new SlidesCarousel Presenter for the receiver's model"

	self destroySlidesCarouselPresenter.
	slidesCarouselPresenter := self
		createChildPresenter: CpSlidesCarouselPresenter
		forModel: self model
]

{ #category : #model }
CpPresentationPresenter >> currentSlideModel [

	^ self model currentSlide
]

{ #category : #deleting }
CpPresentationPresenter >> destroy [

	"Destroy the receiver, but first its children"

	self destroySlidePresenter.

	super destroy
]

{ #category : #'presenter - slide' }
CpPresentationPresenter >> destroySlidePresenter [

	"Destroy the Slide Presenter of the receiver's model"

	slidePresenter
		ifNil: [ ^ self ].

	slidePresenter destroy.
	slidePresenter := nil
]

{ #category : #'presenter - carousel' }
CpPresentationPresenter >> destroySlidesCarouselPresenter [

	"Destroy the SlidesCarousel Presenter of the receiver's model"

	slidesCarouselPresenter
		ifNil: [ ^ self ].

	slidesCarouselPresenter destroy.
	slidesCarouselPresenter := nil
]

{ #category : #'presenter - slide' }
CpPresentationPresenter >> hasSlidePresenter [

	^ self slidePresenter notNil
]

{ #category : #'presenter - carousel' }
CpPresentationPresenter >> hasSlidesCarouselPresenter [

	^ self slidesCarouselPresenter notNil
]

{ #category : #'user interaction' }
CpPresentationPresenter >> nextSlide [

	self hasSlidesCarouselPresenter
		ifTrue: [ self slidesCarouselPresenter nextSlide ; renderCurrentSlide ]
		ifFalse: [ self model nextSlide ]
]

{ #category : #'user interaction' }
CpPresentationPresenter >> previousSlide [

	self hasSlidesCarouselPresenter
		ifTrue: [ self slidesCarouselPresenter previousSlide ; renderCurrentSlide ]
		ifFalse: [ self model previousSlide ]
]

{ #category : #'user interaction' }
CpPresentationPresenter >> refreshSlide [

	self renderView
]

{ #category : #'user interaction' }
CpPresentationPresenter >> removeSlideIndex [

	self hasSlidesCarouselPresenter
		ifTrue: [ self destroySlidesCarouselPresenter ]
]

{ #category : #view }
CpPresentationPresenter >> renderView [

	"Render view of the receiver"

	self view renderTitle: self model title.

	"Delegate rendering to child presenter(s)"
	self updateSlidePresenter.
	self hasSlidePresenter
		ifTrue: [ self slidePresenter renderView ].

	self hasSlidesCarouselPresenter
		ifTrue: [
			self updateSlidesCarouselPresenter.
			self slidesCarouselPresenter renderView ]

]

{ #category : #'presenter - slide' }
CpPresentationPresenter >> slidePresenter [

	^ slidePresenter
]

{ #category : #'user interaction' }
CpPresentationPresenter >> slideSelected: aSlide [

	self model goToSlide: aSlide
]

{ #category : #'presenter - carousel' }
CpPresentationPresenter >> slidesCarouselPresenter [

	^ slidesCarouselPresenter
]

{ #category : #'user interaction' }
CpPresentationPresenter >> toggleSlideIndex [

	self hasSlidesCarouselPresenter
		ifTrue: [
			| selectedSlide |
			selectedSlide := self slidesCarouselPresenter currentSlide.
			self destroySlidesCarouselPresenter.
			self model goToSlide: selectedSlide ]
		ifFalse: [
			self createSlidesCarouselPresenter.
			self slidesCarouselPresenter renderView ]
]

{ #category : #'presenter - slide' }
CpPresentationPresenter >> updateSlidePresenter [

	"Update the Slide Presenter.
	If necessary a new Presenter is created or the existing is updated."

	| currentSlideModel |

	(currentSlideModel := self currentSlideModel)
		ifNil: [ ^ self destroySlidePresenter ].

	(self hasSlidePresenter and: [ self slidePresenter class = self currentSlideModel preferredPresenterClass ])
		ifTrue: [
				self slidePresenter model ~= currentSlideModel
					ifTrue: [ self slidePresenter model: currentSlideModel ] ]
		ifFalse: [ self createSlidePresenter ]
]

{ #category : #'presenter - carousel' }
CpPresentationPresenter >> updateSlidesCarouselPresenter [

	"Update the SlidesCarousel Presenter.
	If necessary a new Presenter is created or the existing is updated."

	self hasSlidesCarouselPresenter
		ifTrue: [
				self slidesCarouselPresenter model ~= self model
					ifTrue: [ self slidesCarouselPresenter model: self model ] ]
		ifFalse: [ self createSlidesCarouselPresenter ]
]

{ #category : #view }
CpPresentationPresenter >> viewCreated [

	super viewCreated.

	self view
		when: CpPreviousSlide send: #previousSlide to: self ;
		when: CpNextSlide send: #nextSlide to: self ;
		when: CpRefreshSlide send: #refreshSlide to: self ;
		when: CpSlideIndex send: #toggleSlideIndex to: self ;
		when: CpRemoveSlideIndex send: #removeSlideIndex to: self
]
