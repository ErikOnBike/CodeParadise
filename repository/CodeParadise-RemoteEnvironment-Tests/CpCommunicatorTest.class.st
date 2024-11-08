"
Tests for Communicator
"
Class {
	#name : #CpCommunicatorTest,
	#superclass : #TestCase,
	#category : #'CodeParadise-RemoteEnvironment-Tests'
}

{ #category : #tests }
CpCommunicatorTest >> testClientSendBeforeConnection [

	"These tests are disabled because safety checks prevent it (to prevent communicators from crashing the image)"

	| originalClientMessages originalServerMessages client clientOwner clientMessages server serverOwner serverMessages semaphore |

	self skip.

	originalClientMessages := OrderedCollection newFrom: (
		{ 'Hello' . 'World' . 'Welcome' } collect: [ :each | each asByteArray ]).
	originalServerMessages := OrderedCollection newFrom: (
		{ '42' . 'is' . 'the' . 'answer' } collect: [ :each | each asByteArray ]).

	serverMessages := OrderedCollection new.
	serverOwner := CpMessageHandler new
		onMessage: [ :message |
			serverMessages add: message.
			serverMessages size = 3
				ifTrue: [ semaphore signal ] ] ;
		yourself.
	server := CpServerCommunicator newForOwner: serverOwner.

	clientMessages := OrderedCollection new.
	clientOwner := CpMessageHandler new
		onMessage: [ :message |
			clientMessages add: message.
			clientMessages size = 4
				ifTrue: [ semaphore signal ] ] ;
		yourself.
	client := CpClientCommunicator newForOwner: clientOwner.

	"Create a server for incoming connections and have the server side Communicator own it"
	CpMessageChannel startServerForOwner: server onPort: 1701 path: '/test'.

	originalClientMessages do: [ :each | client sendMessage: each ].

	"Make connection"
	client connectToUrl: 'ws://localhost:1701/test'.

	"Send messages"
	semaphore := Semaphore new.
	[ originalServerMessages do: [ :each | server sendMessage: each ] ] fork.
	semaphore wait.
	semaphore wait.

	"Validate messages"
	self
		assertCollection: originalClientMessages equals: serverMessages ;
		assertCollection: originalServerMessages equals: clientMessages
]

{ #category : #tests }
CpCommunicatorTest >> testConnectionStrategies [

	"These tests are disabled because safety checks prevent it (to prevent communicators from crashing the image)"

	| client clientOwner server serverOwner |

	self skip.

	"Server and client do not receive messages, so empty owners"
	serverOwner := CpMessageHandler new.
	server := CpServerCommunicator newForOwner: serverOwner.

	clientOwner := CpMessageHandler new.
	client := CpClientCommunicator newForOwner: clientOwner.

	"Create a server for incoming connections and have the server side Communicator own it"
	CpMessageChannel startServerForOwner: server onPort: 1701 path: '/test'.

	"Make connection"
	client connectToUrl: 'ws://localhost:1701/test'.
	self assert: client hasOpenMessageChannel description: 'Made first connection'.

	"Close connection and perform #checkConnection"
	client
		close ;
		checkConnection.
	self assert: client hasOpenMessageChannel not description: 'Default no reconnect'.

	"Set reconnect strategy to 'always'"
	client reconnectStrategy: CpCommunicatorReconnectStrategy new.

	"Close connection and perform #checkConnection"
	client
		close ;
		checkConnection.
	self assert: client hasOpenMessageChannel description: 'Reconnect with reconnection strategy from client close'
]

{ #category : #tests }
CpCommunicatorTest >> testReconnectStrategy [

	"These tests are disabled because safety checks prevent it (to prevent communicators from crashing the image)"

	| originalClientMessages client clientOwner server serverOwner serverMessages semaphore |

	self skip.

	originalClientMessages := OrderedCollection newFrom: (
		{ 'Hello' . 'World' . 'Welcome' } collect: [ :each | each asByteArray ]).

	semaphore := Semaphore new.
	serverMessages := OrderedCollection new.
	serverOwner := CpMessageHandler new
		onMessage: [ :message |
			serverMessages add: message.
			serverMessages size = 2
				ifTrue: [ server messageChannel close ].
			serverMessages size >= 2
				ifTrue: [ semaphore signal ] ] ;
		yourself.
	server := CpServerCommunicator newForOwner: serverOwner.

	"Client does not receive messages, so empty owner"
	clientOwner := CpMessageHandler new.
	client := (CpClientCommunicator newForOwner: clientOwner)
		reconnectStrategy: CpCommunicatorReconnectStrategy new ;
		yourself.

	"Create a server for incoming connections and have the server side Communicator own it"
	CpMessageChannel startServerForOwner: server onPort: 1701 path: '/test'.

	"Make connection"
	client connectToUrl: 'ws://localhost:1701/test'.
	self assert: client hasOpenMessageChannel description: 'Made first connection'.

	"Send first message"
	client sendMessage: originalClientMessages first.

	"Close connection from client and send second message"
	client close.

	"Send second message (server will close as a result)"
	client sendMessage: originalClientMessages second.
	semaphore wait.

	"Send third message"	
	client sendMessage: originalClientMessages third.

	"Wait for final message"
	semaphore wait.

	"Validate messages"
	self assertCollection: originalClientMessages equals: serverMessages
]

{ #category : #tests }
CpCommunicatorTest >> testSendReceive [

	"These tests are disabled because safety checks prevent it (to prevent communicators from crashing the image)"

	| originalClientMessages originalServerMessages client clientOwner clientMessages server serverOwner serverMessages semaphore |

	self skip.

	originalClientMessages := OrderedCollection newFrom: (
		{ 'Hello' . 'World' . 'Welcome' } collect: [ :each | each asByteArray ]).
	originalServerMessages := OrderedCollection newFrom: (
		{ '42' . 'is' . 'the' . 'answer' } collect: [ :each | each asByteArray ]).

	serverMessages := OrderedCollection new.
	serverOwner := CpMessageHandler new
		onMessage: [ :message |
			serverMessages add: message.
			serverMessages size = 3
				ifTrue: [ semaphore signal ] ] ;
		yourself.
	server := CpServerCommunicator newForOwner: serverOwner.

	clientMessages := OrderedCollection new.
	clientOwner := CpMessageHandler new
		onMessage: [ :message |
			clientMessages add: message.
			clientMessages size = 4
				ifTrue: [ semaphore signal ] ] ;
		yourself.
	client := CpClientCommunicator newForOwner: clientOwner.

	"Create a server for incoming connections and have the server side Communicator own it"
	CpMessageChannel startServerForOwner: server onPort: 1701 path: '/test'.

	"Make connection"
	client connectToUrl: 'ws://localhost:1701/test'.

	"Send messages"
	semaphore := Semaphore new.
	[ originalClientMessages do: [ :each | client sendMessage: each ] ] fork.
	[ originalServerMessages do: [ :each | server sendMessage: each ] ] fork.
	semaphore wait.
	semaphore wait.

	"Validate messages"
	self
		assertCollection: originalClientMessages equals: serverMessages ;
		assertCollection: originalServerMessages equals: clientMessages
]

{ #category : #tests }
CpCommunicatorTest >> testSendWithReconnects [

	"These tests are disabled because safety checks prevent it (to prevent communicators from crashing the image)"

	| originalClientMessages client clientOwner server serverOwner serverMessages semaphore |

	self skip.

	originalClientMessages := OrderedCollection newFrom: (
		{ 'Hello' . 'World' . 'Welcome' . 'Here' } collect: [ :each | each asByteArray ]).

	semaphore := Semaphore new.
	serverMessages := OrderedCollection new.
	serverOwner := CpMessageHandler new
		onMessage: [ :message |
			serverMessages add: message.
			serverMessages size = 4
				ifTrue: [ semaphore signal ] ] ;
		yourself.
	server := CpServerCommunicator newForOwner: serverOwner.

	"Client does not receive messages, so empty owner"
	clientOwner := CpMessageHandler new.
	client := CpClientCommunicator newForOwner: clientOwner.

	"Create a server for incoming connections and have the server side Communicator own it"
	CpMessageChannel startServerForOwner: server onPort: 1701 path: '/test'.

	"Make connection"
	client connectToUrl: 'ws://localhost:1701/test'.
	self assert: client hasOpenMessageChannel description: 'Made first connection'.

	"Send first message"
	client sendMessage: originalClientMessages first.

	"Close connection and send second message"
	client close.
	client sendMessage: originalClientMessages second.
	self assert: client hasOpenMessageChannel not description: 'Client is no longer connected'.

	"Make new connection and send third message"	
	client connectToUrl: 'ws://127.0.0.1:1701/test'.
	self assert: client hasOpenMessageChannel description: 'Make second connection'.

	client sendMessage: originalClientMessages third.

	"Reconnect and send fourth message"
	client reconnect.
	self assert: client hasOpenMessageChannel description: 'Make third connection'.
	client sendMessage: originalClientMessages fourth.

	"Wait for final message"
	semaphore wait.

	"Validate messages"
	self assertCollection: originalClientMessages equals: serverMessages
]

{ #category : #tests }
CpCommunicatorTest >> testServerSendBeforeConnection [

	"These tests are disabled because safety checks prevent it (to prevent communicators from crashing the image)"

	| originalClientMessages originalServerMessages client clientOwner clientMessages server serverOwner serverMessages semaphore |

	self skip.

	originalClientMessages := OrderedCollection newFrom: (
		{ 'Hello' . 'World' . 'Welcome' } collect: [ :each | each asByteArray ]).
	originalServerMessages := OrderedCollection newFrom: (
		{ '42' . 'is' . 'the' . 'answer' } collect: [ :each | each asByteArray ]).

	serverMessages := OrderedCollection new.
	serverOwner := CpMessageHandler new
		onMessage: [ :message |
			serverMessages add: message.
			serverMessages size = 3
				ifTrue: [ semaphore signal ] ] ;
		yourself.
	server := CpServerCommunicator newForOwner: serverOwner.

	clientMessages := OrderedCollection new.
	clientOwner := CpMessageHandler new
		onMessage: [ :message |
			clientMessages add: message.
			clientMessages size = 4
				ifTrue: [ semaphore signal ] ] ;
		yourself.
	client := CpClientCommunicator newForOwner: clientOwner.

	"Create a server for incoming connections and have the server side Communicator own it"
	CpMessageChannel startServerForOwner: server onPort: 1701 path: '/test'.

	originalServerMessages do: [ :each | server sendMessage: each ].

	"Make connection"
	client connectToUrl: 'ws://localhost:1701/test'.

	"Send messages"
	semaphore := Semaphore new.
	[ originalClientMessages do: [ :each | client sendMessage: each ] ] fork.
	semaphore wait.
	semaphore wait.

	"Validate messages"
	self
		assertCollection: originalClientMessages equals: serverMessages ;
		assertCollection: originalServerMessages equals: clientMessages
]
