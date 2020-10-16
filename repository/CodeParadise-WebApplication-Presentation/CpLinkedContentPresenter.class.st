Class {
	#name : #CpLinkedContentPresenter,
	#superclass : #CpSlideContentPresenter,
	#instVars : [
		'contentPresenter'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #accessing }
CpLinkedContentPresenter class >> defaultViewClass [

	^ CpLinkedContentView
]

{ #category : #model }
CpLinkedContentPresenter >> contentModel [

	^ self model content
]

{ #category : #presenter }
CpLinkedContentPresenter >> contentPresenter [

	^ contentPresenter
]

{ #category : #presenter }
CpLinkedContentPresenter >> createContentPresenter [

	"Create a new SlideContent Presenter for the receiver's model"

	| contentModel |

	contentModel := self contentModel.

	self destroyContentPresenter.
	contentPresenter := self
		createChildPresenter: contentModel preferredPresenterClass
		forModel: contentModel
]

{ #category : #deleting }
CpLinkedContentPresenter >> destroy [

	"Destroy the receiver, but first its children"

	self destroyContentPresenter.

	super destroy
]

{ #category : #presenter }
CpLinkedContentPresenter >> destroyContentPresenter [

	"Destroy the SlideContent Presenter of the receiver's model"

	contentPresenter
		ifNil: [ ^ self ].

	contentPresenter destroy.
	contentPresenter := nil
]

{ #category : #presenter }
CpLinkedContentPresenter >> hasContentPresenter [

	^ self contentPresenter notNil
]

{ #category : #'user interaction' }
CpLinkedContentPresenter >> linkedSlideSelected [

	self parent slideSelected: self model linkedSlide
]

{ #category : #view }
CpLinkedContentPresenter >> renderView [

	"Render view of the receiver"

	"Delegate rendering to child presenter(s)"
	self updateContentPresenter.
	self hasContentPresenter
		ifTrue: [ self contentPresenter renderView ]

]

{ #category : #presenter }
CpLinkedContentPresenter >> updateContentPresenter [

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

{ #category : #view }
CpLinkedContentPresenter >> viewCreated [

	super viewCreated.

	self view
		when: CpLinkActivated send: #linkedSlideSelected to: self
]
