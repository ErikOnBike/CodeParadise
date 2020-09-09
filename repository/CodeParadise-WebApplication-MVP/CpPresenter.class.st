"
I am a Presenter in a Model-View-Presenter pattern.
I have a model and a view and optionally a parent Presenter.
I live in the ServerEnvironment and know the application I am running in.
I share an id with my view which allows our binding across environments.

Implementation:
The view instance variable is actually a ViewProxy which allows regular message sends to my view.
The proxy will send the message to the ClientEnvironment environment.
The fact that objects in the ClientEnvironment can't respond to a message send, does
however mean that it is not possible to use the result (answer) of a message send. Or to put it
differently, Views can only be commanded and not interrogated.

"
Class {
	#name : #CpPresenter,
	#superclass : #Object,
	#instVars : [
		'id',
		'model',
		'viewProxy',
		'parent',
		'slotName',
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

{ #category : #presenter }
CpPresenter >> createChildPresenter: aPresenterClass atSlotNamed: aString forModel: aModel [

	"Create a child Presenter for the receiver on the specified model"

	^ self application
		createPresenter: aPresenterClass
		withParent: self
		atSlotNamed: aString
		forModel: aModel
]

{ #category : #presenter }
CpPresenter >> createChildPresenter: aPresenterClass forModel: aModel [

	"Create a child Presenter for the receiver on the specified model"

	^ self createChildPresenter: aPresenterClass atSlotNamed: nil forModel: aModel
]

{ #category : #view }
CpPresenter >> createView [

	"Create the receiver's view (in the ClientEnvironment).

	Implementation:
	The view instance variable is actually a Proxy to the real view in the ClientEnvironment.
	The View in the ClientEnvironment is linked to the receiver by an identifier."

	self initializeViewProxy.

	"Create View in the ClientEnvironment"
	self application clientCreateViewForPresenter: self.

	"Allow subclasses to perform further initialization"
	self viewCreated
]

{ #category : #view }
CpPresenter >> defaultViewLocation [

	"Answer the default location of the receiver's view (see also #viewLocation).
	The result should be the id of the parent DOM element for the receiver's view
	(i.e. the location where the receiver's view will be appended to).
	If nil is answered the view will be appended to the document body."

	^ nil
]

{ #category : #deleting }
CpPresenter >> destroy [

	"Destroy the receiver by removing it from its application and releasing its references"

	application
		ifNotNil: [ application removePresenter: self ].
	self
		removeView ;
		release
]

{ #category : #view }
CpPresenter >> destroyViewProxy [

	viewProxy ifNotNil: [
		viewProxy release.
		viewProxy := nil ]
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

{ #category : #view }
CpPresenter >> hasView [

	^ self view notNil
]

{ #category : #accessing }
CpPresenter >> id [

	^ id
]

{ #category : #accessing }
CpPresenter >> id: aString [

	id := aString
]

{ #category : #initialization }
CpPresenter >> initializeViewProxy [

	"Create a ViewProxy for the receiver"

	viewProxy
		ifNotNil: [ self error: 'View already created' ].

	viewProxy := CpViewProxy new
		viewClass: self viewClass ;
		yourself
]

{ #category : #testing }
CpPresenter >> isPresenter [

	"Answer whether the receiver is a Presenter.

	Implementation: The CpViewProxy uses this to make sure only Presenters use the Proxy."

	^ true
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
		ifNotNil: [ model whenChangedSend: #privateModelChanged to: self ]
]

{ #category : #model }
CpPresenter >> modelChanged [

	"The receiver's model has changed perform any necessary operations.

	Implementation:
	The view will be updated after this method has finished execution,
	so there is no need to render the view explicitly."

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

{ #category : #model }
CpPresenter >> privateModelChanged [

	"The receiver's model has changed, render the view to make change visible"

	self modelChanged.
	self hasView
		ifTrue: [
			self
				updateView ;
				renderView ]
]

{ #category : #view }
CpPresenter >> recreateView [

	"Recreate the receiver's view"

	self
		removeView ;
		createView
]

{ #category : #initialization }
CpPresenter >> release [

	"Release receiver.
	If a view is present, release it. Do not release model because it can be shared amongst presenters."

	model := nil.
	viewProxy ifNotNil: [
		viewProxy release.
		viewProxy := nil ].
	parent := nil.
	application := nil.
	id := nil.

	super release
]

{ #category : #view }
CpPresenter >> removeView [

	"Remove the receiver's view.
	
	Implementation:
	First remove the view in the ClientEnvironment and then remove the
	receiver's proxy."

	viewProxy
		ifNil: [ ^ self ].

	viewProxy remove.	"Will remove the view in the ClientEnvironment"
	self destroyViewProxy
]

{ #category : #view }
CpPresenter >> renderView [

	"Render the view of the receiver.
	Subclasses should add relevant behavior."
]

{ #category : #view }
CpPresenter >> sendMessageToView: aMessage [

	"Send the specified message to the receiver's view"

	self application environment
		clientPerform: #performMessage:
		withArguments: { aMessage }
		receiver: self viewId
]

{ #category : #accessing }
CpPresenter >> slotName [

	"Answer the slot name (a String or nil) of the parent where the receiver's view
	should be installed in"

	^ slotName
]

{ #category : #accessing }
CpPresenter >> slotName: aString [

	slotName := aString
]

{ #category : #view }
CpPresenter >> updateView [

	"Update the receiver's view"

	self viewProxy viewClass = self viewClass
		ifFalse: [ self recreateView ]
]

{ #category : #view }
CpPresenter >> view [

	"Answer the View of the receiver (can be nil if the view is not created yet).

	Implementation:
	Since the View is accessed by a Proxy anwer the proxy."

	^ self viewProxy
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

{ #category : #view }
CpPresenter >> viewProxy [

	^ viewProxy
]
