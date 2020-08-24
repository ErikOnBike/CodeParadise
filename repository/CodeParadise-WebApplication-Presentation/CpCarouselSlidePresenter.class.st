"
I am a CarouselSlide Presenter.
I support a SlideModel and use a CarouselSlideView.

"
Class {
	#name : #CpCarouselSlidePresenter,
	#superclass : #CpPresenter,
	#instVars : [
		'slidePresenter'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #accessing }
CpCarouselSlidePresenter class >> defaultViewClass [

	^ CpCarouselSlideView
]

{ #category : #presenter }
CpCarouselSlidePresenter >> createSlidePresenter [

	"Create a new Slide Presenter for the receiver's model"

	| slideModel |

	slideModel := self slideModel.

	self destroySlidePresenter.
	slidePresenter := self
		createChildPresenter: slideModel preferredPresenterClass
		forModel: slideModel
]

{ #category : #deleting }
CpCarouselSlidePresenter >> destroy [

	"Destroy the receiver, but first its children"

	self destroySlidePresenter.

	super destroy
]

{ #category : #presenter }
CpCarouselSlidePresenter >> destroySlidePresenter [

	"Destroy the Slide Presenter of the receiver's model"

	slidePresenter
		ifNil: [ ^ self ].

	slidePresenter destroy.
	slidePresenter := nil
]

{ #category : #testing }
CpCarouselSlidePresenter >> hasSlidePresenter [

	^ self slidePresenter notNil
]

{ #category : #view }
CpCarouselSlidePresenter >> renderView [

	"Render view of the receiver"

	"Delegate rendering to child presenter(s)"
	self updateSlidePresenter.
	self slidePresenter renderView

]

{ #category : #model }
CpCarouselSlidePresenter >> slideModel [

	^ self model
]

{ #category : #testing }
CpCarouselSlidePresenter >> slidePresenter [

	^ slidePresenter
]

{ #category : #presenter }
CpCarouselSlidePresenter >> updateSlidePresenter [

	"Update the Slide Presenter.
	If necessary a new Presenter is created or the existing is updated."

	| slideModel |

	(slideModel := self slideModel)
		ifNil: [ ^ self destroySlidePresenter ].

	(self hasSlidePresenter and: [ self slidePresenter class = self slideModel preferredPresenterClass ])
		ifTrue: [
				self slidePresenter model ~= slideModel
					ifTrue: [ self slidePresenter model: slideModel ] ]
		ifFalse: [ self createSlidePresenter ]
]
