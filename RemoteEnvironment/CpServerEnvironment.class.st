"
I am a Server Environment. I am part of a combo ClientEnvironment/ServerEnvironment which together represent a RemoteEnvironment for Smalltalk code execution. I send Classes and CompiledMethods (ie no source code) to the ClientEnvironment for installation there. I ask the ClientEnvironment to create instances of the Classes installed and I ask the ClientEnvironment to send messages to Classes or instances. To address instances of Classes I send an identifier (String) with my request to instantiate Classes. I receive the Announcements the ClientEnvironment sends back to me.

I create a new instance whenever a new ClientEnvironment makes a connection. There is currently no limit on the number of instances created (except for resource limitations of the system I am running on). Whenever a new instance is created and initial code is installed I let (my class side) Announcer announce that the instance is loaded. My instances will announce when they are reloaded or stopped.

The ClientEnvironment and I share an identifier (String).

Examples/usage:
Add Class to newly connected ClientEnvironments:
	[[[
		CpServerEnvironment announcer when: CpClientLoaded do: [ :clientLoaded |
			clientLoaded environment addClass: MyClientBehavior ]
	]]]

Instantiate a Class in the ClientEnvironment and let it perform behavior (#myBehavior and #myOtherBehavior: 42):
	[[[
		CpServerEnvironment announcer when: CpClientLoaded do: [ :clientLoaded |
			clientLoaded environment
				addClass: MyClientBehavior ;
				clientCreateInstanceOf: MyBehavior withId: #client ;
				clientPerform: #myBehavior receiver: #client ;
				clientPerform: #myOtherBehavior: withArguments: { 42 } receiver: #client ]
	]]]

See also CpServerApplication and subclasses for examples of installing behavior in a ClientEnvironment.
"
Class {
	#name : #CpServerEnvironment,
	#superclass : #CpEnvironment,
	#instVars : [
		'encoder',
		'encoderMutex',
		'installedClasses',
		'installedMethods',
		'installationMutex',
		'announcer',
		'loaded'
	],
	#classVars : [
		'ClassSideAnnouncer'
	],
	#category : #'RemoteEnvironment-Core'
}

{ #category : #announce }
CpServerEnvironment class >> announce: anAnnouncement [

	"Let the receiver annouce the specified Announcement"

	self announcer announce: anAnnouncement
]

{ #category : #accessing }
CpServerEnvironment class >> announcer [

	"Answer the class side Announcer"

	^ ClassSideAnnouncer ifNil: [ ClassSideAnnouncer := Announcer new ]
]

{ #category : #accessing }
CpServerEnvironment class >> clientClass [

	^ CpClientEnvironment
]

{ #category : #accessing }
CpServerEnvironment class >> communicatorClass [

	^ CpServerCommunicator
]

{ #category : #'message encoding' }
CpServerEnvironment class >> encodedMessageForPerform: aSymbol withArguments: anArray receiver: identifier [

	"Answer an encoded message (a ByteArray) for performing method on the ClientEnvironment"

	^ (self messageForPerform: aSymbol withArguments: anArray receiver: identifier) cpEncoded
]

{ #category : #accessing }
CpServerEnvironment class >> invalidSessionAlertMessage [

	^ self
		encodedMessageForPerform: #alert:
		withArguments: { 'Session is no longer valid' }
		receiver: nil
]

{ #category : #'message encoding' }
CpServerEnvironment class >> messageForPerform: aSymbol withArguments: anArray receiver: identifier [

	"Answer a MessageSend for performing methods on the ClientEnvironment"

	^ MessageSend
		receiver: identifier
		selector: aSymbol
		arguments: anArray

]

{ #category : #'instance creation' }
CpServerEnvironment class >> newWithId: id [

	"Create new instance of the receiver with the specified identifier"

	^ self new
		id: id ;
		yourself
]

{ #category : #'adding/removing' }
CpServerEnvironment >> addClass: aClass [

	"Add the specified Class to the client environment of the receiver and answer it"

	installationMutex critical: [

		"Only add new classes"
		(self clientKnowsClass: aClass)
			ifTrue: [ ^ aClass ].

		"Add super class to receiver first"
		self addClass: aClass superclass.

		"Add required classes"
		aClass cpRequiredClasses do: [ :each | self addClass: each ].

		"Add new class to receiver's collection of installed classes"
		self installedClasses at: aClass name put: aClass.

		"Install in ClientEnvironment"
		self installClass: aClass.
		
		^ aClass ]
]

{ #category : #'adding/removing' }
CpServerEnvironment >> addMethod: aCompiledMethod [

	"Add the specified CompiledMethod to the client environment of the receiver and answer it"

	| methodElement |

	installationMutex critical: [
		(self hasInstalledClass: aCompiledMethod methodClass)
			ifFalse: [
				"Only methods which are not part of installed classes need to be remembered.
				Others will be installed anyway on reload/restart."
				methodElement := Association key: aCompiledMethod methodClass value: aCompiledMethod selector.
				(installedMethods includes: methodElement)
					ifFalse: [ installedMethods add: methodElement ] ].

		self installMethod: aCompiledMethod.
		
		^ aCompiledMethod ].
]

{ #category : #announcing }
CpServerEnvironment >> announce: anAnnouncement [

	"Let the receiver announce the specified Announcement"

	self announcer announce: anAnnouncement
]

{ #category : #accessing }
CpServerEnvironment >> announcer [

	^ announcer
]

{ #category : #accessing }
CpServerEnvironment >> beLoaded [

	loaded := true
]

{ #category : #'remote execution' }
CpServerEnvironment >> clientAssignId [

	"Assign the receiver's id to the client environment"

	self
		clientPerform: #id:
		withArguments: { self id }
		receiver: nil
]

{ #category : #'remote execution' }
CpServerEnvironment >> clientCreateInstanceOf: aClass withId: identifier [

	"Let the ClientEnvironment create an instance of the specified class with the specified identifier (a String)"

	self
		clientPerform: #createInstanceOf:withId:
		withArguments: { aClass name . identifier }
		receiver: nil
]

{ #category : #testing }
CpServerEnvironment >> clientKnowsClass: aClass [

	"Answer whether the specified Class is known by the receiver's client environment.
	This is when the Class is installed by the receiver or is pre-installed in the ClientEnvironment."

	^ (self hasInstalledClass: aClass) or: [ self class clientClass hasPreInstalledClass: aClass ]
]

{ #category : #'remote execution' }
CpServerEnvironment >> clientPerform: aSymbol [

	"Send message to client to perform the specified selector on the client environment"

	self clientPerform: aSymbol withArguments: {} receiver: nil
]

{ #category : #'remote execution' }
CpServerEnvironment >> clientPerform: aSymbol receiver: identifier [

	"Send message to client to perform the specified selector on the object specified by
	the identifier. If the identifier is nil the client environment is assumed
	to be the receiver of the message sent."

	self clientPerform: aSymbol withArguments: {} receiver: identifier
]

{ #category : #'remote execution' }
CpServerEnvironment >> clientPerform: aSymbol withArguments: anArray [

	"Send message to client to perform the specified selector with arguments on the client environment"

	self clientPerform: aSymbol withArguments: anArray receiver: nil
]

{ #category : #'remote execution' }
CpServerEnvironment >> clientPerform: aSymbol withArguments: anArray receiver: identifier [

	"Send message to client to perform the specified selector with arguments on the Object
	specified by the identifier. If the identifier is nil the client environment is assumed
	to be the receiver of the message sent."

	| message |

	"Create message structure"
	message := self class
		messageForPerform: aSymbol
		withArguments: anArray
		receiver: identifier.

	"Either add message to existing encoder or encode message and send it directly"
	encoderMutex critical: [
		encoder
			ifNotNil: [ encoder encode: message ]
			ifNil: [ self sendMessage: message cpEncoded ] ]
]

{ #category : #'event handling' }
CpServerEnvironment >> handleClientAnnouncement: anAnnouncement [

	"Handle the specified Announcement received from the client"

	encoderMutex critical: [

		"Create encoder to aggregate all messages sent to client during the handling
		of the Announcement"
		encoder := CpObjectEncoder new.

		"Handle the received announcement by re-announcing it"
		[ self announce: anAnnouncement.

		"Send the aggregated messages to the client"
		self sendMessage: encoder bytes ] ensure: [ encoder := nil ] ]
]

{ #category : #'event handling' }
CpServerEnvironment >> handleMessageReceived: aByteArray [

	"Handle the message received from the client.
	The message is assumed to be holding encoded Announcement instances.
	Let the receiver handle the Announcements."

	| decoder |

	decoder := CpObjectDecoder on: aByteArray.

	[ decoder hasMoreData ] whileTrue: [
		self handleClientAnnouncement: decoder decodeNext ]
]

{ #category : #testing }
CpServerEnvironment >> hasInstalledClass: aClass [

	"Answer whether the specified Class is installed in the client environment through the receiver"
self installedClasses ifNil: [ ^false ].
	^ self installedClasses includesKey: aClass name
]

{ #category : #initialization }
CpServerEnvironment >> initialize [

	"Initialize the receiver with empty installation Collections and new Mutexes"

	super initialize.

	encoderMutex := Mutex new.
	installedClasses := OrderedDictionary new.
	installedMethods := OrderedCollection new.
	installationMutex := Mutex new.
	loaded := false.
	announcer := Announcer new.

	"Add subscription to reinstall already registered code in the client environment if restarted"
	self
		when: CpClientStarted send: #started: to: self ;
		when: CpClientStopped send: #stop to: self
]

{ #category : #installing }
CpServerEnvironment >> installClass: aClass [

	"Install the specified Class in the client environment.
	To have the Class being reinstalled on reload, use #addClass:"

	self
		clientPerform: #installClass:
		withArguments: { aClass }
]

{ #category : #installing }
CpServerEnvironment >> installMethod: aCompiledMethod [

	"Install the specified CompiledMethod in the client environment.
	To have the CompiledMethod being reinstalled on reload, use #addMethod:"

	self
		clientPerform: #installMethod:
		withArguments: { aCompiledMethod }
]

{ #category : #installing }
CpServerEnvironment >> installRegisteredClasses [

	"Install the already registered Classes in the client environment (normally only done at reload)"

	self installedClasses valuesDo: [ :eachClass | self installClass: eachClass ]

]

{ #category : #installing }
CpServerEnvironment >> installRegisteredMethods [

	"Install the already registered CompiledMethods in the client environment (normally only done at reload)"

	self installedMethods do: [ :eachMethodElement |
		self installMethod: (eachMethodElement key) >> (eachMethodElement value) ]

]

{ #category : #accessing }
CpServerEnvironment >> installedClasses [

	^ installedClasses
]

{ #category : #accessing }
CpServerEnvironment >> installedMethods [

	^ installedMethods
]

{ #category : #accessing }
CpServerEnvironment >> isLoaded [

	^ loaded
]

{ #category : #initialization }
CpServerEnvironment >> release [

	"Release the receiver's instance variables"

	announcer ifNotNil: [
		announcer subscriptions reset.
		announcer := nil ].
	loaded := nil.
	encoder := nil.
	encoderMutex := nil.
	installedClasses := nil.
	installedMethods := nil.
	installationMutex := nil.

	super release
]

{ #category : #support }
CpServerEnvironment >> started: anAnnouncement [

	"The ClientEnvironment belonging to the receiver (re)started.
	Install the Classes and CompiledMethods already registered with the receiver.
	Let interested parties know about the ClientEnvironment (re)loaded."

	| announcementClass loadedAnnouncer |

	"Assign client id on first time"
	self isLoaded
		ifFalse: [ self clientAssignId ].

	self
		installRegisteredClasses ;
		installRegisteredMethods.

	"On first time started announce Loaded, for restarts afterwards announce Reloaded.
	Loading is announced by the class side Announcer since interested parties do not
	know about the receiver's existance yet and can therefore not subscribe to it."
	self isLoaded
		ifFalse: [
			announcementClass := CpClientLoaded.
			loadedAnnouncer := self class announcer ]
		ifTrue: [
			announcementClass := CpClientReloaded.
			loadedAnnouncer := self announcer ].

	self beLoaded.

	loadedAnnouncer announce: (announcementClass app: anAnnouncement app environment: self)
]

{ #category : #support }
CpServerEnvironment >> stop [

	"Stop the receiver. The receiver is unusable after being stopped."

	self
		stopCommunication ;
		release
]

{ #category : #announcing }
CpServerEnvironment >> unsubscribe: anObject [

	"Unsubscribe the specified Object from Announcements of the receiver"

	^ self announcer unsubscribe: anObject
]

{ #category : #updating }
CpServerEnvironment >> updateCommunicatorWith: aMessageChannel [

	"Replace the receiver's Communicator MessageChannel with a new one
	(this can happen in case a connection is reset or a session is resumed)."

	self hasCommunicator
		ifFalse: [ self communicator: self createCommunicator ].

	self communicator messageChannel: aMessageChannel
]

{ #category : #accessing }
CpServerEnvironment >> variableAt: nameString [

	"Answer the value (a String) of the environment variable with the specified name
	or nil if a variable with the specified name does not exist"

	^ Smalltalk os environment at: nameString ifAbsent: [  nil ]
]

{ #category : #announcing }
CpServerEnvironment >> when: anAnnouncementClass do: aValuable [

	"Let the sender subscribe to the specified announcement of the receiver.
	See Announcer>>#when:do:"

	self announcer when: anAnnouncementClass do: aValuable
]

{ #category : #announcing }
CpServerEnvironment >> when: anAnnouncementClass send: aSymbol to: anObject [

	"Let the sender subscribe to the specified announcement of the receiver.
	See Announcer>>#when:send:to:"

	^ self announcer when: anAnnouncementClass send: aSymbol to: anObject
]
