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
CpMvpWebApplication >> createPresenter: aPresenterClass forModel: aModel [

	"Create a new Presenter for the specified Model (both in the ServerEnvironment and the ClientEnvironment).
	Implementation: it is assumed no two processes will update the same WebApplication simulataneously"

	| presenter |

	"Create Presenter in ServerEnvironment"
	presenter := aPresenterClass new
		id: (IdentifierGenerator generateSatisfying: [ :id | (self presenters includesKey: id) not ]) asSymbol ;
		model: aModel ;
		createViewProxyFor: self environment ;
		yourself.

	aModel whenChangedDo: [ presenter modelChanged: #something ].

	^ self addPresenter: presenter
]

{ #category : #'event handling' }
CpMvpWebApplication >> handleMessageToProxy: aMessageToProxyReceived [

	"Handle the MessageToProxyReceived Announcement by sending the message to the actual Model"

	| messageSend |

	messageSend := aMessageToProxyReceived messageSend.
	(self presenterWithId: messageSend receiver ifAbsent: [ self error: 'Message from unknown presenter' ])
		sendMessageToModel: messageSend selector withArguments: messageSend arguments
]

{ #category : #initialization }
CpMvpWebApplication >> initialize [

	super initialize.

	models := OrderedCollection new.
	presenters := OrderedIdentityDictionary new
]

{ #category : #installing }
CpMvpWebApplication >> installPresenter: aPresenter [

	"Install the specified Presenter in the ClientEnvironment"

	self class clientBehaviorClass createPresenter: aPresenter in: self environment
]

{ #category : #installing }
CpMvpWebApplication >> installPresenters [

	"Install the presenters in the ClientEnvironment and render first time"

	self presenters do: [ :each |
		self installPresenter: each.
		each renderView ]
]

{ #category : #actions }
CpMvpWebApplication >> load [

	"Perform the initial loading of the receiver"

	super load.

	"Ensure the receiver reacts to Announcements from the ClientEnvironment"
	self environment when: CpMessageToProxyReceived send: #handleMessageToProxy: to: self.

	"Install any default presenters"
	self installPresenters
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

	"Install the presenters"
	self installPresenters
]

{ #category : #'adding/removing' }
CpMvpWebApplication >> removeModel: aModel [

	^ self models remove: aModel
]

{ #category : #'adding/removing' }
CpMvpWebApplication >> removePresenter: aPresenter [

	^ self presenters removeKey: aPresenter id asSymbol
]
