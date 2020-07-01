"
I am a Presenter in a Model-View-Presenter pattern.
I live in both the ClientEnvironment and the ServerEnvironment.
"
Class {
	#name : #CpPresenter,
	#superclass : #Object,
	#instVars : [
		'id',
		'model',
		'view'
	],
	#category : #'WebApplication-Core'
}

{ #category : #accessing }
CpPresenter class >> defaultViewClass [

	^ CpView
]

{ #category : #view }
CpPresenter >> createView [

	view ifNotNil: [ self error: 'View already created' ].

	view := self viewClass new
			id: self id ;
			yourself.

	self flag: #todo.	"Adding new view to the document should not be handled here"
	CpHtmlElement documentBody appendChild: view
]

{ #category : #view }
CpPresenter >> createViewProxyFor: anEnvironment [

	view ifNotNil: [ self error: 'View already created' ].

	"Retrieve class from Smalltalk dictionary to prevent the need for the Proxy to be available at client"
	view := (Smalltalk classNamed: #CpViewProxy) newIn: anEnvironment
]

{ #category : #'as yet unclassified' }
CpPresenter >> eventHandler [

	^ CpBrowserEventHandler current
]

{ #category : #accessing }
CpPresenter >> id [

	^ id
]

{ #category : #accessing }
CpPresenter >> id: aString [

	id := aString
]

{ #category : #model }
CpPresenter >> model [

	^ model
]

{ #category : #model }
CpPresenter >> model: anObject [

	model := anObject
]

{ #category : #model }
CpPresenter >> modelChanged: aspectSymbol [

	"My model has changed as specified by aspectSymbol, update the view accordingly.
	Updating the view is a subclass responsibility.
	
	Implementation: do not forget to call the superclasses' implementation (most likely before any specific behaviour)"
]

{ #category : #dependencies }
CpPresenter >> release [

	"Release receiver.
	If a view is present, release it. Do not release model because it can be shared amongst presenters."

	model := nil.
	view ifNotNil: [
		view release.
		view := nil ].
	id := nil.

	super release
]

{ #category : #view }
CpPresenter >> renderView [

	"Render the view of the receiver.
	Subclasses should add relevant behavior."
]

{ #category : #model }
CpPresenter >> sendMessageToModel: aSymbol withArguments: anArray [

	self model perform: aSymbol withArguments: anArray
]

{ #category : #view }
CpPresenter >> view [

	^ view
]

{ #category : #view }
CpPresenter >> viewClass [

	"Answer the Class of the View which represents my model best"

	^ self class defaultViewClass
]

{ #category : #view }
CpPresenter >> viewPerform: aMessage [

	self view perform: (aMessage at: 1) withArguments: (aMessage at: 2)
]
