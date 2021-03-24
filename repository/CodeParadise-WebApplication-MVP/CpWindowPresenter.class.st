Class {
	#name : #CpWindowPresenter,
	#superclass : #CpPresenter,
	#instVars : [
		'position',
		'size'
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

{ #category : #presenters }
CpWindowPresenter >> presenterClassFor: aModel atSlotNamed: aString [

	^ aString = #title
		ifTrue: [ CpWindowTitlePresenter ]
		ifFalse: [ aModel preferredPresenterClass ]
]

{ #category : #view }
CpWindowPresenter >> renderView [

	"Render view of the receiver"

	"Update size and position (if known)"
	position ifNotNil: [ self view renderPosition: position ].
	size ifNotNil: [ self view renderSize: size ].

	"Render title and content"
	self
		renderChildViewForModel: self model atSlotNamed: #title ;
		renderChildViewForModel: self model atSlotNamed: #content
]

{ #category : #private }
CpWindowPresenter >> updateWindow: aWindowUpdate [

	"Update the Window information by storing it in the receiver's instance variables"

	position := aWindowUpdate position.
	size := aWindowUpdate size
]

{ #category : #view }
CpWindowPresenter >> viewCreated [

	super viewCreated.

	self view
		when: CpWindowClose send: #closeWindow to: self ;
		when: CpWindowUpdate send: #updateWindow: to: self
]
