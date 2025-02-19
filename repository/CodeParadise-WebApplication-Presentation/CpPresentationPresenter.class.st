"
I am a Presentation Presenter.
I support a PresentationModel and use a PresentationView.
"
Class {
	#name : #CpPresentationPresenter,
	#superclass : #CpPresenter,
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #model }
CpPresentationPresenter >> currentSlideModel [

	^ self model currentSlide
]

{ #category : #'user interaction' }
CpPresentationPresenter >> nextSlide [

	self slidesCarouselPresenter
		ifNotNil: [ :slidesCarouselPresenter | slidesCarouselPresenter nextSlide ; renderCurrentSlide ]
		ifNil: [ self model nextSlide ]
]

{ #category : #'user interaction' }
CpPresentationPresenter >> previousSlide [

	self slidesCarouselPresenter
		ifNotNil: [ :slidesCarouselPresenter | slidesCarouselPresenter previousSlide ; renderCurrentSlide ]
		ifNil: [ self model previousSlide ]
]

{ #category : #'user interaction' }
CpPresentationPresenter >> refreshSlide [

	self renderView
]

{ #category : #'user interaction' }
CpPresentationPresenter >> removeSlideIndex [

	self slidesCarouselPresenter
		ifNotNil: [ :slidesCarouselPresenter | slidesCarouselPresenter destroy ]
]

{ #category : #view }
CpPresentationPresenter >> renderView [

	"Render view of the receiver"

	"Render the current slide"
	self renderChildViewForModel: self currentSlideModel atSlotNamed: #slide.

	"Only render the carousel if it is present"
	self slidesCarouselPresenter
		ifNotNil: [ :slidesCarouselPresenter | slidesCarouselPresenter renderView ].

	self view renderTitle: self model title
]

{ #category : #'user interaction' }
CpPresentationPresenter >> slideSelected: aSlide [

	self model goToSlide: aSlide
]

{ #category : #'presenter - carousel' }
CpPresentationPresenter >> slidesCarouselPresenter [

	"Answer the slides carousel Presenter or nil if it is not currently present"

	^ self firstChildPresenterAtSlotNamed: #carousel
]

{ #category : #'user interaction' }
CpPresentationPresenter >> toggleSlideIndex [

	"Toggle the presence of the carousel presenter"

	self slidesCarouselPresenter
		ifNotNil: [ :carouselPresenter |

			"Position the presentation where the carousel is"
			self model goToSlide: carouselPresenter currentSlide.
			carouselPresenter destroy ]
		ifNil: [ self renderChildViewForModel: self model usingPresenter: CpSlidesCarouselPresenter atSlotNamed: #carousel ]
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
