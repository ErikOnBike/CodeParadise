"
I am a WebSocket based MessageChannel. My implementation is based on the Zinc WebSocket. I can act as client as well as server.
"
Class {
	#name : #CpZincWebSocketChannel,
	#superclass : #CpMessageChannel,
	#instVars : [
		'znWebSocket',
		'serverSemaphore'
	],
	#category : #'CodeParadise-RemoteEnvironment-Core'
}

{ #category : #'public api' }
CpZincWebSocketChannel class >> for: ownerObject connectedToUrl: urlString [

	"Create for the specified owner, a new instance of the receiver which is connected
	to the specified URL."

	^ [ self newForOwner: ownerObject on: (ZnWebSocket to: (ZnUrl fromString: urlString)) ]
		on: Error do: [ nil ]
]

{ #category : #private }
CpZincWebSocketChannel class >> newForOwner: ownerObject on: znWebSocket [

	"Answer a new instance of the receiver for the specified owner and using the specified Zinc
	WebSocket.
	Implementation: The Zinc WebSocket operates synchronously and therefore connection is 'open'
	directly after the instance is created. Start the instance's message handler directly as well."

	^ self basicNew
		initializeFor: ownerObject with: znWebSocket ;
		createMessageHandler ;
		yourself
]

{ #category : #'public api' }
CpZincWebSocketChannel class >> startServerFor: ownerObject onPort: anInteger path: aString [

	"Create a server listening on the specified port and path.
	When a new connection is made a new instance of the receiver is created for the
	specified owner. The owner Object will need to handle the relevant events.
	See CpMessageChannel>>#owner:.
	Implementation:
	A ZnServer instance will be answered for this receiver.
	The Zinc WebSockets are operated synchronously. To prevent the channel from closing
	directly after first usage, wait for the channel to close down explicitly."

	^ ZnWebSocket startServerOn: anInteger prefix: aString do: [ :znWebSocket |

		"Create a new running server instance and wait for it to close/stop"
		(self newForOwner: ownerObject on: znWebSocket)
			serverWait ]
]

{ #category : #'public api' }
CpZincWebSocketChannel >> close [

	"Close the receiver, thereby making the receiver unusable.
	Implementation: With the current synchronous Zinc WebSocket implementation, closing the
	receiver will not correctly trigger a ConnectionClosed in the process running the
	message handler (more specific in #receivedMessage which operates synchronous).
	Only after a timeout (by default 30 seconds) will the message handler terminate.
	Therefore, only a WebSocket close frame is sent here. This will terminate the
	message handler directly. Closing the WebSocket stream (which is normally done when
	closing the ZnWebSocket) is done in the #release method."

	self isOpen
		ifFalse: [ ^ self ].

	"See explanation above. The code below should have been: znWebSocket close"
	znWebSocket sendFrame: ZnWebSocketFrame close
]

{ #category : #initialization }
CpZincWebSocketChannel >> initializeFor: ownerObject with: aZnWebSocket [

	"Initialize the receiver with the specified ZnWebSocket"

	self initialize.

	owner := ownerObject.
	znWebSocket := aZnWebSocket.

	"If receiver runs as server, create Semaphore to allow waiting until receiver closes"
	 znWebSocket role = #server
		ifTrue: [ serverSemaphore := Semaphore new ]
]

{ #category : #'public api' }
CpZincWebSocketChannel >> isOpen [

	"The receiver is considered open if the Zinc WebSocket is connected"

	^ znWebSocket notNil and: [ znWebSocket isConnected ]
]

{ #category : #'message handling' }
CpZincWebSocketChannel >> receivedMessage [

	"Answer the next message received or nil if none is available.
	Implementation: The Zinc WebSocket readMessage is synchronous, but can time out."

	| message | 

	self isOpen
		ifFalse: [ ^ nil ].

	"On macOs a PrimitiveFailed can occur, ignore it"
	message := [ znWebSocket readMessage ] 
		on: ConnectionClosed, ConnectionTimedOut, PrimitiveFailed
		do: [ nil ].

	^ message
]

{ #category : #initialization }
CpZincWebSocketChannel >> release [

	"Release the receiver's instance variables"

	"Signal server semaphore to allow server wait process to stop"
	serverSemaphore ifNotNil: [ 
		serverSemaphore signal.
		serverSemaphore := nil ].

	"Close the Zinc WebSocket stream if not already closed. See #close for explanation."
	znWebSocket ifNotNil: [ 
		znWebSocket stream ifNotNil: [ :stream | stream isConnected ifTrue: [ stream close ] ].
		znWebSocket := nil ].

	super release
]

{ #category : #'public api' }
CpZincWebSocketChannel >> sendMessage: aByteArray [

	"Send the specified message.
	An Exception should be thrown if sending failed."

	self isOpen
		ifFalse: [ ^ self ].

	znWebSocket sendMessage: aByteArray
]

{ #category : #support }
CpZincWebSocketChannel >> serverWait [

	"Wait for the receiver to stop serving requests.
	Implementation: During initialization a Semaphore is created, use this to wait for releasing
	the receiver."

	serverSemaphore ifNotNil: [ serverSemaphore wait ]
]
