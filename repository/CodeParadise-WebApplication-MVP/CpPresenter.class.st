"
I am a Presenter in a Model-View-Presenter pattern.
My responsibility is to keep a Model and its View in sync. I do this by listening
to changes on the Model and then (re)rendering the View and by listening to
Announcements of the View and then updating the Model.
I have a model and a view and optionally a parent Presenter and/or child Presenters.
I live in the ServerEnvironment and know the application I am running in.
I share an id with my view which allows our binding across environments.

For rendering my view, implement the #renderView method. The #renderChildViewForModel:
and #renderAllChildViewsForModels: can be used to create/update child Presenters
and render their respective Views. If a specific child Presenter/View is required,
implement #presenterClassForModel:atSlotNamed: and preferrable let it ask the Model
for a type of presenter.

For listening to View Announcements, implement #viewCreated and add subscriptions
to the View.

By default the Presenter will listen to the Model for ValueChanged events.

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
		'application',
		'needsRendering',
		'subscriptions'
	],
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #evaluating }
CpPresenter class >> cull: anObject [

	"Assume I'm used in #usingPresenter: construct and simply answer myself"

	^ self
]

{ #category : #accessing }
CpPresenter class >> defaultViewClass [

	"Answer the default View class for the receiver.
	By default the class with a matching name will be used (if present in the image).
	The matching name is created by replacing the postfix #Presenter with #View.
	Otherwise an error is raised to make clear a view class should be implemented
	or a subclass should override this method to answer a specific view class."

	| className viewClass | 

	className := (self name withoutSuffix: #Presenter) asSymbol , #View.
	viewClass := Smalltalk classNamed: className.

	"If no View class is found, raise an error to indicate the class should be created
	or the subclass should implement #defaultViewClass"
	viewClass
		ifNil: [ self error: ('The View class {1} does not exist. Either create it or implement {2} >> #defaultViewClass to answer a specific class' format: { className . self class name }) ].

	^ viewClass
]

{ #category : #accessing }
CpPresenter >> addSubscriptionTo: anObject forWhen: anAnnouncementClass sending: aSymbol [

	"Add a new Announcement subscription to the specified object for the specified Announcement Class.
	When the Announcement is announced the specified selector is send to the receiver.

	This method allows additional subscriptions to be added which will be removed automatically once
	the receiver is destroyed."

	subscriptions ifNil: [ subscriptions := OrderedCollection new ].

	^ subscriptions add: (anObject when: anAnnouncementClass send: aSymbol to: self)
]

{ #category : #presenters }
CpPresenter >> allPresentersDo: aBlock [

	"Evaluate the specified block for the receiver and then all its descendants
	(in this order)."

	aBlock value: self.

	"Validate the receiver is not destroyed"
	childPresentersBySlotName ifNil: [ ^ self ].

	childPresentersBySlotName valuesDo: [ :presenters |
		presenters do: [ :each | each allPresentersDo: aBlock ] ]
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

	^ childPresentersBySlotName at: aString ifAbsent: [ #() ]
]

{ #category : #presenters }
CpPresenter >> createChildPresenter: aPresenterClass forModel: aModel [

	"Create a child Presenter for the receiver on the specified model
	using the specified Presenter class.
	This will also create the View belonging to the presenter."

	^ self
		createChildPresenter: aPresenterClass
		forModel: aModel
		atSlotNamed: nil
]

{ #category : #presenters }
CpPresenter >> createChildPresenter: aPresenterClass forModel: aModel atSlotNamed: aString [

	"Create a child Presenter for the receiver on the specified model
	at the specified location using the specified Presenter class.
	This will also create the View belonging to the presenter."

	| childPresenters |

	childPresenters := self childPresentersAtSlotNamed: aString.

	^ self
		createChildPresenter: aPresenterClass
		forModel: aModel
		atSlotNamed: aString
		atIndex: childPresenters size + 1

]

{ #category : #'presenters - private' }
CpPresenter >> createChildPresenter: aPresenterClass forModel: aModel atSlotNamed: aString atIndex: anInteger [

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
	childPresenters := childPresentersBySlotName at: aString ifAbsentPut: [ OrderedCollection new ].

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
CpPresenter >> createChildPresenterForModel: aModel [

	"Create a child Presenter for the receiver on the specified model.
	This will also create the View belonging to the presenter."

	^ self
		createChildPresenter: (self presenterClassForModel: aModel atSlotNamed: nil)
		forModel: aModel
		atSlotNamed: nil
]

{ #category : #presenters }
CpPresenter >> createChildPresenterForModel: aModel atSlotNamed: aString [

	"Create a child Presenter for the receiver on the specified model at the specified slot.
	This will also create the View belonging to the presenter."

	^ self
		createChildPresenter: (self presenterClassForModel: aModel atSlotNamed: aString)
		forModel: aModel
		atSlotNamed: aString
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
	self
		viewCreated ;
		viewInitialized.

	"Render view"
	self renderView.
	needsRendering := false
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
	Disconnect from model first to prevent further updates.
	Then remove receiver from its application and its parent
	to prevent recursive updates."

	self model: nil.

	"Remove presenter from the application and also remove its subscriptions"
	application
		ifNotNil: [
			application
				unsubscribe: self ;
				removePresenter: self ].

	self hasParent
		ifTrue: [ self parent removeChildPresenter: self ].

	"Remove view from visible DOM"
	self view remove.
	needsRendering := false.

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

	childPresentersBySlotName ifNil: [ ^ self ].

	childPresentersBySlotName do: [ :childPresenters |
		[ childPresenters isNotEmpty ] whileTrue: [ self destroyChildPresenter: childPresenters first ] ].

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
	self destroyViewProxy.

	self viewDestroyed
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

	viewProxy announce: anAnnouncement

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

	^ (childPresentersBySlotName at: aPresenter slotName ifAbsent: [ self error: 'Presenter is not a child of the receiver' ])
		indexOf: aPresenter
]

{ #category : #initialization }
CpPresenter >> initialize [

	super initialize.

	childPresentersBySlotName := Dictionary new.
	needsRendering := false
]

{ #category : #initialization }
CpPresenter >> initializeViewProxy [

	"Create a ViewProxy for the receiver"

	viewProxy
		ifNotNil: [ self error: 'View already created' ].

	viewProxy := (CpViewProxy newForPresenter: self)
		viewClass: self viewClass ;
		yourself
]

{ #category : #presenters }
CpPresenter >> lastChildPresenter [

	"Answer the last child presenter in the default slot
	or nil if such presenter does not exist"

	^ self lastChildPresenterAtSlotNamed: nil
]

{ #category : #presenters }
CpPresenter >> lastChildPresenterAtSlotNamed: aString [

	"Answer the last child presenter in the specified slot
	or nil if such presenter does not exist"

	^ (self childPresentersAtSlotNamed: aString)
		ifNotEmpty: [ :presenters | presenters last ]
		ifEmpty: [ nil ]
]

{ #category : #'presenters - private' }
CpPresenter >> makeLastChildPresenter: aChildPresenter [

	"Make the specified child presenter the last child presenter (within its slot)"

	| childPresenters |

	childPresenters := self childPresentersAtSlotNamed: aChildPresenter slotName.
	childPresenters
		remove: aChildPresenter ifAbsent: [ self error: 'Failed to move child presenter, because it is not a child presenter of the specified parent' ] ;
		addLast: aChildPresenter
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
		ifNotNil: [ model whenChangedSend: #privateModelChanged: to: self ].

	needsRendering := true
]

{ #category : #model }
CpPresenter >> modelChanged: aValueChanged [

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
	as a child Presenter of the receiver. Subclasses might override this."

	^ aModel preferredPresenterClass
]

{ #category : #'model - private' }
CpPresenter >> privateModelChanged: aValueChanged [

	"The receiver's model has changed, render the view to make change visible"

	needsRendering := true.

	self
		modelChanged: aValueChanged ;
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

	model ifNotNil: [
		model unsubscribe: self.
		model := nil ].
	self destroyViewProxy.
	subscriptions ifNotNil: [ 
		 subscriptions do: [ :each | each unsubscribe ] ].
	parent := nil.
	childPresentersBySlotName := nil.
	application := nil.
	id := nil.

	super release
]

{ #category : #actions }
CpPresenter >> reload [

	"Perform any required behavior when reloading the receiver"

]

{ #category : #presenters }
CpPresenter >> removeAllChildPresenters [

	self removeAllChildPresentersAtSlotNamed: nil
]

{ #category : #presenters }
CpPresenter >> removeAllChildPresentersAtSlotNamed: aSymbol [

	(self childPresentersAtSlotNamed: aSymbol) do: [ :each |
		self removeChildPresenter: each ]
]

{ #category : #'presenters - private' }
CpPresenter >> removeChildPresenter: aPresenter [

	"Remove the specified child presenter from the receiver"

	(childPresentersBySlotName at: aPresenter slotName ifAbsent: [ self error: 'Trying to remove child element from non-existing slot' ])
		remove: aPresenter ifAbsent: [ self error: 'Trying to remove element which is not a child element' ].

	aPresenter parent: nil.

	^ aPresenter
]

{ #category : #accessing }
CpPresenter >> removeSubscription: aSubscription [

	"Remove an existing AnnouncementSubscription from the receiver's collection of subscriptions.

	Implementation:
	First unsubscribe then remove from subscriptions. Additional check is present whether subscriptions
	are actually present. This should not fail, but for safety, the check is added."

	aSubscription unsubscribe.

	subscriptions ifNotNil: [
		subscriptions remove: aSubscription ifAbsent: [ "ignore" ] ].

	^ aSubscription
]

{ #category : #accessing }
CpPresenter >> removeSubscriptionTo: anObject for: anAnnouncementClass [

	"Remove an existing Announcement subscription from the specified object for the specified Announcement Class"

	subscriptions ifNil: [ ^ self ].

	subscriptions
		detect: [ :each | each subscriber == anObject and: [ each annotationUserClass == anAnnouncementClass ] ]
		ifFound: [ :subscription | self removeSubscription: subscription ]
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
	self destroyViewProxy.

	self viewRemoved
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

	self 
		renderAllChildViewsForModels: aCollection 
		usingPresenter: [ :each | self presenterClassForModel: each atSlotNamed: aString ] 
		atSlotNamed: aString
]

{ #category : #rendering }
CpPresenter >> renderAllChildViewsForModels: aCollection usingPresenter: aBlock [ 

	self 
		renderAllChildViewsForModels: aCollection 
		usingPresenter: aBlock 
		atSlotNamed: nil
]

{ #category : #rendering }
CpPresenter >> renderAllChildViewsForModels: aCollection usingPresenter: aBlock atSlotNamed: aString [ 

	"Render all the child views for the Models in the specified collection.
	The views are rendered in the specified slot of the receiver's view.
	If the specified slot name is nil, the default slot is used.
	If necessary the child Presenters are created or updated before the Views
	are rendered.

	Implementation:
	There is currently no optimization for when (only) the order has changed.
	This might lead to unnecessary re-creation and/or re-rendering of views."

	| childPresenters |

	childPresenters := childPresentersBySlotName at: aString ifAbsentPut: [ OrderedCollection new ].

	"Handle child presenters in order (allowing to add missing child presenters)"
	aCollection asArray withIndexDo: [ :aModel :index |

		| childPresenterClass |

		childPresenterClass := aBlock cull: aModel.
		childPresenters size < index
			ifTrue: [

				"Since child presenters are handled in order, simply add a new child presenter"
				self createChildPresenter: childPresenterClass forModel: aModel atSlotNamed: aString atIndex: index ]
			ifFalse: [

				| existingChildPresenter |

				"Distinguish between re-render or re-creation of child presenter and view"
				(existingChildPresenter := childPresenters at: index) class = childPresenterClass
					ifTrue: [

						"Update model (if it changed) before re-rendering"
						existingChildPresenter
							model: aModel ;
							updateView ]
					ifFalse: [

						"Create new child presenter (which will thereby render the view)"
						self createChildPresenter: childPresenterClass forModel: aModel atSlotNamed: aString atIndex: index.

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
CpPresenter >> renderChildViewForModel: aModel usingPresenter: aBlock [ 

	self
		renderAllChildViewsForModels: (Array with: aModel) 
		usingPresenter: aBlock 
		atSlotNamed: nil 
]

{ #category : #rendering }
CpPresenter >> renderChildViewForModel: aModel usingPresenter: aBlock atSlotNamed: aString [

	"Render child view for the specified model.
	The view is rendered in the specified slot of the receiver's view.
	If the specified slot name is nil, the default slot is used.
	If necessary a child Presenter is created or updated before the View
	is rendered."

	self
		renderAllChildViewsForModels: (Array with: aModel) 
		usingPresenter: aBlock 
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
		ifTrue: [
			needsRendering
				ifTrue: [ self renderView ] ]
		ifFalse: [ self recreateView ].

	needsRendering := false
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
	(most notably subscribe to view announcements). This method will
	not be executed on reload. For setup needed on both initial load
	AND reload, please use #viewInitialized"

]

{ #category : #view }
CpPresenter >> viewDestroyed [

	"The receiver's view is destroyed, perform any additional tear down
	(most notably unsubscribe from session announcements)."

]

{ #category : #view }
CpPresenter >> viewId [

	"Answer the id of the receiver's View"

	"Implementation:
	Presenters and Views share the same id, therefor use the Presenter's id as reference to the view"

	^ self id
]

{ #category : #view }
CpPresenter >> viewInitialized [

	"The client side view is initialized, perform any additional setup
	(most notably instruct the client side view to perform operations).
	This method will be executed on initial load AND on reload.
	Don't use this method to subscribe to view announcements, since it
	will add additional subscriptions when reloading a webapplication.
	For setup needed only on initial load use #viewCreated (so also
	for subscribing to view announcements)."

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
CpPresenter >> viewRemoved [

	"The receiver's view is removed, perform any additional tear down
	(most notably unsubscribe from session announcements).
	This method is called when an existing view is replaced by another."

]
