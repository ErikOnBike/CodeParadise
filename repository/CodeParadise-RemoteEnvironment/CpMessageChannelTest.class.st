"
Tests for MessageChannel
"
Class {
	#name : #CpMessageChannelTest,
	#superclass : #TestCase,
	#category : #'CodeParadise-RemoteEnvironment-Tests'
}

{ #category : #tests }
CpMessageChannelTest >> testLocalClientServer [

	| originalMessages client clientOwner clientEvents clientMessages server serverOwner serverEvents serverMessages semaphore |

	"Start with collection of messages (should be ByteArrays)"
	originalMessages := OrderedCollection newFrom: (
		{ 'Hello' . 'World' . 'Welcome' } collect: [ :each | each asByteArray ]).

	"Create semaphore to signal between processes"
	semaphore := Semaphore new.

	"Setup event and message collections"
	clientEvents := OrderedCollection new.
	serverEvents := OrderedCollection new.
	clientMessages := OrderedCollection new.
	serverMessages := OrderedCollection new.

	"Start server"
	serverOwner := CpMessageHandler new
		onMessage: [ :message |
			"Store received message and send a copy back to the client"
			serverMessages add: message.
			serverOwner messageChannel sendMessage: message ] ;
		onClose: [
			serverEvents add: #close.
			semaphore signal ] ;
		yourself.
	server := CpMessageChannel startServerForOwner: serverOwner onPort: 1701 path: '/test'.

	"Start client (clients do not receive 'open' message)"
	clientOwner := CpMessageHandler new
		onMessage: [ :message |
			clientMessages add: message.
			clientMessages size = originalMessages size
				ifTrue: [ semaphore signal ] ] ;
		onClose: [
			clientEvents add: #close.
			semaphore signal ]
		yourself.
	client := CpMessageChannel forOwner: clientOwner connectedToUrl: 'ws://localhost:1701/test'.

	"Validate connection established"
	self
		assert: client isOpen
		description: 'Client connected'.

	"Start sending messages from client to server (server will send back messages directly)"
	originalMessages do: [ :each | client sendMessage: each ].

	"Wait for messages to be sent from client to server and vice versa"
	semaphore wait.

	"Validate messages"
	self
		assertCollection: originalMessages equals: serverMessages ;
		assertCollection: originalMessages equals: clientMessages.

	"Validate no close yet"
	self
		assertCollection: #() hasSameElements: serverEvents ;
		assertCollection: #() hasSameElements: clientEvents.

	"Close client connection, then wait for 2 signals (from both MessageChannels)"
	client close.
	semaphore wait.
	semaphore wait.
	server stop.

	"Validate events"
	self
		assertCollection: #(#close) hasSameElements: serverEvents ;
		assertCollection: #(#close) hasSameElements: clientEvents
]
