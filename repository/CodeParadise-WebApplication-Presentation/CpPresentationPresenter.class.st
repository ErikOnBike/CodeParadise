Class {
	#name : #CpPresentationPresenter,
	#superclass : #CpPresenter,
	#instVars : [
		'slidePresenter'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #accessing }
CpPresentationPresenter class >> defaultViewClass [

	^ CpPresentationView
]

{ #category : #presenter }
CpPresentationPresenter >> createSlidePresenter [

	"Create a new Slide Presenter for the receiver's model"

	| currentSlideModel |

	currentSlideModel := self currentSlideModel.

	self destroySlidePresenter.
	slidePresenter := self
		createChildPresenter: currentSlideModel preferredPresenterClass
		forModel: currentSlideModel
]

{ #category : #model }
CpPresentationPresenter >> currentSlideModel [

	^ self model currentSlide
]

{ #category : #view }
CpPresentationPresenter >> defaultViewLocation [

	"Answer the default location of the receiver's view (see also #viewLocation).
	The result should be the id of the parent DOM element for the receiver's view
	(i.e. the location where the receiver's view will be appended to).

	Implementation:
	See CpPresentationClientBehavior >> #initialize"

	^ 'screen'
]

{ #category : #deleting }
CpPresentationPresenter >> destroy [

	"Destroy the receiver, but first its children"

	self destroySlidePresenter.

	super destroy
]

{ #category : #presenter }
CpPresentationPresenter >> destroySlidePresenter [

	"Destroy the Slide Presenter of the receiver's model"

	slidePresenter
		ifNil: [ ^ self ].

	slidePresenter destroy.
	slidePresenter := nil
]

{ #category : #presenter }
CpPresentationPresenter >> hasSlidePresenter [

	^ self slidePresenter notNil
]

{ #category : #model }
CpPresentationPresenter >> nextSlide [

	self model nextSlide
]

{ #category : #model }
CpPresentationPresenter >> previousSlide [

	self model previousSlide
]

{ #category : #view }
CpPresentationPresenter >> refreshSlide [

	self renderView
]

{ #category : #view }
CpPresentationPresenter >> renderView [

	"Render view of the receiver"

	self view renderTitle: self model title.

	"Delegate rendering to child presenter(s)"
	self updateSlidePresenter.
	self hasSlidePresenter
		ifTrue: [ self slidePresenter renderView ]

]

{ #category : #presenter }
CpPresentationPresenter >> slidePresenter [

	^ slidePresenter
]

{ #category : #presenter }
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

{ #category : #view }
CpPresentationPresenter >> viewCreated [

	super viewCreated.

	self view
		when: CpPreviousSlide send: #previousSlide to: self ;
		when: CpNextSlide send: #nextSlide to: self ;
		when: CpRefreshSlide send: #refreshSlide to: self
]
