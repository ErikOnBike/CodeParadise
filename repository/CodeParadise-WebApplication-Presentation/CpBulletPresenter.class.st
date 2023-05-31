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

{ #category : #model }
CpBulletPresenter >> contentModel [

	^ self model
]

{ #category : #view }
CpBulletPresenter >> renderView [

	"Render view of the receiver"

	"Mark content being (sub)bullets"
	self contentModel class = CpBulletedContent
		ifTrue: [ self view addClass: #sub ]
		ifFalse: [ self view removeClass: #sub ]. 

	"Delegate rendering to child presenter(s)"
	self renderChildViewForModel: self contentModel
]

{ #category : #'user interaction' }
CpBulletPresenter >> slideSelected: aSlide [

	self parent slideSelected: aSlide
]
