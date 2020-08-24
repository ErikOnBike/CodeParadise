"
I am a SlideContent Presenter specialized for BulletedContent.
I support a BulletedContentModel and use a BulletedContentView.
"
Class {
	#name : #CpBulletedContentPresenter,
	#superclass : #CpSlideContentPresenter,
	#instVars : [
		'bulletPresenters'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #accessing }
CpBulletedContentPresenter class >> defaultViewClass [

	^ CpBulletedContentView
]

{ #category : #model }
CpBulletedContentPresenter >> bulletModels [

	^ self model bullets
]

{ #category : #presenter }
CpBulletedContentPresenter >> bulletPresenters [

	^ bulletPresenters
]

{ #category : #presenter }
CpBulletedContentPresenter >> createBulletPresenterFor: aSlideContentModel at: anInteger [

	"Add a new SlideContent presenter at the specified location.

	Implementation:
	This method is executed in order, therefore bullet presenters
	can be added when a 'missing' presenter is encountered."

	| bulletPresenter |

	bulletPresenter := self
		createChildPresenter: CpBulletPresenter
		forModel: aSlideContentModel.

	anInteger <= self bulletPresenters size
		ifTrue: [
			(self bulletPresenters at: anInteger) destroy.
			self bulletPresenters at: anInteger put: bulletPresenter ]
		ifFalse: [ self bulletPresenters add: bulletPresenter ]

]

{ #category : #deleting }
CpBulletedContentPresenter >> destroy [

	"Destroy the receiver, but first its children"

	self destroyBulletPresenters.

	super destroy
]

{ #category : #presenter }
CpBulletedContentPresenter >> destroyBulletPresenters [.

	"Destroy the SlideContent Presenters of the receiver's bullets"

	bulletPresenters
		ifEmpty: [ ^ self ].

	bulletPresenters do: [ :each | each destroy ].
	bulletPresenters removeAll
]

{ #category : #initialization }
CpBulletedContentPresenter >> initialize [

	super initialize.

	bulletPresenters := OrderedCollection new
]

{ #category : #view }
CpBulletedContentPresenter >> renderView [

	"Render view of the receiver"

	"Delegate rendering to child presenter(s)"
	self updateBulletPresenters.
	self bulletPresenters do: [ :each | each renderView ]

]

{ #category : #presenter }
CpBulletedContentPresenter >> updateBullet: aSlideContentModel atPresenterIndex: anInteger [

	"Update the SlideContent Presenter of a single bullet item.
	If necessary a new Presenter is created or the existing is updated.

	Implementation:
	This method is executed in order, therefore bullet presenters
	can be added when a 'missing' presenter is encountered."

	| bulletPresenter |

	bulletPresenter := self bulletPresenters at: anInteger ifAbsent: [ nil ].
	(bulletPresenter notNil and: [ bulletPresenter class = aSlideContentModel preferredPresenterClass ])
		ifTrue: [
				bulletPresenter model ~= aSlideContentModel
					ifTrue: [ bulletPresenter model: aSlideContentModel ] ]
		ifFalse: [ self createBulletPresenterFor: aSlideContentModel at: anInteger ]
]

{ #category : #presenter }
CpBulletedContentPresenter >> updateBulletPresenters [

	"Update the SlideContent Presenters for the receiver's bullets.
	If necessary a new Presenters are created or existing is updated."

	| bulletModels |

	(bulletModels := self bulletModels)
		ifEmpty: [ ^ self destroyBulletPresenters ].

	bulletModels withIndexDo: [ :each :index | self updateBullet: each atPresenterIndex: index ]
]
