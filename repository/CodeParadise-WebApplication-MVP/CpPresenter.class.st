"
I am a Presenter in a Model-View-Presenter pattern.
I have a model and a view and optionally a parent Presenter.
I live in the ServerEnvironment and know the application I am running in.
I share an id with my view which allows our binding across environments.

"
Class {
	#name : #CpPresenter,
	#superclass : #Object,
	#instVars : [
		'id',
		'model',
		'view',
		'parent',
		'application'
	],
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #accessing }
CpPresenter class >> defaultViewClass [

	^ CpView
]

{ #category : #accessing }
CpPresenter >> application [

	"Answer the application the receiver is part of"

	^ application
]

{ #category : #accessing }
CpPresenter >> application: anApplication [

	application := anApplication
]

{ #category : #'adding/removing' }
CpPresenter >> createChildPresenter: aPresenterClass forModel: aModel [

	"Create a child Presenter for the receiver on the specified model"

	^ self application createPresenter: aPresenterClass withParent: self forModel: aModel
]

{ #category : #view }
CpPresenter >> createView [

	"Create the receiver's view.

	Implementation:
	The receiver (running in the ServerEnvironment) has only a ViewProxy.
	The View in the ClientEnvironment is linked to the receiver by an identifier."

	view ifNotNil: [ self error: 'View already created' ].

	"Create ViewProxy for in the ServerEnvironment"
	view := self createViewProxy.

	"Create View in the ClientEnvironment"
	self application clientCreateViewForPresenter: self.

	"Allow subclasses to perform further initialization"
	self viewCreated
]

{ #category : #'view - private' }
CpPresenter >> createViewProxy [

	"Create a ViewProxy for the receiver"

	^ CpViewProxy newIn: self application environment
]

{ #category : #view }
CpPresenter >> defaultViewLocation [

	"Answer the default location of the receiver's view (see also #viewLocation).
	The result should be the id of the parent DOM element for the receiver's view
	(i.e. the location where the receiver's view will be appended to).
	If nil is answered the view will be appended to the document body."

	^ nil
]

{ #category : #model }
CpPresenter >> hasModel [

	"Answer whether the receiver has a non nil model"

	^ model notNil
]

{ #category : #testing }
CpPresenter >> hasParent [

	^ parent notNil
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

	"Answer the model of the receiver (can be nil if the model is not set yet)"

	^ model
]

{ #category : #model }
CpPresenter >> model: anObject [

	"Set the model of the receiver.
	Removing and adding interest in the old and new model."

	"Implementation: An unsubscribe method is missing in Model"
	model
		ifNotNil: [ 	model announcer unsubscribe: self ].

	(model := anObject)
		ifNotNil: [ model whenChangedSend: #modelChanged to: self ]
]

{ #category : #model }
CpPresenter >> modelChanged [

	"The receiver's model has changed, render the view to make change visible"

	self renderView
]

{ #category : #accessing }
CpPresenter >> parent [

	"Answer the parent Presenter of the receiver (can be nil)"

	^ parent
]

{ #category : #accessing }
CpPresenter >> parent: aPresenter [

	parent := aPresenter
]

{ #category : #initialization }
CpPresenter >> release [

	"Release receiver.
	If a view is present, release it. Do not release model because it can be shared amongst presenters."

	model := nil.
	view ifNotNil: [
		view release.
		view := nil ].
	parent := nil.
	application := nil.
	id := nil.

	super release
]

{ #category : #view }
CpPresenter >> renderView [

	"Render the view of the receiver.
	Subclasses should add relevant behavior."
]

{ #category : #view }
CpPresenter >> view [

	"Answer the View of the receiver (can be nil if the view is not created yet)"

	^ view
]

{ #category : #view }
CpPresenter >> viewClass [

	"Answer the Class of the View which represents my model best"

	^ self class defaultViewClass
]

{ #category : #view }
CpPresenter >> viewCreated [

	"The receiver's view is created, perform any additional setup
	(most notably subscribe to view announcements)"

]

{ #category : #view }
CpPresenter >> viewId [

	"Answer the id of the receiver's View"

	"Implementation:
	Presenters and Views share the same id, therefor use the Presenter's id as reference to the view"

	^ self id
]

{ #category : #view }
CpPresenter >> viewLocation [

	"Answer the id of the DOM element where the receiver's View should be appended.
	If nil is answered the View will be appended to the document body."

	^ self hasParent
		ifTrue: [ self parent viewId ]
		ifFalse: [ self defaultViewLocation ]
]
