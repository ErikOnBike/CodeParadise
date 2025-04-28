"
I am a MessageChannel. I am responsible for sending and receiving messages. My message are ByteArrays. The Object owning me is responsible for handling the messages I receive. I am responsible for handling a single 'session' between a client and a server (or vice versa). After an instance is closed it is unusable and therefore a new instance should be created for handling another 'session', but that is outside my responsibility.

My owners should respond to the message #handleMessageReceived:on:. The first argument will be the message and the second argument the message channel (ie my instance). If a connection closes I send a final #handleMessageReceived:on: in which both message and message channel are nil. (I will never send nil as message on a non-nil channel.)

I can start a server on which new instances will be created when a connection is made from a client. A (client side) instance can be created which connects to a specified server. A URL is needed to specify the location of a specific server.

Examples:
To start an 'echo' server:
	[[[
		| serverHandler |
		serverHandler := CpMessageHandler new
			onMessage: [ :message |
				Transcript show: 'Server: received message: ', message asString.
				serverHandler messageChannel sendMessage: message ] ;
			onClose: [ Transcript show: 'Server: channel closed' ] ;
			yourself.
		CpMessageChannel startServerFor: serverHandler onPort: 8080 path: '/application' ]]]

To create a channel which connects to the previous server and sends a first message (assuming a WebSocket implementation is used, see my subclasses):
	[[[
		| clientHandler clientChannel |
		clientHandler := CpMessageHandler new
			onMessage: [ :message | Transcript show: 'Client: received message: ', message asString ] ;
			onClose: [ Transcript show: 'Client: channel closed' ] ;
			yourself.
		clientChannel := CpMessageChannel for: clientHandler connectedTo: 'ws://localhost:8080/application'.
		clientChannel sendMessage: 'Hello world' asByteArray ]]]

Implementation:
I fork a Process which receives messages from a lower level message interface and delegates handling the message to the owner Object. This allows for asynchronous messaging when using my instances.
I have a single owner Object responsible for handling the messages I receive, because this is more performant than having an event/notification mechanism.
"
Class {
	#name : #CpMessageChannel,
	#superclass : #Object,
	#instVars : [
		'owner'
	],
	#classVars : [
		'EnvironmentImplementation'
	],
	#category : #'CodeParadise-RemoteEnvironment-Core'
}

{ #category : #initialization }
CpMessageChannel class >> environmentImplementation [

	"Answer the Class which performs the receiver's behavior on the current environment.
	Implementation: A specific implementation can be set, otherwise a sole subclass will indicate
	that implementation should be used. In all other situations answer nil, meaning 'undecided'."

	^ EnvironmentImplementation
		ifNil: [
			self = CpMessageChannel
				ifTrue: [
					| implementationClasses |

					"If a single subclass exists use that, otherwise answer nil to denote 'undecided'"
					implementationClasses := self allSubclasses.
					implementationClasses size = 1
						ifTrue: [ implementationClasses asArray first ] ]
				ifFalse: [ self ] ]
]

{ #category : #initialization }
CpMessageChannel class >> environmentImplementation: aClass [

	"Set the Class which performs the receiver's behavior on the current environment"

	EnvironmentImplementation := aClass
]

{ #category : #'public api' }
CpMessageChannel class >> forOwner: ownerObject connectedToUrl: urlString [

	"Create for the specified owner, a new instance of the receiver which is connected
	to the specified URL.
	The instance can be used directly to send (or receive) messages.
	Answer nil if a connection failed."

	"Use the environment's specific implementation or raise an error"
	self environmentImplementation
		ifNotNil: [ :implementationClass | ^ implementationClass forOwner: ownerObject connectedToUrl: urlString ]
		ifNil: [ Error signal: 'No implementation class set for MessageChannel' ]
]

{ #category : #'public api' }
CpMessageChannel class >> startServerForOwner: ownerObject onPort: anInteger path: aString [

	"Create a server listening on the specified port and path for the specified owner.
	The owner Object will need to handle the relevant events. See #owner:."

	"Use the environment's specific implementation or raise an error"
	self environmentImplementation
		ifNotNil: [ :implementationClass |
			^ implementationClass startServerForOwner: ownerObject onPort: anInteger path: aString ]
		ifNil: [ Error signal: 'No implementation class set for MessageChannel' ]
]

{ #category : #'public api' }
CpMessageChannel >> close [

	"Close the receiver, thereby making the receiver unusable"

	self subclassResponsibility
]

{ #category : #'message handling' }
CpMessageChannel >> createMessageHandler [

	"Create a forked process which will run the receiver's message handler for messages received"

	[ self runMessageHandler ] forkAt: Processor highIOPriority named: 'MessageHandler'
]

{ #category : #'message handling' }
CpMessageChannel >> handleMessageHandlerError: anError [ 

	"Placeholder method to allow specific error handling by subclass or extension method."

	self errorCr: 'Failed to handle messages: ' , anError printString
]

{ #category : #'message handling' }
CpMessageChannel >> handleMessageReceived: aByteArray [

	"Let the owner handle the message received.
	If the receiver is closed (aByteArray will be nil) then also make the channel argument nil.
	Implementation: Make sure our owner is still valid, since it can be nil if the receiver is released."

	self owner ifNotNil: [ :anObject |
		anObject
			handleMessageReceived: aByteArray
			on: (aByteArray ifNotNil: [ self ]) ]
]

{ #category : #'message handling' }
CpMessageChannel >> handleMessages [

	"Handle received messages as long as they are available"

	[ self handleNextMessage ] whileTrue
]

{ #category : #'message handling' }
CpMessageChannel >> handleNextMessage [

	"Let the receiver's owner handle the next message received (if available) and
	answer a Boolean indicating if such message was available"

	| messageByteArray |

	messageByteArray := self receivedMessage ifNil: [ ^ false ].

	self handleMessageReceived: messageByteArray.

	^ true

]

{ #category : #accessing }
CpMessageChannel >> initializeWithOwner: ownerObject [

	"Initialize the receiver with the specified owner.
	The owner should accept the message #handleMessageReceived:on: which receives a
	message as the first argument and the receiver as the second argument.
	When the receiver is closed, the above message is sent to the owner with nil as
	argument for both message and message channel to indicate the connection has closed."

	self initialize.

	owner := ownerObject
]

{ #category : #'public api' }
CpMessageChannel >> isOpen [

	"Answer whether the receiver is open (ie can send and receive messages)"

	self subclassResponsibility
]

{ #category : #accessing }
CpMessageChannel >> owner [

	"Answer the receiver's owner"

	^ owner
]

{ #category : #'message handling' }
CpMessageChannel >> receivedMessage [

	"Answer the next message received or nil if none is available"

	self subclassResponsibility
]

{ #category : #initialization }
CpMessageChannel >> release [

	"Release the receiver's instance variables"

	owner := nil.

	super release
]

{ #category : #'message handling' }
CpMessageChannel >> runMessageHandler [

	"Run the receiver's message handling process for handling received messages.
	Implementation: After the connection has closed, clean up."

	[ self isOpen ] whileTrue: [
		[ 
			"Handle available messages and update internal state"
			self
				handleMessages ;
				updateState
		 ] on: Error do: [ :error | 
			self handleMessageHandlerError: error ] ].

	"Signal connection is closed by sending a nil message"
	self handleMessageReceived: nil.

	self release
]

{ #category : #'public api' }
CpMessageChannel >> sendMessage: aByteArray [

	"Send the specified message.
	An Exception should be thrown if sending failed."

	self subclassResponsibility
]

{ #category : #updating }
CpMessageChannel >> updateState [

	"Update the receiver's state.
	Implementation: Empty method, subclasses may add behavior"
]
