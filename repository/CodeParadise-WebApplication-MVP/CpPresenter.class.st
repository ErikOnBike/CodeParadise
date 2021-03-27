"
I am a Presenter in a Model-View-Presenter pattern.
I have a model and a view and optionally a parent Presenter and/or child Presenters.
I live in the ServerEnvironment and know the application I am running in.
I share an id with my view which allows our binding across environments.

For rendering my view, implement the #renderView method. The #renderChildViewForModel:
and #renderAllChildViewsForModels: can be used to create/update child Presenters
and render their respective Views.

Implementation:
The viewProxy instance variable allows regular message sends to my view.
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
		'childPresentersBySlotName',
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

	"Assign the Application the receiver is part of.
	It is the Application's responsibility to assign this value
	when registering the receiver at the application (see
	#createChildPresenter:atSlotNamed:forModel:)."

	application := anApplication
]

{ #category : #accessing }
CpPresenter >> applicationPresenter [

	^ self application applicationPresenter
]

{ #category : #presenters }
CpPresenter >> childPresenters [

	"Answer all child presenters in the default slot"

	^ self childPresentersAtSlotNamed: nil
]

{ #category : #presenters }
CpPresenter >> childPresentersAtSlotNamed: aString [

	"Answer all child presenters in the specified slot"

	^ children at: aString ifAbsent: [ #() ]
]

{ #category : #'presenters - private' }
CpPresenter >> createChildPresenter: aPresenterClass atSlotNamed: aString atIndex: anInteger forModel: aModel [

	"Create a child Presenter of the specified class for the receiver on the specified model.
	This will also create the View belonging to the presenter.
	The child Presenter is stored at the specified index in the collection of child Presenters
	(at the specified slot). If the specified index is 1 above the current maximum index
	of the collection of child Presenters, a new element is added to the collection.
	If the index is even bigger or less then 1, an error is raised.

	Implementation:
	Set the model last, just before creating the View, so any announcements from the model
	can be handled by a fully operational Presenter/View combination."

	| childPresenters childPresenter |

	"Retrieve collection of child Presenters at specified slot"
	childPresenters := children at: aString ifAbsentPut: [ OrderedCollection new ].

	"If the next child Presenter is added, create room for it (special case)"
	anInteger = (childPresenters size + 1)
		ifTrue: [ childPresenters add: nil ].

	"Create new child Presenter and put it in the collection"
	childPresenter := childPresenters at: anInteger put: (aPresenterClass new
		parent: self ;
		slotName: aString ;
		yourself).

	"Register the child Presenter in the Application (session)"
	self application registerPresenter: childPresenter.

	"Set the model and finally create the view"
	childPresenter
		model: aModel ;
		createView.

	^ childPresenter

]

{ #category : #presenters }
CpPresenter >> createChildPresenter: aPresenterClass atSlotNamed: aString forModel: aModel [

	"Create a child Presenter for the receiver on the specified model
	at the specified location using the specified Presenter class.
	This will also create the View belonging to the presenter."

	| childPresenters |

	childPresenters := self childPresentersAtSlotNamed: aString.

	self
		createChildPresenter: aPresenterClass
		atSlotNamed: aString
		atIndex: childPresenters size + 1
		forModel: aModel

]

{ #category : #presenters }
CpPresenter >> createChildPresenter: aPresenterClass forModel: aModel [

	"Create a child Presenter for the receiver on the specified model
	using the specified Presenter class.
	This will also create the View belonging to the presenter."

	^ self
		createChildPresenter: aPresenterClass
		atSlotNamed: nil
		forModel: aModel
]

{ #category : #presenters }
CpPresenter >> createChildPresenterForModel: aModel [

	"Create a child Presenter for the receiver on the specified model.
	This will also create the View belonging to the presenter."

	^ self
		createChildPresenter: (self presenterClassFor: aModel atSlotNamed: nil)
		atSlotNamed: nil
		forModel: aModel
]

{ #category : #presenters }
CpPresenter >> createChildPresenterForModel: aModel atSlotNamed: aString [

	"Create a child Presenter for the receiver on the specified model at the specified slot.
	This will also create the View belonging to the presenter."

	^ self
		createChildPresenter: (self presenterClassFor: aModel atSlotNamed: aString)
		atSlotNamed: aString
		forModel: aModel
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

	"Render view"
	self renderView.

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

	"Destroy the receiver.

	Implementation:
	Remove receiver from its application and its parent first to prevent
	recursive updates."

	application
		ifNotNil: [ application removePresenter: self ].

	self hasParent
		ifTrue: [ self parent removeChildPresenter: self ].

	self
		destroyChildPresenters ;
		destroyView ;
		release
]

{ #category : #'presenters - private' }
CpPresenter >> destroyChildPresenter: aPresenter [

	"Remove the specified child presenter from the receiver"

	(self removeChildPresenter: aPresenter) destroy

]

{ #category : #'presenters - private' }
CpPresenter >> destroyChildPresenters [

	"Remove all child presenters from the receiver"

	children do: [ :childPresenters |
		[ childPresenters notEmpty ] whileTrue: [ self destroyChildPresenter: childPresenters first ] ].

]

{ #category : #view }
CpPresenter >> destroyView [

	"Destroy the receiver's view.
	
	Implementation:
	First destroy the view in the ClientEnvironment and then remove the
	receiver's proxy."

	viewProxy
		ifNil: [ ^ self ].

	viewProxy destroy.	"Will remove the view in the ClientEnvironment"
	self destroyViewProxy
]

{ #category : #'view - private' }
CpPresenter >> destroyViewProxy [

	viewProxy ifNotNil: [
		viewProxy release.
		viewProxy := nil ]
]

{ #category : #presenters }
CpPresenter >> firstChildPresenter [

	"Answer the first child presenter in the default slot
	or nil if such presenter does not exist"

	^ self firstChildPresenterAtSlotNamed: nil
]

{ #category : #presenters }
CpPresenter >> firstChildPresenterAtSlotNamed: aString [

	"Answer the first child presenter in the specified slot
	or nil if such presenter does not exist"

	^ (self childPresentersAtSlotNamed: aString)
		ifNotEmpty: [ :presenters | presenters first ]
		ifEmpty: [ nil ]
]

{ #category : #'view - private' }
CpPresenter >> handleViewAnnouncement: anAnnouncement [

	"Let the server side View (ie ViewProxy) announce the specified Announcement"

	CpCurrentPresenterContext value: self during: [ 
		viewProxy announce: anAnnouncement ].
]

{ #category : #testing }
CpPresenter >> hasId [

	^ id notNil
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

	"Assign the id of the receiver which distinguishes it within its Application.
	It is the Application's responsibility to assign this value
	when registering the receiver at the application (see
	#createChildPresenter:atSlotNamed:forModel:)."

	id := aString
]

{ #category : #accessing }
CpPresenter >> indexInParent [

	"Answer the receiver's index in the parent's collection of child presenters.
	Answer 0 if the receiver has no parent."

	self hasParent
		ifFalse: [ ^ 0 ].

	^ self parent indexOfChildPresenter: self
]

{ #category : #accessing }
CpPresenter >> indexOfChildPresenter: aPresenter [

	"Answer the index of the specified presenter within the receiver's child collections"

	^ (children at: aPresenter slotName ifAbsent: [ self error: 'Presenter is not a child of the receiver' ])
		indexOf: aPresenter
]

{ #category : #initialization }
CpPresenter >> initialize [

	super initialize.

	children := Dictionary new
]

{ #category : #initialization }
CpPresenter >> initializeViewProxy [

	"Create a ViewProxy for the receiver"

	viewProxy
		ifNotNil: [ self error: 'View already created' ].

	viewProxy := (CpViewProxy newFor: self)
		viewClass: self viewClass ;
		yourself
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

	model == anObject ifTrue: [ ^ self ].

	model
		ifNotNil: [ 	model unsubscribe: self ].

	(model := anObject)
		ifNotNil: [ model whenChangedSend: #privateModelChanged to: self ]
]

{ #category : #model }
CpPresenter >> modelChanged [

	"The receiver's model has changed perform any necessary operations.

	Implementation:
	The view is going to be updated after this method has finished execution,
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

{ #category : #presenters }
CpPresenter >> presenterClassForModel: aModel atSlotNamed: aString [

	"Answer the Presenter class for the specified Model in the specified slot
	as a child Presenter of the receiver"

	^ aModel preferredPresenterClass
]

{ #category : #'model - private' }
CpPresenter >> privateModelChanged [

	"The receiver's model has changed, render the view to make change visible"

	self
		modelChanged ;
		updateView
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
	self destroyViewProxy.
	parent := nil.
	children := nil.
	application := nil.
	id := nil.

	super release
]

{ #category : #actions }
CpPresenter >> reload [

	"Perform any required behavior when reloading the receiver"

]

{ #category : #'presenters - private' }
CpPresenter >> removeChildPresenter: aPresenter [

	"Remove the specified child presenter from the receiver"

	(children at: aPresenter slotName ifAbsent: [ self error: 'Trying to remove child element from non-existing slot' ])
		remove: aPresenter ifAbsent: [ self error: 'Trying to remove element which is not a child element' ].

	aPresenter parent: nil.

	^ aPresenter
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

{ #category : #rendering }
CpPresenter >> renderAllChildViewsForModels: aCollection [

	"Render all the child views for the Models in the specified collection.
	The views are rendered in the default slot of the receiver's view.
	If necessary the child Presenters are created or updated before the Views
	are rendered."

	self renderAllChildViewsForModels: aCollection atSlotNamed: nil
]

{ #category : #rendering }
CpPresenter >> renderAllChildViewsForModels: aCollection atSlotNamed: aString [

	"Render all the child views for the Models in the specified collection.
	The views are rendered in the specified slot of the receiver's view.
	If the specified slot name is nil, the default slot is used.
	If necessary the child Presenters are created or updated before the Views
	are rendered.

	Implementation:
	There is currently no optimization for when (only) the order has changed.
	This might lead to unnecessary re-creation and/or re-rendering of views."

	| childPresenters |

	childPresenters := children at: aString ifAbsentPut: [ OrderedCollection new ].

	"Handle child presenters in order (allowing to add missing child presenters)"
	aCollection withIndexDo: [ :aModel :index |

		| preferredPresenterClass |

		preferredPresenterClass := self presenterClassFor: aModel atSlotNamed: aString.
		childPresenters size < index
			ifTrue: [

				"Since child presenters are handled in order, simply add a new child presenter"
				self createChildPresenter: preferredPresenterClass atSlotNamed: aString atIndex: index forModel: aModel ]
			ifFalse: [

				| existingChildPresenter |

				"Distinguish between re-render or re-creation of child presenter and view"
				(existingChildPresenter := childPresenters at: index) class = preferredPresenterClass
					ifTrue: [

						"Update model (if it changed) before re-rendering"
						existingChildPresenter
							model: aModel ;
							renderView ]
					ifFalse: [

						"Create new child presenter (which will thereby render the view)"
						self createChildPresenter: preferredPresenterClass atSlotNamed: aString atIndex: index forModel: aModel.

						"Remove reference to parent from the old presenter first, because its spot is taken by the new child presenter"
						existingChildPresenter parent: nil.
						existingChildPresenter destroy ] ] ].

	"Remove superfluous child presenters and views"
	[ childPresenters size > aCollection size ]
		whileTrue: [ childPresenters last destroy ]
]

{ #category : #rendering }
CpPresenter >> renderChildViewForModel: aModel [

	"Render child view for the specified model.
	The view is rendered in the default slot of the receiver's view.
	If necessary a child Presenter is created or updated before the View
	is rendered."

	self
		renderAllChildViewsForModels: (Array with: aModel)
		atSlotNamed: nil 

]

{ #category : #rendering }
CpPresenter >> renderChildViewForModel: aModel atSlotNamed: aString [

	"Render child view for the specified model.
	The view is rendered in the specified slot of the receiver's view.
	If the specified slot name is nil, the default slot is used.
	If necessary a child Presenter is created or updated before the View
	is rendered."

	self
		renderAllChildViewsForModels: (Array with: aModel)
		atSlotNamed: aString

]

{ #category : #rendering }
CpPresenter >> renderView [

	"Render the view of the receiver.
	Subclasses should add relevant behavior."
]

{ #category : #'view - private' }
CpPresenter >> sendMessageToView: aMessage [

	"Send the specified message to the receiver's view.

	Implementation:
	The MessageSend's receiver is replaced by its id because of message serialization."

	self application sendMessage: (MessageSend
		receiver: self viewId
		selector: #performMessage:
		arguments: { aMessage })
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

	self hasView
		ifFalse: [ ^ self ].

	viewProxy viewClass = self viewClass
		ifTrue: [  self renderView ]
		ifFalse: [ self recreateView ]
]

{ #category : #view }
CpPresenter >> view [

	"Answer the View of the receiver (can be nil if the view is not created yet).

	Implementation:
	Since the View is accessed by a Proxy anwer the proxy."

	^ viewProxy
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
