"
I am a SlideContent Presenter specialized for BulletedContent.
I support a BulletedContentModel and use a BulletedContentView.
"
Class {
	#name : #CpBulletedContentPresenter,
	#superclass : #CpSlideContentPresenter,
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #model }
CpBulletedContentPresenter >> bulletModels [

	^ self model bullets
]

{ #category : #view }
CpBulletedContentPresenter >> renderView [

	"Render view of the receiver"

	self renderAllChildViewsForModels: self bulletModels usingPresenter: CpBulletPresenter
]
