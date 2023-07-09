"
I am a WebSocket based MessageChannel. My implementation is for usage in a Javascript environment using a WebSocket as network interface. I am a MessageChannel from client to server (ie currently I do not support messaging from server to client). As a MessageChannel I can still send and receive messages.

Implementation:
I expect to be running on a SqueakJS-VM.
I can (probably) never support running from server to client when used inside a web browser. When used inside Node.js I will support running from server to client (in a future version).
"
Class {
	#name : #CpJavascriptWebSocketChannel,
	#superclass : #CpMessageChannel,
	#instVars : [
		'state',
		'eventSemaphore',
		'semaphoreIndex'
	],
	#category : #'CodeParadise-RemoteEnvironment-Core'
}

{ #category : #'public api' }
CpJavascriptWebSocketChannel class >> forOwner: ownerObject connectedToUrl: urlString [

	"Create for the specified owner, a new instance of the receiver which is connected
	to the specified URL.
	Implementation: A primitive WebSocket is created which operates asynchronously and
	uses a Semaphore to signal events. For convenience #connectToUrl: does wait for the
	connection to become established (or explicitly fails)."

	| instance |

	instance := self newForOwner: ownerObject.
	(instance connectToUrl: urlString)
		ifFalse: [
			instance release.
			^ nil ].

	"Start message handler now that the connection is established"
	^ instance
		createMessageHandler ;
		yourself
]

{ #category : #'instance creation' }
CpJavascriptWebSocketChannel class >> newForOwner: ownerObject [

	"Answer a new instance of the receiver with the specified owner"

	^ self basicNew
		initializeWithOwner: ownerObject ;
		yourself
]

{ #category : #'public api' }
CpJavascriptWebSocketChannel class >> startServerForOwner: ownerObject onPort: anInteger path: aString [

	"Create a server listening on the specified port and path.
	When a new connection is made a new instance of the receiver is created for the
	specified owner. The owner Object will need to handle the relevant events.
	See CpMessageChannel>>#owner:."

	"A Javascript implementation for Node.js is in the making. There will not be
	a web browser implementation, since web browsers should not allow incoming network
	connections (because of security reasons)."

	self flag: #todo.

	Error signal: 'Currently the Javascript implementation is still missing'
]

{ #category : #'public api' }
CpJavascriptWebSocketChannel >> close [

	"Close the receiver, thereby making the receiver unusable.
	Implementation: Closing is performed asynchronously and an event will be signalled when closed."

	<primitive: 'primitiveWebSocketClose' module: 'CpSystemPlugin'>
	self primitiveFailed

]

{ #category : #private }
CpJavascriptWebSocketChannel >> connectToUrl: urlString [

	"Connect the receiver to the specified URL and answer whether this succeeded.
	Implementation: A primitive WebSocket is created which operates asynchronously and uses a Semaphore
	to signal events. Make this method synchronous: wait for the connection to become ready."

	self connectToUrl: urlString withEventSemaphore: semaphoreIndex.

	"Wait for state to become different than -1 (unused) or 0 (connecting)"
	[ #(-1 0) includes: state  ] whileTrue: [ self updateState ].

	"Connection is only successful if state is open"
	^ self isOpen
]

{ #category : #private }
CpJavascriptWebSocketChannel >> connectToUrl: urlString withEventSemaphore: semaIndex [

	"Connect the primitive WebSocket to the specified URL and use the specified Semaphore for signaling events"

	<primitive: 'primitiveWebSocketConnectToUrl:withEventSemaphore:' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #'message handling' }
CpJavascriptWebSocketChannel >> handleMessageHandlerError: anError [ 

	"Announce the error (for debugger or otherwise)"
	CpExceptionAnnouncer announceException: anError.

	super handleMessageHandlerError: anError
]

{ #category : #initialization }
CpJavascriptWebSocketChannel >> initialize [

	"Initialize the receiver.
	Implementation: Start with an 'unused' state so #isOpen will answer false."

	super initialize.

	eventSemaphore := Semaphore new.
	semaphoreIndex := (Smalltalk registerExternalObject: eventSemaphore)
		ifNil: [ Error signal: 'Failed to register semaphore for WebSocket connection' ].

	state := -1

]

{ #category : #'public api' }
CpJavascriptWebSocketChannel >> isOpen [

	"Receiver is considered open if state is 'open'.
	See #updateState"

	^ state = 1
]

{ #category : #private }
CpJavascriptWebSocketChannel >> readyState [

	"Answer the state of the primitive WebSocket.
	See https://devdocs.io/dom/websocket/readystate"

	<primitive: 'primitiveWebSocketReadyState' module: 'CpSystemPlugin'>
	self primitiveFailed

]

{ #category : #'message handling' }
CpJavascriptWebSocketChannel >> receivedMessage [

	"Answer the next message received or nil if none is available.
	Implementation: The WebSocket works asynchronous and will respond directly with either the
	'oldest' message received or nil if no messages are left."

	<primitive: 'primitiveWebSocketReceivedMessage' module: 'CpSystemPlugin'>
	self primitiveFailed

]

{ #category : #initialization }
CpJavascriptWebSocketChannel >> release [

	"Release instance variables of the receiver.
	Implementation: Reset the state to an 'unused' value so #isOpen will answer false."

	eventSemaphore ifNotNil: [
		Smalltalk unregisterExternalObject: eventSemaphore.
		eventSemaphore := nil ].
	semaphoreIndex := nil.

	state := -1.

	super release
]

{ #category : #private }
CpJavascriptWebSocketChannel >> send: aByteArray [

	"Send the message through the primitive WebSocket (asynchronous).
	Answer a Boolean indicating whether send was successful."

	<primitive: 'primitiveWebSocketSend:' module: 'CpSystemPlugin'>
	self primitiveFailed

]

{ #category : #'public api' }
CpJavascriptWebSocketChannel >> sendMessage: aByteArray [

	"Send the specified message.
	An Exception should be thrown if sending failed."

	(self send: aByteArray)
		ifFalse: [ Error signal: 'Failed to send message' ]
]

{ #category : #'state handling' }
CpJavascriptWebSocketChannel >> updateState [

	"Update the receiver's state.
	Implementation: The receiver works asynchronously, so wait for events to be signalled.

	Set state according to primitive WebSocket (negative state values are used internally)
		0 - connecting
		1 - open (and ready to communicate)
		2 - closing
		3 - closed (or could not be opened)
	See https://developer.mozilla.org/en-US/docs/Web/API/WebSocket/readyState
	"

	"Set the state before and after waiting for the next event, so other processes see
	the correct state of the receiver. No need to wait for another event if state is 3 (closed)."
	(state := self readyState) = 3
		ifTrue: [ ^ self ].
	eventSemaphore ifNil: [ ^ self ].
	eventSemaphore wait.
	state := self readyState
]
