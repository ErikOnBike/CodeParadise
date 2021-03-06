"
I am a SlideContent Presenter specialized for BulletedContent.
I support a BulletedContentModel and use a BulletedContentView.
"
Class {
	#name : #CpBulletedContentPresenter,
	#superclass : #CpSlideContentPresenter,
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

{ #category : #presenters }
CpBulletedContentPresenter >> presenterClassForModel: aModel atSlotNamed: aString [

	^ CpBulletPresenter
]

{ #category : #view }
CpBulletedContentPresenter >> renderView [

	"Render view of the receiver"

	self renderAllChildViewsForModels: self bulletModels
]
