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
		'objectRegistry'
	],
	#classVars : [
		'Current',
		'PreInstalledClasses'
	],
	#category : #'RemoteEnvironment-Core'
}

{ #category : #accessing }
CpClientEnvironment class >> communicatorClass [

	^ CpClientCommunicator
]

{ #category : #accessing }
CpClientEnvironment class >> current [

	"Answer the current instance of the receiver"

	^ Current ifNil: [ Current := self basicNew initialize ; yourself ]
]

{ #category : #testing }
CpClientEnvironment class >> hasPreInstalledClass: aClass [

	"Answer whether the specified Class is pre-installed in the receiver"

	^ self preInstalledClasses includes: aClass
]

{ #category : #'instance creation' }
CpClientEnvironment class >> new [

	"Use self >> #current instead to get the singleton instance"

	self shouldNotImplement
]

{ #category : #accessing }
CpClientEnvironment class >> preInstalledClasses [

	"Answer the Classes which are pre-installed in the receiver (image/environment)"

	self flag: #todo.	"Should ClientEnvironment announce these classes with CpClientStarted?"

	"Implementation: only answer Classes in the tiny Smalltalk image which would normally be inherited from (for the time being)"
	^ PreInstalledClasses ifNil: [
		PreInstalledClasses := Set new
			add: CpClientEnvironment ;
			add: CpClientCommunicator ;
			add: CpCommunicatorReconnectStrategy ;
			add: CpJavascriptWebSocketChannel ;
			add: Announcement ;
			add: CpClientStarted ;
			add: CpClientStopped ;
			add: ProtoObject ;
			add: Object ;
			add: UndefinedObject ;
			add: Array ;
			add: ByteArray ;
			add: Collection ;
			add: ArrayedCollection ;
			add: SequenceableCollection ;
			add: OrderedCollection ;
			add: Dictionary ;
			add: IdentityDictionary ;
			add: Set ;
			add: IdentitySet ;
			add: Association ;
			add: Interval ;
			add: Exception ;
			add: Error ;
			add: MessageNotUnderstood ;
			add: UnhandledError ;
			add: CpClientError ;
			add: CpClientDecodeFailed ;
			add: CpClientMessageSendFailed ;
		yourself ]
]

{ #category : #dependencies }
CpClientEnvironment class >> release [

	"Release the receiver, resetting all Class variables"

	Current := nil.
	PreInstalledClasses := nil
]

{ #category : #logging }
CpClientEnvironment >> alert: aString [

	"Alert user with specified message (please use sparsely)"

	self primAlert: aString

]

{ #category : #accessing }
CpClientEnvironment >> app [

	"Answer a String identifying the application that is running.
	The environment variable #APP should provide this information."

	^ (self variableAt: #APP)
		ifNil: [ self fatal: 'The environment variable #APP is not properly set' ]
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

	| instance |

	instance := (Smalltalk classNamed: className) basicNew.
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
		variableAt: #CLIENT_ID put: nil.

	self release
]

{ #category : #'error signalling' }
CpClientEnvironment >> fatal: aString [

	"Signal a fatal situation has occurred.
	Inform the user of this fatality, since this situation can't be handled by the receiver anymore."

	self alert: 'FATAL: ', aString
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
	receiverId := aMessageSend receiver.
	aMessageSend
		receiver:
			(receiverId
				ifNotNil: [ self objectRegistry objectWithId: receiverId ]
				ifNil: [ self ]).

	"Perform the message send"
	[ aMessageSend value ]
		on: Error
		do: [ :error | 
			"Restore receiver id and send Announcement of error to server"
			aMessageSend receiver: receiverId.
			self
				serverAnnounce:
					(CpClientMessageSendFailed
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

	objectRegistry := CpObjectRegistry new
]

{ #category : #installing }
CpClientEnvironment >> installClass: aClass [

	"Install (decoded) Class"

	"Only perform post installation initialization here.
	Class is already installed in CpObjectDecoder during decoding
	otherwise no class could be answered as part of the decoding."

	aClass postInstall
]

{ #category : #installing }
CpClientEnvironment >> installMethod: aCompiledMethod [

	"Install (decoded) CompiledMethod"

	aCompiledMethod install

]

{ #category : #logging }
CpClientEnvironment >> log: aString [

	"Log message on Transcript/console"

	self primLog: aString

]

{ #category : #accessing }
CpClientEnvironment >> objectRegistry [

	"Answer the receiver's object registry. The registry is needed for the server
	to be able to address individual objects in the receiver."

	^ objectRegistry
]

{ #category : #primitives }
CpClientEnvironment >> primAlert: aString [

	<primitive: 'primitiveAlert:' module: 'CpSystemPlugin'>
	^ self

]

{ #category : #primitives }
CpClientEnvironment >> primLog: aString [

	<primitive: 'primitiveLog:' module: 'CpSystemPlugin'>
	^ self

]

{ #category : #initialization }
CpClientEnvironment >> release [

	"Release instance variables"

	objectRegistry := nil.

	super release
]

{ #category : #'input/output' }
CpClientEnvironment >> serverAnnounce: anAnnouncement [

	"Send the specified Announcement back to the server by encoding it as a message.
	Implementation: The message sent to the server will also contain the
	receiver's id for identification of the environment at the server side."

	self sendMessage: (CpObjectEncoder new
		encode: id ;
		encode: anAnnouncement ;
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
	self serverAnnounce: (CpClientStarted app: self app)

]

{ #category : #support }
CpClientEnvironment >> stopCommunication [

	"Stop communication with server"

	self serverAnnounce: CpClientStopped new.

	super stopCommunication
]

{ #category : #accessing }
CpClientEnvironment >> variableAt: nameString [

	"Answer the value (a String) of the environment variable with the specified name
	or nil if a variable with the specified name does not exist.
	Case sensitivity is not defined, for compatibilty best use all uppercase names."

	<primitive: 'primitiveEnvironmentVariableAt:' module: 'CpSystemPlugin'>
	^ nil
]

{ #category : #accessing }
CpClientEnvironment >> variableAt: nameString put: valueString [

	"Set the environment variable with the specified name to the specified value.
	Case sensitivity is not defined, for compatibilty best use all uppercase names."

	<primitive: 'primitiveEnvironmentVariableAt:put:' module: 'CpSystemPlugin'>
	self primitiveFailed
]
