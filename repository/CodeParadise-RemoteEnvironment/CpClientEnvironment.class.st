"
I am a Client Environment. I am part of a combo ClientEnvironment/ServerEnvironment which together represent a RemoteEnvironment for Smalltalk code execution. I live remote and install and perform code in the form of CompiledMethods which are provided by the ServerEnvironment. I install Classes and create instances of these Classes as requested by the ServerEnvironment. I have an ObjectRegistry to keep track of these instances based on an identifier (String). Through this identifier the ServerEnvironment will ask me to send messages to these instances. I only send Announcements back to the ServerEnvironment. I share an identifier with the ServerEnvironment. I store this identifier persistently to allow myself to be restarted/reloaded (for example in a webbrowser environment).

I am responsible for setting up the connection to the server and keeping this connection 'open'. To put it differently: The ServerEnvironment can't reach me if I do not keep this connection 'open'.

Implementation:
I need a number of methods to be implemented in the remote Smalltalk image (where I life) to allow code installation and execution. Evaluate the following method to find these methods: [[[ #clientEnvironment pragmas ]]].

Examples/usage:
To startup use: [[[ CpClientEnvironment current startCommunication ]]]

To send an Announcement (from a Class/instance installed in my receiver):
	[[[ CpClientEnvironment current serverAnnounce: MyAnnouncementClass new ]]]

Or with arguments (see remark below this example):
	[[[
		CpClientEnvironment current serverAnnounce: (MyOtherAnnouncementClass new
			mainValue: #(1 2 3) ;
			otherValue: 'Hello world' ;
			yourself)
	]]]

It is only possible to keep objects inside the announcement which can be encoded using the CpObjectEncoder. This includes (most) Numbers, Booleans, Characters, Strings (incl. Symbols), Array, Dictionary, Associations and nil.

(At the moment) There can only be a single instance of me.

"
Class {
	#name : #CpClientEnvironment,
	#superclass : #CpEnvironment,
	#instVars : [
		'objectRegistry',
		'installedClasses',
		'unresolvedClassReferences'
	],
	#classVars : [
		'Current',
		'PreInstalledClasses'
	],
	#category : #'CodeParadise-RemoteEnvironment-Core'
}

{ #category : #accessing }
CpClientEnvironment class >> communicatorClass [

	^ CpClientCommunicator
]

{ #category : #accessing }
CpClientEnvironment class >> current [

	"Answer the current instance of the receiver"

	(Smalltalk classNamed: #CpServerEnvironment)
		ifNotNil: [ self error: 'Creating ClientEnvironment instances on the server is temporarily disabled because of deadlock issues' ].

	^ Current ifNil: [ Current := self basicNew initialize ; yourself ]
]

{ #category : #testing }
CpClientEnvironment class >> hasPreInstalledClass: aClass [

	"Answer whether the specified Class is pre-installed in the receiver"

	^ self preInstalledClasses includes: aClass
]

{ #category : #installing }
CpClientEnvironment class >> installReconnectStrategy: aReconnectStrategy [

	self current communicator
		reconnectStrategy: aReconnectStrategy
]

{ #category : #testing }
CpClientEnvironment class >> isPlatformLinux [

	^ self current platform == #linux
]

{ #category : #testing }
CpClientEnvironment class >> isPlatformMacOS [

	^ self current platform == #macos
]

{ #category : #testing }
CpClientEnvironment class >> isPlatformWindows [

	^ self current platform == #windows
]

{ #category : #testing }
CpClientEnvironment class >> isRunning [

	"Answer whether the ClientEnvironment is running/active"

	^ Current notNil
]

{ #category : #'instance creation' }
CpClientEnvironment class >> new [

	"Use self >> #current instead to get the singleton instance"

	self errorNewReplacedBy: #current
]

{ #category : #accessing }
CpClientEnvironment class >> preInstalledClasses [

	"Answer the Classes which are pre-installed in the receiver (image/environment)"

	self flag: #todo.	"Should ClientEnvironment announce these classes with CpClientStarted?"

	^ PreInstalledClasses ifNil: [
		PreInstalledClasses := Set new
			add: AdditionalMethodState ;
			add: Announcement ;
			add: AnnouncementSet ;
			add: AnnouncementSetWithExclusions ;
			add: AnnouncementSubscription ;
			add: Announcer ;
			add: Array ;
			add: ArrayedCollection ;
			add: Association ;
			add: Behavior ;
"			add: Block ;				Only in tiny image (for P8 version)
"			add: BlockClosure ;
			add: Boolean ;
			add: ByteArray ;
			add: ByteString ;
			add: Character ;
			add: Class ;
"			add: ClassBuilder ;	Only in tiny image
"			add: Collection ;
			add: CompiledBlock ;
			add: CompiledCode ;
			add: CompiledMethod ;
			add: Context ;
			add: CpClientCommunicator ;
			add: CpClientDecodeFailed ;
			add: CpClientEnvironment ;
			add: CpClientError ;
			add: CpClientMessageSendFailed ;
			add: CpClientStarted ;
			add: CpClientStopped ;
			add: CpCommunicator ;
			add: CpCommunicatorReconnectStrategy ;
			add: CpEnvironment ;
			add: CpJavaScriptWebSocketChannel ;
			add: CpMessageChannel ;
			add: CpObjectDecoder ;
			add: CpObjectEncoder ;
			add: CpObjectRegistry ;
			add: Dictionary ;
			add: Error ;
			add: Exception ;
			add: ExceptionSet ;
			add: ExceptionSetWithExclusions ;
			add: False ;
			add: Float ;
			add: FullBlockClosure ;
			add: IdentityDictionary ;
			add: IdentitySet ;
			add: IllegalResumeAttempt ;
			add: Integer ;
			add: Interval ;
			add: LargeNegativeInteger ;
			add: LargePositiveInteger ;
			add: LinkedList ;
			add: Magnitude ;
			add: Message ;
			add: MessageNotUnderstood ;
			add: MessageSend ;
			add: Metaclass ;
"			add: MethodContext ;		Only in tiny image (for P8 version)
"			add: MethodDictionary ;
			add: Mutex ;
			add: Number ;
			add: Object ;
			add: OrderedCollection ;
			add: OrderedDictionary ;
			add: Point ;
			add: Pragma ;
			add: Process ;
			add: ProcessList ;
			add: ProcessorScheduler ;
			add: ProtoObject ;
			add: ReadStream ;
			add: Rectangle ;
			add: Semaphore ;
			add: SequenceableCollection ;
			add: Set ;
			add: SmallInteger ;
			add: SmalltalkImage ;
			add: SortedCollection ;
			add: String ;
			add: SubscriptionRegistry ;
			add: Symbol ;
"			add: System ;			Only in tiny image (for P8 version)
"			add: SystemDictionary ;
			add: True ;
			add: UndefinedObject ;
			add: UnhandledError ;
			add: ValueLink ;
			add: WideString ;
			add: WordArray ;
			add: WriteStream ;
		yourself ]
]

{ #category : #dependencies }
CpClientEnvironment class >> release [

	"Release the receiver, resetting all Class variables"

	Current := nil.
	PreInstalledClasses := nil
]

{ #category : #constants }
CpClientEnvironment class >> variableNameApp [ 

	^ #APP
]

{ #category : #versions }
CpClientEnvironment class >> version [

	"Answer the version of the receiver.
	This value must match (exactly) the version provided by the ClientEnvironment running
	in the browser or in Node.js. Make sure the CodeParadise and CP-ClientEnvironment repos
	match up to use the same version.

	Implementation:
	Currently the version is implemented as a monotonic increasing counter."

	^ '7'
]

{ #category : #'user interaction' }
CpClientEnvironment >> alert: aString [

	"Alert user with specified message (please use sparsely).

	Implementation:
	In a web browser this will show an alert dialog.
	In NodeJS this will show a warning message on the console (even if used from #fatal:)."

	<primitive: 'primitiveEnvironmentAlert:' module: 'CpSystemPlugin'>
	^ self
]

{ #category : #accessing }
CpClientEnvironment >> app [

	"Answer a Symbol identifying the application that is running.
	The app environment variable should provide this information."

	^ (self variableAt: self class variableNameApp)
		ifNotNil: [ :appString | appString asSymbol ]
		ifNil: [ self fatal: 'The environment variable ' , self class variableNameApp printString , ' is not properly set' ]
]

{ #category : #'user interaction' }
CpClientEnvironment >> confirm: aString [

	"Confirm specified message with user (please use sparsely).

	Implementation:
	In a web browser this will show a confirmation dialog.
	In NodeJS the primitive will fail and therefor false is always answered."

	<primitive: 'primitiveEnvironmentConfirm:' module: 'CpSystemPlugin'>
	^ false

]

{ #category : #support }
CpClientEnvironment >> createCommunicator [

	"Create a new communicator for the receiver which is connected to the server
	and answer it"

	^ super createCommunicator
		connectToUrl: self serverUrl ;
		yourself
]

{ #category : #performing }
CpClientEnvironment >> createInstanceOf: className withId: identifier [

	"Create an instance of the specified Class and register it in the receiver's
	object registry under the given identifier. Answer the newly created instance.

	Implementation:
	Create instance without initialization, register it and then perform initialization.
	The initialization code of the instance can then make use of the instance's id,
	which it can retrieve by querying the receiver's object registry."

	| class instance |

	class := (Smalltalk classNamed: className) ifNil: [ self error: 'Unknown class ', className printString ].
	instance :=  class basicNew.
	self objectRegistry registerObject: instance withId: identifier.
	instance initialize.

	^ instance

]

{ #category : #support }
CpClientEnvironment >> exit [

	"Stop execution.
	I will reset my id, so I will not be 'reloadable'."

	self
		stopCommunication ;
		removeSession ;
		release
]

{ #category : #'error signalling' }
CpClientEnvironment >> fatal: aString [

	"Signal a fatal situation has occurred.
	Inform the user of this fatality, since this situation can't be handled by the receiver anymore."

	self alert: 'FATAL: ', aString
]

{ #category : #performing }
CpClientEnvironment >> globalApply: aSymbol withArguments: anArray [

	"Perform the specified symbol on the global scope (ie 'window' in the browser
	environment, 'global' in NodeJS) with the specified arguments (nil means no arguments).

	This method allows access to JavaScript objects which are reachable through the
	global object (scope). To allow more thorough access to these objects, make sure to
	install the CpJavaScriptProxy support and CpCallbackEvaluator in the client environment."

	<primitive: 'primitiveEnvironmentGlobalApply:withArguments:' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #'input/output' }
CpClientEnvironment >> handleMessageReceived: aByteArray [

	"Handle (encoded) message received through the receiver's communicator.
	Implementation: A message consists of an Array of selector/arguments pairs
	to perform on the receiver."

	| decoder |

	decoder := CpObjectDecoder on: aByteArray.

	[ decoder hasMoreData ] whileTrue: [

		| messageSend |
		messageSend := [ decoder decodeNext ] on: Error do: [ :error |

			"Announce the error (for debugger or otherwise)"
			CpExceptionAnnouncer announceException: error.

			"Since no Exception handler might be installed, log the error too" 
			self errorCr: error printString.
			self errorCr: error signalerContext printString.

			"Finish class installation (as far as we got)"
			self postInstallClasses.

			"Announce error and stop handling the message"
			self serverAnnounce: (CpClientDecodeFailed description: error description).
			^ self ].

		self handleMessageSend: messageSend ]
]

{ #category : #accessing }
CpClientEnvironment >> handleMessageSend: aMessageSend [

	"Perform the MessageSend assuming the MessageSend's receiver is encoded as
	either nil, indicating the ClientEnvironment as receiver
	or an identifier, indicating an Object registered"

	| receiverId |

	(receiverId := aMessageSend receiver)
		ifNotNil: [
			(self objectRegistry objectWithId: receiverId)
				ifNotNil: [ :object | aMessageSend receiver: object ]
				ifNil: [
					"Send Announcement of error to server"
					self serverAnnounce: (CpClientMessageSendFailed
						messageSend: aMessageSend
						description: 'Object with the specified id does not exist in the client').
					^ self ] ]
		ifNil: [ aMessageSend receiver: self ].

	"Perform the message send"
	[ aMessageSend value ] on: Error do: [ :error |

		"Announce the error (for debugger or otherwise)"
		CpExceptionAnnouncer announceException: error.

		self errorCr: 'Error when sending message ', aMessageSend selector, ' to ', aMessageSend receiver printString.
		self errorCr: error printString.
		self errorCr: error signalerContext printString.

		"Restore receiver id and send Announcement of error to server"
		aMessageSend receiver: receiverId.
		self serverAnnounce: (CpClientMessageSendFailed
			messageSend: aMessageSend
			description: error description) ]
]

{ #category : #accessing }
CpClientEnvironment >> id: identifier [

	"Set the identifier of the receiver. Register this identifier (persistently) for later usage
	when the receiver needs reloading/restarting."

	super id: identifier.

	self variableAt: #CLIENT_ID put: identifier
]

{ #category : #initialization }
CpClientEnvironment >> initialize [

	"Initialize the receiver with the previously registered/persisted identifier (if any)"

	super initialize.

	id := self variableAt: #CLIENT_ID.

	objectRegistry := CpObjectRegistry new.
	installedClasses := OrderedCollection new.
	unresolvedClassReferences := Dictionary new
]

{ #category : #installing }
CpClientEnvironment >> installClass: aClass [

	"Install (decoded) Class.

	Implementation:
	During decoding the class is already installed, just keep track of the
	installed Class here to allow the #postInstall operation to be performed
	when all related Classes are installed too."

	installedClasses add: aClass
]

{ #category : #installing }
CpClientEnvironment >> installMethod: aCompiledMethod [

	"Install (decoded) CompiledMethod"

	aCompiledMethod install

]

{ #category : #performing }
CpClientEnvironment >> invalidSession [

	"An invalid session is encountered, ask user whether to start new session"

	(self confirm: 'The session is invalid. Start new session?')
		ifFalse: [ ^ self ].

	"Stop communicator to prevent trying to reconnect"
	super stopCommunication.

	"End current session and (fully) reload"
	self
		removeSession ;
		reload
]

{ #category : #accessing }
CpClientEnvironment >> objectRegistry [

	"Answer the receiver's object registry. The registry is needed for the server
	to be able to address individual objects in the receiver."

	^ objectRegistry
]

{ #category : #accessing }
CpClientEnvironment >> persistentVariableAt: nameString [

	"Answer the value (a String) of the persisted environment variable with the specified name
	or nil if a variable with the specified name does not exist.
	Persisted variables will, in contrast with regular variables, survive beyond the session lifetime.
	Case sensitivity is not defined, for compatibilty best use all uppercase names."

	<primitive: 'primitiveEnvironmentPersistentVariableAt:' module: 'CpSystemPlugin'>
	^ nil
]

{ #category : #accessing }
CpClientEnvironment >> persistentVariableAt: nameString put: valueString [

	"Set the persisted environment variable with the specified name to the specified value.
	Persisted variables will, in contrast with regular variables, survive beyond the session lifetime.
	Case sensitivity is not defined, for compatibilty best use all uppercase names."

	<primitive: 'primitiveEnvironmentPersistentVariableAt:put:' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #accessing }
CpClientEnvironment >> platform [

	^ (self variableAt: #OS)
		ifNotNil: [ :platform | platform asSymbol ]
]

{ #category : #installing }
CpClientEnvironment >> postInstallClasses [

	"Perform the post install method for all installed classes"

	installedClasses ifEmpty: [ ^ self ].

	installedClasses do: [ :each |
		[ each postInstall ] on: Error do: [ :error |

			"Announce the error (for debugger or otherwise)"
			CpExceptionAnnouncer announceException: error.

			"Since no Exception handler might be installed, log the error too" 
			self errorCr: error printString.
			self errorCr: error signalerContext printString.

			"Announce error but continu post installation process"
			self serverAnnounce: (CpClientDecodeFailed description: error description) ] ].

	installedClasses removeAll
]

{ #category : #support }
CpClientEnvironment >> registerUnresolvedClassReference: anAssociation [

	"Keep track of class references for which no Class exists yet.
	These Classes will be resolved later.

	Implementation:
	The class references are kept in a Dictionary with the class name
	as key. This way resolving the actual class can be done fast for
	all kept instances.
	An OrderedCollection is used for storing the class reference
	instances (Associations), because it allows quick addition."

	(unresolvedClassReferences at: anAssociation key ifAbsentPut: [ OrderedCollection new ])
		add: anAssociation
]

{ #category : #initialization }
CpClientEnvironment >> release [

	"Release instance variables"

	objectRegistry := nil.

	super release
]

{ #category : #performing }
CpClientEnvironment >> reload [

	"Reload the receiver (changes might get lost, use sparsely)"

	<primitive: 'primitiveEnvironmentReload' module: 'CpSystemPlugin'>
	^ self

]

{ #category : #installing }
CpClientEnvironment >> removeMethod: aCompiledMethod [

	"Remove (decoded) CompiledMethod"

	aCompiledMethod remove
]

{ #category : #accessing }
CpClientEnvironment >> removePersistentVariableAt: nameString [

	"Remove the persisted environment variable with the specified name.
	Persisted variables will, in contrast with regular variables, survive beyond the session lifetime.
	Case sensitivity is not defined, for compatibilty best use all uppercase names."

	<primitive: 'primitiveEnvironmentRemovePersistentVariableAt:' module: 'CpSystemPlugin'>
	^ self
]

{ #category : #performing }
CpClientEnvironment >> removeSession [

	self removeVariableAt: #CLIENT_ID.
	id := nil
]

{ #category : #accessing }
CpClientEnvironment >> removeVariableAt: nameString [

	"Remove the environment variable with the specified name.
	Case sensitivity is not defined, for compatibilty best use all uppercase names."

	<primitive: 'primitiveEnvironmentRemoveVariableAt:' module: 'CpSystemPlugin'>
	^ self
]

{ #category : #support }
CpClientEnvironment >> resolveClassReferences: aClass [

	"Resolve the class references for the specified Class"

	unresolvedClassReferences at: aClass name ifPresent: [ :classReferences |

		"Resolve the class references"
		classReferences do: [ :each | each value: aClass ].

		"Remove the whole entry, since from now on it is no longer unknown"
		unresolvedClassReferences removeKey: aClass name ]
]

{ #category : #support }
CpClientEnvironment >> restartCommunication [

	"Restart communication (after connection has been restored).

	Implementation:
	Send reconnected announcement only if we have an actual session to reconnect to."

	id ifNil: [ ^ self ].

	self serverAnnounce: CpClientReconnected
]

{ #category : #'input/output' }
CpClientEnvironment >> serverAnnounce: anAnnouncement [

	"Send the specified Announcement back to the server"

	self sendEncodedMessage: (CpObjectEncoder new
		encode: id ;
		encode: anAnnouncement asAnnouncement ;
		bytes)
]

{ #category : #accessing }
CpClientEnvironment >> serverUrl [

	"Answer the URL (as a String) of the server environment.
	The environment variable #SERVER_URL should provide this information."

	^ (self variableAt: #SERVER_URL)
		ifNil: [ self fatal: 'The environment variable #SERVER_URL is not properly set' ]
]

{ #category : #support }
CpClientEnvironment >> startCommunication [

	"Start communication with server"

	super startCommunication.

	"Send initial event to server to actually start communication"
	self serverAnnounce: (CpClientStarted variables: self variables)
]

{ #category : #support }
CpClientEnvironment >> stopCommunication [

	"Stop communication with server"

	self serverAnnounce: CpClientStopped.

	super stopCommunication
]

{ #category : #accessing }
CpClientEnvironment >> variableAt: nameString [

	"Answer the value (a String) of the environment variable with the specified name
	or nil if a variable with the specified name does not exist.
	Case sensitivity is not defined, for compatibility best use all uppercase names."

	<primitive: 'primitiveEnvironmentVariableAt:' module: 'CpSystemPlugin'>
	^ nil
]

{ #category : #accessing }
CpClientEnvironment >> variableAt: nameString put: valueString [

	"Set the environment variable with the specified name to the specified value.
	Case sensitivity is not defined, for compatibility best use all uppercase names."

	<primitive: 'primitiveEnvironmentVariableAt:put:' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #accessing }
CpClientEnvironment >> variableNames [

	"Answer an array with the names of available environment variables."

	<primitive: 'primitiveEnvironmentVariableNames' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #accessing }
CpClientEnvironment >> variables [

	"Answer a dictionary with the names and values of available environment variables."

	| variables |

	variables := Dictionary new.

	self variableNames do: [ :each | 
		variables at: each put: (self variableAt: each) ].

	^ variables
]
