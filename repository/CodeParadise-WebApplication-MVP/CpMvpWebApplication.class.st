"
I am a WebApplication. I work with elements according to the Model-View-Presenter pattern.
I only live in a ServerEnvironment.
"
Class {
	#name : #CpMvpWebApplication,
	#superclass : #CpWebApplication,
	#instVars : [
		'models',
		'presenters'
	],
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #'adding/removing' }
CpMvpWebApplication >> addModel: aModel [

	^ self models add: aModel
]

{ #category : #'adding/removing' }
CpMvpWebApplication >> addPresenter: aPresenter [

	^ self presenters at: aPresenter id asSymbol put: aPresenter
]

{ #category : #creating }
CpMvpWebApplication >> clientCreateViewForPresenter: aPresenter [

	"Create a new View in the ClientEnvironment for the specified Presenter"

	self environment
		addClass: aPresenter viewClass ;

		clientPerform: #createView:withId:atParentId: 
		withArguments: {
			aPresenter viewClass name .
			aPresenter viewId .
			aPresenter viewLocation }
		receiver: self clientBehaviorId
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

	^ self createPresenter: aPresenterClass withParent: nil forModel: aModel
]

{ #category : #creating }
CpMvpWebApplication >> createPresenter: aPresenterClass withParent: parentPresenter forModel: aModel [

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
		yourself).

	"Create and render the Presenter's View in the ClientEnvironment"
	presenter
		createView ;
		renderView.

	^ presenter
]

{ #category : #creating }
CpMvpWebApplication >> generatePresenterIdentifier [

	"Generate an unique identifier for a presenter of the receiver"

	^ (IdentifierGenerator generateSatisfying: [ :id | (self presenters includesKey: id) not ]) asSymbol
]

{ #category : #'announcement handling' }
CpMvpWebApplication >> handleViewAnnouncement: aViewAnnouncement [

	"Let the correct Presenter announce the announcement from the View.

	Implementation:
	A View and Presenter share the same id."

	| presenter |

	presenter := self
		presenterWithId: aViewAnnouncement viewId
		ifAbsent: [ self error: 'View Announcement received for Presenter which does not exist anymore' ].

	"Let the Presenter's View do the Announcement"
	presenter view announce: aViewAnnouncement announcement
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
