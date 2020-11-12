"
I am a WebApplication. I work with elements according to the Model-View-Presenter pattern.
I only live in a ServerEnvironment.

Implementation:
My instance keeps track of all Presenters. This allows for:
- Direct mapping of incoming ViewAnnouncements to the correct ViewProxy
- Generating unique identifiers for new Presenters/Views (because new identifiers can be checked before being assigned)

"
Class {
	#name : #CpMvpWebApplication,
	#superclass : #CpWebApplication,
	#instVars : [
		'presenters'
	],
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #accessing }
CpMvpWebApplication class >> clientBehaviorClass [

	^ CpMvpWebClientBehavior
]

{ #category : #'adding/removing' }
CpMvpWebApplication >> addModel: aModel [

	^ self models add: aModel
]

{ #category : #'adding/removing' }
CpMvpWebApplication >> addPresenter: aPresenter [

	^ self presenters at: aPresenter id asSymbol put: aPresenter
]

{ #category : #converting }
CpMvpWebApplication >> asCurrentDo: aBlock [

	"Evaluate the specified Block in the context of the current Application (session)"

	CpCurrentApplication value: self during: aBlock
]

{ #category : #view }
CpMvpWebApplication >> clientCreateViewForPresenter: aPresenter [

	"Create a new View in the ClientEnvironment for the specified Presenter"

	"First install View class"
	self environment addClass: aPresenter viewClass.

	"Then instantiate the View.
	Implementation: The MessageSend's receiver is replaced by its id
	because of message serialization."
	self sendMessage: (MessageSend
		receiver: self clientBehaviorClass clientId
		selector: #createView:withId:atParentId:atSlotNamed:
		arguments: {
			aPresenter viewClass name .
			aPresenter viewId .
			aPresenter viewLocation .
			aPresenter slotName })

]

{ #category : #creating }
CpMvpWebApplication >> clientCreateViews [

	"Create all the client Views for the Presenters of the receiver"

	self presenters do: [ :each | self clientCreateViewForPresenter: each ]
]

{ #category : #actions }
CpMvpWebApplication >> clientRenderViews [

	"Render all the client Views for the Presenters of the receiver"

	self presenters do: [ :each | each renderView ]
]

{ #category : #creating }
CpMvpWebApplication >> createPresenter: aPresenterClass forModel: aModel [

	"Create a new Presenter for the specified Model (both in the ServerEnvironment and the ClientEnvironment).
	Implementation: it is assumed no two processes will update the same WebApplication simultaneously"

	^ self createPresenter: aPresenterClass withParent: nil atSlotNamed: nil forModel: aModel
]

{ #category : #creating }
CpMvpWebApplication >> createPresenter: aPresenterClass withParent: parentPresenter atSlotNamed: slotName forModel: aModel [

	"Create a new Presenter for the specified Model in the specified parent
	Presenter (or nil if the presenter should not have a parent).
	Create the View for the Presenter as well. 

	Implementation:
	It is assumed no two processes will update the same WebApplication simultaneously"

	| presenter |

	"Create Presenter in the ServerEnvironment"
	presenter := self addPresenter: (aPresenterClass new
		id: self generatePresenterIdentifier ;
		application: self ;
		model: aModel ;
		parent: parentPresenter ;
		slotName: slotName ;
		yourself).

	"Create and render the Presenter's View in the ClientEnvironment"
	presenter createView.

	^ presenter
]

{ #category : #creating }
CpMvpWebApplication >> generatePresenterIdentifier [

	"Generate an unique identifier for a presenter of the receiver"

	^ (IdentifierGenerator generateSatisfying: [ :id | (self presenters includesKey: id) not ]) asSymbol
]

{ #category : #'announcement handling' }
CpMvpWebApplication >> handleViewAnnouncement: aViewAnnouncement [

	"Let the server side view (ie ViewProxy) announce the announcement
	from the client side View.

	Implementation:
	A View and Presenter share the same id. Find the matching Presenter and
	let its view do the announcement."

	| presenter |

	presenter := self
		presenterWithId: aViewAnnouncement viewId
		ifAbsent: [ self error: 'View Announcement received from the client for a View which does not exist anymore on the server' ].

	"Let the Presenter's View do the Announcement"
	self asCurrentDo: [ presenter viewAnnounce: aViewAnnouncement announcement ]
]

{ #category : #initialization }
CpMvpWebApplication >> initialize [

	super initialize.

	models := OrderedCollection new.
	presenters := OrderedIdentityDictionary new
]

{ #category : #accessing }
CpMvpWebApplication >> models [

	^ models
]

{ #category : #accessing }
CpMvpWebApplication >> presenterWithId: identifier ifAbsent: aBlock [

	^ self presenters at: identifier ifAbsent: aBlock
]

{ #category : #accessing }
CpMvpWebApplication >> presenters [

	^ presenters
]

{ #category : #initialization }
CpMvpWebApplication >> release [

	"Release the receivers resources.
	Release any presenters of the receiver, but not the models (these might be shared)."

	presenters ifNotNil: [
		presenters do: [ :each | each release ].
		presenters := nil ].
	models ifNotNil: [
		models do: [ :each | each announcer unsubscribe: self ].
		models := nil ].

	super release
]

{ #category : #actions }
CpMvpWebApplication >> reload [

	"Perform reloading of the receiver"

	super reload.

	"Let the presenters perfor any reload behavior"
	self presenters do: [ :each | each reload ].

	"Create and render the Views in the ClientEnvironment"
	self
		clientCreateViews ;
		clientRenderViews
]

{ #category : #'adding/removing' }
CpMvpWebApplication >> removeModel: aModel [

	^ self models remove: aModel
]

{ #category : #'adding/removing' }
CpMvpWebApplication >> removePresenter: aPresenter [

	^ self presenters removeKey: aPresenter id asSymbol
]

{ #category : #initialization }
CpMvpWebApplication >> setUp [

	"Setup the receiver to handle view events from client"

	super setUp.

	self environment
		when: CpViewAnnouncement send: #handleViewAnnouncement: to: self
]
