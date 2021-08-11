"
I am an Object which acts as a owner for a MessageChannel or a Communicator. Instead of handling events from the MessageChannel or Communicator, I delegate this to handlers which perform the required handling.
Two type of handlers can be installed:
	onMessage: oneArgumentBlock ""The argument will be the message (a ByteArray)""
	onClose: zeroArgumentsBlock

"
Class {
	#name : #CpMessageHandler,
	#superclass : #Object,
	#instVars : [
		'handlers',
		'messageChannel'
	],
	#category : #'CodeParadise-RemoteEnvironment-Tests'
}

{ #category : #'event handling' }
CpMessageHandler >> handleMessageReceived: aByteArray [

	"Handle the message event"

	"Handle message or close event"
	aByteArray
		ifNotNil: [ (self handlers at: #message ifAbsent: [ ^ self ]) value: aByteArray ]
		ifNil: [ (self handlers at: #close ifAbsent: [ ^ self ]) value ]
]

{ #category : #'event handling' }
CpMessageHandler >> handleMessageReceived: aByteArray on: aMessageChannel [

	"Handle the message event"

	messageChannel := aMessageChannel.

	self handleMessageReceived: aByteArray
]

{ #category : #accessing }
CpMessageHandler >> handlers [

	^ handlers
]

{ #category : #initialization }
CpMessageHandler >> initialize [

	super initialize.

	handlers := Dictionary new
]

{ #category : #accessing }
CpMessageHandler >> messageChannel [

	^ messageChannel
]

{ #category : #'event handling' }
CpMessageHandler >> onClose: zeroArgumentsBlock [

	"Set the close handler"

	self handlers at: #close put: zeroArgumentsBlock
]

{ #category : #'event handling' }
CpMessageHandler >> onMessage: oneArgumentBlock [

	"Set the message handler.
	The specified handler Block should accept a ByteArray which is the message received."

	self handlers at: #message put: oneArgumentBlock
]

{ #category : #initialization }
CpMessageHandler >> release [

	handlers := nil.

	super release
]
