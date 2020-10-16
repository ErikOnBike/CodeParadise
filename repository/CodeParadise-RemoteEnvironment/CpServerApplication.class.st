"
I am a ServerApplication running in a RemoteEnvironment. I am responsible for delegating part of my behavior to a ClientEnvironment. I do not know my ClientEnvironment directly, but I know the ServerEnvironment which communicates with this ClientEnvironment. I have a unique application identifier. I get instantiated whenever a ClientEnvironment is loaded referring to my application identifier.

The ClientEnvironment can take on one of many roles by the behavior I install there. It can for example take on the role of a Worker performing tasks for me or can take on the role of a frontend User Interface or a system interface.

Implementation:
The fact that a ClientEnvironment is loaded is announced by the ServerEnvironment to my class side. The fact that the ClientEnvironment is reloaded or stopped is announced to the instance itself.

"
Class {
	#name : #CpServerApplication,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#classInstVars : [
		'announcementSubscription'
	],
	#category : #'CodeParadise-RemoteEnvironment-Core'
}

{ #category : #accessing }
CpServerApplication class >> app [

	"Answer the unique identifier (a Symbol) for the receiver.
	A unique identifier is needed to route new sessions to the correct application."

	self subclassResponsibility
]

{ #category : #support }
CpServerApplication class >> clientLoaded: anAnnouncement [

	"Create a new instance of the receiver if the ClientEnvironment loaded
	matches the receiver's unqiue app identifier"

 	anAnnouncement app = self app
		ifFalse: [ ^ self ].

	"Create new instance and call the load handler (faking the loaded event which triggered this invocation)"
	(self newIn: anAnnouncement environment)
		load
]

{ #category : #'instance creation' }
CpServerApplication class >> newIn: aServerEnvironment [

	"Create new instance of the receiver"

	^ self new
		environment: aServerEnvironment ;
		setUp ;
		yourself
]

{ #category : #support }
CpServerApplication class >> register [

	"Register the receiver by subscribing to the ClientLoaded Announcement of the CpServerEnvironment.
	When a new ClientEnvironment is started matching the receiver's app-identifier a new instance of
	the receiver is created which receives a newly assigned ServerEnvironment (for communicating with
	the ClientEnvironment)."

	self unregister.

	announcementSubscription := CpServerEnvironment announcer
		when: CpClientLoaded
		send: #clientLoaded:
		to: self
]

{ #category : #'class initialization' }
CpServerApplication class >> release [

	"Release any class side resource. Subclasses can override."

	self unregister
]

{ #category : #support }
CpServerApplication class >> unregister [

	"Unregister by unsubscribing from the CpServerEnvironment. See #register"

	announcementSubscription ifNil: [ ^ self ].

	CpServerEnvironment announcer removeSubscription: announcementSubscription.
	announcementSubscription := nil
]

{ #category : #accessing }
CpServerApplication >> environment [

	"Answer the ServerEnvironment of the receiver"

	^ environment
]

{ #category : #accessing }
CpServerApplication >> environment: aServerEnvironment [

	"Set the ServerEnvironment of the receiver to the specified value"

	environment := aServerEnvironment
]

{ #category : #actions }
CpServerApplication >> load [

	"Perform any actions needed when the ClientEnvironment belonging to the receiver loaded (for the first time)"

]

{ #category : #updating }
CpServerApplication >> methodChanged: anAnnouncement [

	"Update any known methods in the ClientEnvironment or add new methods.
	Answer whether the method is added to the ClientEnvironment."

	| method methodClass |

	(self environment ifNil: [ ^ false ]) isRunning
		ifFalse: [ ^ false ].

	"Validate method is or should be available in ClientEnvironment"
	method := anAnnouncement method.
	method ifNil: [ ^ false ].
	methodClass := method methodClass instanceSide.
	(self environment clientKnowsClass: methodClass)
		ifTrue: [

			"Add method in ClientEnviroment (making sure it is installed again on reload)"
			self environment addMethod: method.

			^ true ].

	^ false
]

{ #category : #initialization }
CpServerApplication >> release [

	"Release the receiver's instance variables"

	environment := nil.

	super release
]

{ #category : #actions }
CpServerApplication >> reload [

	"Perform any actions needed when the ClientEnvironment belonging to the receiver reloaded"
]

{ #category : #initialization }
CpServerApplication >> setUp [

	"Setup the receiver to handle reload and stop events from client and handle code updates
	from the server. Subclasses can add behavior which needs to be executed before #load
	but after #initialize.

	Implementation: the client load event can't be caught here, since it already took place.
	It will be handled in CpServerApplication >> #clientLoaded"

	self environment
		when: CpClientReloaded send: #reload to: self ;
		when: CpClientStopped send: #stop to: self.

	"Ensure the receiver reacts to methods being changed on the server"
	self flag: #todo. "Need to be able to remove methods in the ClientEnvironment as well"
	SystemAnnouncer uniqueInstance weak
		when: MethodAdded, MethodModified
		send: #methodChanged: to: self
]

{ #category : #actions }
CpServerApplication >> stop [

	"Perform any actions needed when the ClientEnvironment belonging to the receiver stopped.
	The receiver is unusable after being stopped."

	self environment ifNotNil: [ :remoteEnvironment | remoteEnvironment unsubscribe: self ].
	self release
]
