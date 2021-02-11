Class {
	#name : #CpWindowPresenter,
	#superclass : #CpPresenter,
	#instVars : [
		'titlePresenter',
		'contentPresenter'
	],
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #accessing }
CpWindowPresenter class >> defaultViewClass [

	^ CpWindow
]

{ #category : #private }
CpWindowPresenter >> closeWindow [

	"Close the receiver"

	self destroy
]

{ #category : #presenter }
CpWindowPresenter >> contentPresenter [

	^ contentPresenter
]

{ #category : #presenter }
CpWindowPresenter >> createContentPresenter [

	"Create a new content Presenter for the receiver's model"

	| contentModel |

	contentModel := self model.

	self destroyContentPresenter.
	contentPresenter := self
		createChildPresenter: (contentModel preferredPresenterClassIn: self)
		atSlotNamed: #content
		forModel: contentModel
]

{ #category : #presenter }
CpWindowPresenter >> destroy [

	"Destroy the receiver, but first its children"

	self flag: #todo. "Also destroy title presenter. Perhaps do this in 1 go with implementing 
	presenter (value holder) patterns."
	"self destroyTitlePresenter."
	self destroyContentPresenter.

	super destroy
]

{ #category : #presenter }
CpWindowPresenter >> destroyContentPresenter [

	"Destroy the content Presenter of the receiver's model"

	contentPresenter
		ifNil: [ ^ self ].

	contentPresenter destroy.
	contentPresenter := nil
]

{ #category : #presenter }
CpWindowPresenter >> hasContentPresenter [

	^ self contentPresenter notNil
]

{ #category : #view }
CpWindowPresenter >> renderView [

	"Render view of the receiver"

	titlePresenter
		ifNotNil: [ titlePresenter renderView ]
		ifNil: [ titlePresenter := self createChildPresenter: CpWindowTitlePresenter atSlotNamed: #title forModel: self model ].

	"Delegate rendering to child presenter(s)"
	self updateContentPresenter.
	self hasContentPresenter
		ifTrue: [ self contentPresenter renderView ]

]

{ #category : #presenter }
CpWindowPresenter >> updateContentPresenter [

	"Update the content Presenter.
	If necessary a new Presenter is created or the existing is updated."

	| contentModel |

	(contentModel := self model)
		ifNil: [ ^ self destroyContentPresenter ].

	(self hasContentPresenter and: [ self contentPresenter class = (contentModel preferredPresenterClassIn: self) ])
		ifTrue: [
			self contentPresenter model ~= contentModel
				ifTrue: [ self contentPresenter model: contentModel ] ]
		ifFalse: [ self createContentPresenter ]
]

{ #category : #view }
CpWindowPresenter >> viewCreated [

	super viewCreated.

	self view
		when: CpWindowClose send: #closeWindow to: self
]
