"
I am a Communicator. I am responsible for reliable communication between a client and a server (or vice versa).

I communicate messages between the client and server (or vice versa). I use a MessageChannel to send and receive these messages. For reliability, I make sure that no message is lost, even if my message channel is temporarily not connected or a connection has not been established yet.

The owner (a client or server) creating an instance of me is responsible for handling the messages received.

Implementation:
I have a single owner Object responsible for handling the messages I receive, because this is more performant than having an event/notification mechanism.
On every message received I also receive the MessageChannel on which the message was received. This allows me to update my connection. This is needed since MessageChannels can be used for a single session only. I therefore need to replace my MessageChannel when a reconnect is performed.

"
Class {
	#name : #CpCommunicator,
	#superclass : #Object,
	#instVars : [
		'owner',
		'unsentMessages',
		'unsentMessagesMutex',
		'messageChannel'
	],
	#category : #'CodeParadise-RemoteEnvironment-Core'
}

{ #category : #'instance creation' }
CpCommunicator class >> newForOwner: ownerObject [

	"Answer a new instance of the receiver for the specified owner.
	The owner is responsible for handling the message received and should therefore
	accept the message: #handleMessageReceived:"

	^ self new
		owner: ownerObject ;
		yourself
]

{ #category : #sending }
CpCommunicator >> basicSendMessage: aByteArray [

	"Send message to the server and answer whether send is successful"

	self hasOpenMessageChannel
		ifFalse: [ ^ false ].

	[ self messageChannel sendMessage: aByteArray ] on: Error do: [ ^ false ].

	^ true
]

{ #category : #'public api' }
CpCommunicator >> close [

	"Disconnect from the server"

	self hasMessageChannel ifFalse: [ ^ self ].

	"Since MessageChannels are unusable after close, release it after close"
	self messageChannel close.
	self releaseMessageChannel
]

{ #category : #receiving }
CpCommunicator >> handleMessageReceived: aByteArray on: aMessageChannel [

	"Let the owner handle the message received"

	"The receiver's MessageChannel will be closed if the specified MessageChannel is nil"
	self messageChannel: aMessageChannel.

	aByteArray ifNotNil: [ self owner handleMessageReceived: aByteArray ]
]

{ #category : #testing }
CpCommunicator >> hasMessageChannel [

	"Answer whether the receiver has a MessageChannel (irrespective of its connection state)"

	^ messageChannel notNil
]

{ #category : #testing }
CpCommunicator >> hasOpenMessageChannel [

	"Answer whether the receiver has a MessageChannel which is open (ie can send and receive messages)"

	^ messageChannel notNil and: [ messageChannel isOpen ]
]

{ #category : #initialization }
CpCommunicator >> initialize [

	"Initialze the receiver"

	super initialize.

	unsentMessages := OrderedCollection new.
	unsentMessagesMutex := Mutex new
]

{ #category : #accessing }
CpCommunicator >> messageChannel [

	"Answer the receiver's MessageChannel"

	^ messageChannel
]

{ #category : #accessing }
CpCommunicator >> messageChannel: aMessageChannel [

	"Set the receiver's MessageChannel. If nil the existing MessageChannel closed.
	Implementation: MessageChannels become unusable after closing and new instances might need to be
	set on the receiver. Release the old MessageChannel instance explicitly before setting the new one,
	to allow resources to be released."

	messageChannel = aMessageChannel
		ifTrue: [ ^ self ].

	self releaseMessageChannel.

	(messageChannel := aMessageChannel)
		ifNotNil: [ self sendUnsentMessages ]
]

{ #category : #accessing }
CpCommunicator >> owner [

	"Answer the owner of the receiver"

	^ owner
]

{ #category : #accessing }
CpCommunicator >> owner: ownerObject [

	"Set the owner of the receiver.
	The owner is responsible to handle the messages received by the receiver.
	Therefore ownerObject should accept the message: #handleMessageReceived:"

	owner := ownerObject
]

{ #category : #initialization }
CpCommunicator >> release [

	"Release the receiver's instance variables"

	self releaseMessageChannel.

	unsentMessagesMutex := nil.
	unsentMessages := nil.

	owner := nil.

	super release
]

{ #category : #initialization }
CpCommunicator >> releaseMessageChannel [

	"Release the receiver's MessageChannel.
	Implementation: Release the channel explicitly to free up resources."

	messageChannel ifNil: [ ^ self ].

	messageChannel release.
	messageChannel := nil
]

{ #category : #sending }
CpCommunicator >> sendFirstUnsentMessage [

	"Send the first unsent message. Answer whether send is successful.
	If message can't be sent, keep it as first unsent message."

	unsentMessagesMutex critical: [
		| firstUnsentMessage |

		unsentMessages ifEmpty: [ ^ false ].

		firstUnsentMessage := unsentMessages removeFirst.
		(self basicSendMessage: firstUnsentMessage)
			ifFalse: [
				unsentMessages addFirst: firstUnsentMessage.
				^ false ].

		^ true ]
]

{ #category : #'public api' }
CpCommunicator >> sendMessage: aByteArray [

	"Send message to the server. Store message if sending failed."

	unsentMessagesMutex critical: [

			"If no other messages are pending, try to send message"
			unsentMessages
				ifEmpty: [
					(self basicSendMessage: aByteArray)
						ifTrue: [ ^ self ] ].

			"Add message to end of the collection of unsent messages"
			unsentMessages add: aByteArray ]
]

{ #category : #sending }
CpCommunicator >> sendUnsentMessages [

	"Send all unsent messages in order"

	[ self sendFirstUnsentMessage ] whileTrue

]

{ #category : #'public api' }
CpCommunicator >> unsentMessagesByteSize [

	"Answer the number of bytes inside the unsent messages of the receiver"

	unsentMessagesMutex critical: [
		^ unsentMessages inject: 0 into: [ :sum :each | sum + each size ] ]
]

{ #category : #'public api' }
CpCommunicator >> unsentMessagesCount [

	"Answer the number of unsent messages in the receiver"

	unsentMessagesMutex critical: [ ^ unsentMessages size ]
]
