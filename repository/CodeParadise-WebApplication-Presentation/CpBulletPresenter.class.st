"
I am a Bullet Presenter.
I support a SlideContentModel and use a BulletView.

"
Class {
	#name : #CpBulletPresenter,
	#superclass : #CpPresenter,
	#instVars : [
		'contentPresenter'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #accessing }
CpBulletPresenter class >> defaultViewClass [

	^ CpBulletView
]

{ #category : #model }
CpBulletPresenter >> contentModel [

	^ self model
]

{ #category : #testing }
CpBulletPresenter >> contentPresenter [

	^ contentPresenter
]

{ #category : #presenter }
CpBulletPresenter >> createContentPresenter [

	"Create a new Slide Presenter for the receiver's model"

	| contentModel |

	contentModel := self contentModel.

	self destroyContentPresenter.
	contentPresenter := self
		createChildPresenter: contentModel preferredPresenterClass
		forModel: contentModel
]

{ #category : #deleting }
CpBulletPresenter >> destroy [

	"Destroy the receiver, but first its children"

	self destroyContentPresenter.

	super destroy
]

{ #category : #presenter }
CpBulletPresenter >> destroyContentPresenter [

	"Destroy the SlideContent Presenter of the receiver's model"

	contentPresenter
		ifNil: [ ^ self ].

	contentPresenter destroy.
	contentPresenter := nil
]

{ #category : #testing }
CpBulletPresenter >> hasContentPresenter [

	^ self contentPresenter notNil
]

{ #category : #view }
CpBulletPresenter >> renderView [

	"Render view of the receiver"

	"Delegate rendering to child presenter(s)"
	self updateContentPresenter.
	self contentModel class = CpBulletedContent
		ifTrue: [ self view addClass: #sub ]
		ifFalse: [ self view removeClass: #sub ]. 
	self contentPresenter renderView

]

{ #category : #presenter }
CpBulletPresenter >> updateContentPresenter [

	"Update the SlideContent Presenter.
	If necessary a new Presenter is created or the existing is updated."

	| contentModel |

	(contentModel := self contentModel)
		ifNil: [ ^ self destroyContentPresenter ].

	(self hasContentPresenter and: [ self contentPresenter class = self contentModel preferredPresenterClass ])
		ifTrue: [
				self contentPresenter model ~= contentModel
					ifTrue: [ self contentPresenter model: contentModel ] ]
		ifFalse: [ self createContentPresenter ]
]
