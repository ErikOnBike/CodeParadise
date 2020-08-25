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

{ #category : #model }
CpLinkedContentPresenter >> contentPresenter [

	^ contentPresenter
]

{ #category : #model }
CpLinkedContentPresenter >> createContentPresenter [

	"Create a new SlideContent Presenter for the receiver's model"

	| contentModel |

	contentModel := self contentModel.

	self destroyContentPresenter.
	contentPresenter := self
		createChildPresenter: contentModel preferredPresenterClass
		forModel: contentModel
]

{ #category : #model }
CpLinkedContentPresenter >> destroy [

	"Destroy the receiver, but first its children"

	self destroyContentPresenter.

	super destroy
]

{ #category : #model }
CpLinkedContentPresenter >> destroyContentPresenter [

	"Destroy the SlideContent Presenter of the receiver's model"

	contentPresenter
		ifNil: [ ^ self ].

	contentPresenter destroy.
	contentPresenter := nil
]

{ #category : #model }
CpLinkedContentPresenter >> hasContentPresenter [

	^ self contentPresenter notNil
]

{ #category : #view }
CpLinkedContentPresenter >> linkedSlideSelected [

	self parent slideSelected: self model linkedSlide
]

{ #category : #model }
CpLinkedContentPresenter >> renderView [

	"Render view of the receiver"

	"Delegate rendering to child presenter(s)"
	self updateContentPresenter.
	self hasContentPresenter
		ifTrue: [ self contentPresenter renderView ]

]

{ #category : #model }
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
