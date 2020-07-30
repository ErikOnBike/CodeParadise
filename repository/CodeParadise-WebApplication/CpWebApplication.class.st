"
I am a ServerApplication with Web-specific behavior. I work according to a Model-View-Presenter pattern.

"
Class {
	#name : #CpWebApplication,
	#superclass : #CpServerApplication,
	#instVars : [
		'models',
		'presenters'
	],
	#classVars : [
		'IdentifierGenerator'
	],
	#category : #'CodeParadise-WebApplication-Core'
}

{ #category : #accessing }
CpWebApplication class >> clientBehaviorClass [

	^ CpWebClientBehavior
]

{ #category : #'class initialization' }
CpWebApplication class >> initialize [

	IdentifierGenerator := CpWebIdentifierGenerator new
]

{ #category : #accessing }
CpWebApplication class >> webResourceCSS [

	^ #css
]

{ #category : #accessing }
CpWebApplication class >> webResourceHTML [

	^ #html
]

{ #category : #accessing }
CpWebApplication class >> webResourcePragmaName [

	^ #webResource:
]

{ #category : #'adding/removing' }
CpWebApplication >> addModel: aModel [

	^ self models add: aModel
]

{ #category : #'adding/removing' }
CpWebApplication >> addPresenter: aPresenter [

	^ self presenters at: aPresenter id asSymbol put: aPresenter
]

{ #category : #creating }
CpWebApplication >> createPresenter: aPresenterClass forModel: aModel [

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
CpWebApplication >> handleMessageToProxy: aMessageToProxyReceived [

	"Handle the MessageToProxyReceived Announcement by sending the message to the actual Model"

	| messageSend |

	messageSend := aMessageToProxyReceived messageSend.
	(self presenterWithId: messageSend receiver ifAbsent: [ self error: 'Message from unknown presenter' ])
		sendMessageToModel: messageSend selector withArguments: messageSend arguments
]

{ #category : #initialization }
CpWebApplication >> initialize [

	super initialize.

	models := OrderedCollection new.
	presenters := OrderedIdentityDictionary new
]

{ #category : #installing }
CpWebApplication >> installExtensionMethods [

	"Install the extension methods from known Classes"

	(Pragma allNamed: #webApplicationExtension in: String) do: [ :each |
		self environment addMethod: each method ]
]

{ #category : #installing }
CpWebApplication >> installPresenter: aPresenter [

	"Install the specified Presenter in the ClientEnvironment"

	CpWebClientBehavior createPresenter: aPresenter in: self environment
]

{ #category : #installing }
CpWebApplication >> installPresenters [

	"Install the presenters in the ClientEnvironment and render first time"

	self presenters do: [ :each |
		self installPresenter: each.
		each renderView ]
]

{ #category : #actions }
CpWebApplication >> load [

	"Perform the initial loading of the receiver"

	super load.

	"Ensure the receiver reacts to Announcements from the ClientEnvironment"
	self environment when: CpMessageToProxyReceived send: #handleMessageToProxy: to: self.

	"Install required extensions"
	self installExtensionMethods.

	"Install an instance the ClientBehavior in the ClientEnvironment"
	self class clientBehaviorClass
		installIn: self environment ;
		createIn: self environment.

	"Install any default presenters"
	self installPresenters
]

{ #category : #updating }
CpWebApplication >> methodChanged: anAnnouncement [

	"Update the View if a resource method is uodated.
	Answer a Boolean indicating whether the method is installed in the client.
	Implementation: Answer true is the super call answered true, since the method got installed."

	| method pragma resourceType methodClass |

	(super methodChanged: anAnnouncement)
		ifFalse: [ ^ false ].

	method := anAnnouncement method.
	methodClass := method methodClass instanceSide.
	pragma := method pragmaAt: self class webResourcePragmaName.
	pragma ifNil: [ ^ true ].
	resourceType := pragma argumentAt: 1.
	resourceType == self class webResourceCSS
		ifTrue: [
			self updateStyleViewClass: methodClass.
			^ true ].
	resourceType == self class webResourceHTML
		ifTrue: [
			self updateTemplateViewClass: methodClass.
			^ true ].

	^ true
]

{ #category : #accessing }
CpWebApplication >> models [

	^ models
]

{ #category : #accessing }
CpWebApplication >> presenterWithId: identifier ifAbsent: aBlock [

	^ self presenters at: identifier ifAbsent: aBlock
]

{ #category : #accessing }
CpWebApplication >> presenters [

	^ presenters
]

{ #category : #initialization }
CpWebApplication >> release [

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
CpWebApplication >> reload [

	"Perform reloading of the receiver"

	super reload.

	"Create an instance of the ClientBehavior in the ClientEnvironment (class is already installed)"
	self class clientBehaviorClass createIn: self environment.

	"Install the presenters"
	self installPresenters
]

{ #category : #'adding/removing' }
CpWebApplication >> removeModel: aModel [

	^ self models remove: aModel
]

{ #category : #'adding/removing' }
CpWebApplication >> removePresenter: aPresenter [

	^ self presenters removeKey: aPresenter id asSymbol
]

{ #category : #actions }
CpWebApplication >> stop [

	"Stop the receiver by releasing it"

	self release
]

{ #category : #updating }
CpWebApplication >> updateStyleViewClass: aViewClass [

	CpWebClientBehavior updateStyleViewClass: aViewClass in: self environment
]

{ #category : #updating }
CpWebApplication >> updateTemplateViewClass: aViewClass [

	CpWebClientBehavior updateTemplateViewClass: aViewClass in: self environment
]
