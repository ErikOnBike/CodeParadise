Class {
	#name : #CpViewportPresenter,
	#superclass : #CpPresenter,
	#instVars : [
		'position'
	],
	#category : #'CodeParadise-Beach-Presenters'
}

{ #category : #accessing }
CpViewportPresenter class >> defaultViewClass [

	^ CpViewport
]

{ #category : #rendering }
CpViewportPresenter >> renderView [

	"Render view of the receiver"

	"Update position (if known)"
	position ifNotNil: [ self view renderPosition: position ]
]

{ #category : #private }
CpViewportPresenter >> updateViewport: aViewportUpdate [

	"Update the Viewport information by storing it in the receiver's instance variables"

	position := aViewportUpdate position
]

{ #category : #view }
CpViewportPresenter >> viewCreated [

	super viewCreated.

	self view
		when: CpViewportUpdate send: #updateViewport: to: self
]
