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
		'announcer',
		'presenters',
		'applicationPresenter'
	],
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #accessing }
CpMvpWebApplication class >> clientBehaviorClass [

	^ CpMvpWebClientBehavior
]

{ #category : #accessing }
CpMvpWebApplication >> announcer [

	^ announcer
]

{ #category : #presenter }
CpMvpWebApplication >> applicationPresenter [

	"Answer the ApplicationPresenter of the receiver"

	^ applicationPresenter
]

{ #category : #presenter }
CpMvpWebApplication >> applicationPresenterClass [

	"Answer the ApplicationPresenter class of the receiver. Subclasses can override this.

	Implementation:
	By default a PagesApplicationPresenter is answered. It will use PagePresenters to
	present the content of the receiver to the user. The PagePresenters in turn will
	ask the receiver for its #preferredPresenterClass which will represent the content."

	^ CpPagesApplicationPresenter
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
		selector: #createView:withId:atParentId:atSlotNamed:atIndex:
		arguments: {
			aPresenter viewClass name .
			aPresenter viewId .
			aPresenter viewLocation .
			aPresenter slotName .
			aPresenter indexInParent })

]

{ #category : #view }
CpMvpWebApplication >> clientCreateViews [

	"Create all the client Views for the Presenters of the receiver.

	Implementation:
	Do not use 'each createView' since it will try to create the server side ViewProxy as well."


	self presenters do: [ :each | self clientCreateViewForPresenter: each ].

	self flag: #todo. "Creatting/rendering are mixed in #createChildPresenter but not here. Make consistent."
	self presenters do: [ :each | each renderView ]
]

{ #category : #presenter }
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
	presenter handleViewAnnouncement: aViewAnnouncement announcement
]

{ #category : #initialization }
CpMvpWebApplication >> initialize [

	"Initialize the receiver.
	See class comment for explanation about instance variable viewProxies."

	super initialize.

	announcer := Announcer new.
	presenters := OrderedIdentityDictionary new
]

{ #category : #actions }
CpMvpWebApplication >> load [

	"Perform the initial loading of the receiver"

	super load.

	(applicationPresenter := self registerPresenter: self applicationPresenterClass new)
		model: self ;
		createView
]

{ #category : #presenter }
CpMvpWebApplication >> preferredPresenterClass [

	"Answer the preferred Presenter class for the content of the receiver"

	self subclassResponsibility
]

{ #category : #presenter }
CpMvpWebApplication >> presenterWithId: identifier ifAbsent: aBlock [

	^ self presenters at: identifier ifAbsent: aBlock
]

{ #category : #presenter }
CpMvpWebApplication >> presenters [

	^ presenters
]

{ #category : #presenter }
CpMvpWebApplication >> registerPresenter: aPresenter [

	"Register the specified Presenter and answer the Presenter.

	Implementation:
	Set both the application and id of the Presenter (see Class Comment)."

	aPresenter application: self.
	aPresenter hasId
		ifFalse: [ aPresenter id: self generatePresenterIdentifier ].

	^ self presenters at: aPresenter id asSymbol put: aPresenter
]

{ #category : #initialization }
CpMvpWebApplication >> release [

	"Release the receivers resources"

	presenters ifNotNil: [
		presenters do: [ :each | each release ].
		presenters := nil ].

	"The ApplicationPresenter is part of the presenters collection.
	So it is released above and does not need to be released here again."
	applicationPresenter := nil.

	super release
]

{ #category : #actions }
CpMvpWebApplication >> reload [

	"Perform reloading of the receiver"

	super reload.

	"Let the presenters perfor any reload behavior"
	self presenters do: [ :each | each reload ].

	"Create and render the Views in the ClientEnvironment"
	self clientCreateViews
]

{ #category : #presenter }
CpMvpWebApplication >> removePresenter: aPresenter [

	^ self presenters removeKey: aPresenter id asSymbol
]

{ #category : #'input/output' }
CpMvpWebApplication >> sendMessage: aMessageSend [

	self environment sendMessage: aMessageSend
]

{ #category : #initialization }
CpMvpWebApplication >> setUp [

	"Setup the receiver to handle view events from client"

	super setUp.

	self environment
		when: CpViewAnnouncement send: #handleViewAnnouncement: to: self
]

{ #category : #announcing }
CpMvpWebApplication >> unsubscribe: anObject [

	"Unsubscribe the specified Object from Announcements of the receiver"

	^ self announcer unsubscribe: anObject
]

{ #category : #announcing }
CpMvpWebApplication >> when: anAnnouncementClass send: aSymbol to: anObject [

	"Let the sender subscribe to the specified announcement of the receiver.
	See Announcer>>#when:send:to:"

	^ self announcer when: anAnnouncementClass send: aSymbol to: anObject
]

{ #category : #announcing }
CpMvpWebApplication >> whenChangedSend: aSymbol to: anObject [

	"Let the sender subscribe to the value changed announcement of the receiver

	Implementation:
	This method is for compatibility with Model and NewValueHolder"

	^ self when: ValueChanged send: aSymbol to: anObject
]
