"
I am a SlidePresenter.
I support a SlideModel and use a model specific view.
"
Class {
	#name : #CpSlidePresenter,
	#superclass : #CpPresenter,
	#instVars : [
		'contentPresenter'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #model }
CpSlidePresenter >> contentModel [

	^ self model content
]

{ #category : #presenter }
CpSlidePresenter >> contentPresenter [

	^ contentPresenter
]

{ #category : #presenter }
CpSlidePresenter >> createContentPresenter [

	"Create a new SlideContent Presenter for the receiver's model"

	| contentModel |

	contentModel := self contentModel.

	self destroyContentPresenter.
	contentPresenter := self
		createChildPresenter: contentModel preferredPresenterClass
		atSlotNamed: #content
		forModel: contentModel
]

{ #category : #deleting }
CpSlidePresenter >> destroy [

	"Destroy the receiver, but first its children"

	self destroyContentPresenter.

	super destroy
]

{ #category : #presenter }
CpSlidePresenter >> destroyContentPresenter [

	"Destroy the SlideContent Presenter of the receiver's model"

	contentPresenter
		ifNil: [ ^ self ].

	contentPresenter destroy.
	contentPresenter := nil
]

{ #category : #presenter }
CpSlidePresenter >> hasContentPresenter [

	^ self contentPresenter notNil
]

{ #category : #view }
CpSlidePresenter >> renderView [

	"Render view of the receiver"

	"Delegate rendering to child presenter(s)"
	self updateContentPresenter.
	self hasContentPresenter
		ifTrue: [ self contentPresenter renderView ]

]

{ #category : #presenter }
CpSlidePresenter >> updateContentPresenter [

	"Update the SlideContent Presenter.
	If necessary a new Presenter is created or the existing is updated."

	| contentModel |

	(contentModel := self contentModel)
		ifNil: [ ^ self destroyContentPresenter ].

	(self hasContentPresenter and: [ self contentPresenter class = contentModel preferredPresenterClass ])
		ifTrue: [
			self contentPresenter model ~= contentModel
				ifTrue: [ self contentPresenter model: contentModel ] ]
		ifFalse: [ self createContentPresenter ]
]
