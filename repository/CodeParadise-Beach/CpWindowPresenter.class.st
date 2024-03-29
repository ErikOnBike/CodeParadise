Class {
	#name : #CpWindowPresenter,
	#superclass : #CpPresenter,
	#instVars : [
		'position',
		'width',
		'height'
	],
	#category : #'CodeParadise-Beach-Presenters'
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

{ #category : #presenters }
CpWindowPresenter >> preferredTitlePresenterClass [

	^ CpWindowTitlePresenter
]

{ #category : #view }
CpWindowPresenter >> renderView [

	"Render view of the receiver"

	"Update position (if known) and size"
	position ifNotNil: [ self view renderPosition: position ].
	self view renderWidth: width height: height.

	"Render title and content"
	self
		renderChildViewForModel: self model
		usingPresenter: [ :each | self preferredTitlePresenterClass ]
		atSlotNamed: #title.

	self
		renderChildViewForModel: self model
		atSlotNamed: #content
]

{ #category : #private }
CpWindowPresenter >> updateWindow: aWindowUpdate [

	"Update the Window information by storing it in the receiver's instance variables"

	position := aWindowUpdate position.
	width := aWindowUpdate width.
	height := aWindowUpdate height
]

{ #category : #view }
CpWindowPresenter >> viewCreated [

	super viewCreated.

	self view
		when: CpWindowClose send: #closeWindow to: self ;
		when: CpWindowUpdate send: #updateWindow: to: self
]
