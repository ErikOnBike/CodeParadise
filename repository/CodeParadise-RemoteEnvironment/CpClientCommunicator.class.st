"
I am a client side Communicator. I am responsible for setting up and keeping 'open' the connection to the server.

I use a reconnection strategy to decide if the connection needs to be restored after a loss of connection. If no connection strategy is provided, a lost connection will not be restored.

"
Class {
	#name : #CpClientCommunicator,
	#superclass : #CpCommunicator,
	#instVars : [
		'url',
		'reconnectStrategy'
	],
	#category : #'CodeParadise-RemoteEnvironment-Core'
}

{ #category : #'instance creation' }
CpClientCommunicator class >> newForOwner: ownerObject [

	(Smalltalk classNamed: #CpServerCommunicator)
		ifNotNil: [ self error: 'Creating ClientCommunicator instances on the server is temporarily disabled because of deadlock issues' ].

	^ super newForOwner: ownerObject
]

{ #category : #support }
CpClientCommunicator >> checkConnection [

	"Check connection and restore connection if needed, according to receiver's reconnect strategy"

	(self hasOpenMessageChannel or: [ self hasReconnectStrategy not ])
		ifTrue: [ ^ self ].

	"Reconnect according to the receiver's reconnect strategy"
	(self reconnectStrategy shouldReconnect: self)
		ifTrue: [ self reconnect ]
]

{ #category : #'public api' }
CpClientCommunicator >> connectToUrl: urlString [

	"Make a new connection to the specified server. Users of this method should afterwards
	check whether the receiver has an open connection using #hasOpenMessageChannel to check if
	connection was successful."

	self close.

	url := urlString.
	self messageChannel: (CpMessageChannel forOwner: self connectedToUrl: url)
]

{ #category : #testing }
CpClientCommunicator >> hasReconnectStrategy [

	"Answer whether the receiver has a reconnect strategy"

	^ reconnectStrategy notNil
]

{ #category : #initialization }
CpClientCommunicator >> initialize [

	super initialize.

	"By default always use reconnect strategy"
	self reconnectStrategy: CpCommunicatorReconnectStrategy new
]

{ #category : #accessing }
CpClientCommunicator >> messageChannel: aMessageChannel [

	"Set the receiver's MessageChannel. If nil the existing MessageChannel closed."

	super messageChannel: aMessageChannel.

	aMessageChannel ifNil: [ self checkConnection ]
]

{ #category : #'public api' }
CpClientCommunicator >> reconnect [

	"Reconnect the receiver to the previous URL"

	self connectToUrl: self url.

	"Let the server know we reconnected"
	CpClientEnvironment current
		serverAnnounce: CpClientReconnected
]

{ #category : #accessing }
CpClientCommunicator >> reconnectStrategy [

	"Answer the receiver's reconnect strategy"

	^ reconnectStrategy
]

{ #category : #accessing }
CpClientCommunicator >> reconnectStrategy: aReconnectStrategy [

	"Set the receiver's reconnect strategy"

	reconnectStrategy := aReconnectStrategy
]

{ #category : #initialization }
CpClientCommunicator >> release [

	"Release the receiver's instance variables"

	reconnectStrategy := nil.
	url := nil.

	super release
]

{ #category : #'public api' }
CpClientCommunicator >> sendMessage: aByteArray [

	"Send message to the server, reconnecting if required."
	
	"Implementation:
	Order is important. The message is first sent and will, in case of a lost connection,
	result in an unsent message. My reconnect strategy can then make use of this fact
	(presence of unsent messages) to decide if a reconnect is required."

	super sendMessage: aByteArray.

	self checkConnection
]

{ #category : #accessing }
CpClientCommunicator >> url [

	"Answer the URL (a String) the receiver is (or should be) connected to"

	^ url
]
