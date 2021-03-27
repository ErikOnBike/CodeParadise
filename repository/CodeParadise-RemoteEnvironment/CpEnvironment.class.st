"
I am an abstract Environment. I form the basis for a RemoteEnvironment which allows remote Smalltalk code execution. A RemoteEnvironment is a combination of a ClientEnvironment and ServerEnvironment. I am responsible for the communication with the other Environment (from client to server or vice versa). I use a Communicator to communicate.

"
Class {
	#name : #CpEnvironment,
	#superclass : #Object,
	#instVars : [
		'id',
		'communicator'
	],
	#category : #'CodeParadise-RemoteEnvironment-Core'
}

{ #category : #accessing }
CpEnvironment class >> communicatorClass [

	"Answer the Communicator Class for the receiver"

	self subclassResponsibility
]

{ #category : #accessing }
CpEnvironment >> communicator [

	"Answer the receiver's communicator"

	^ communicator
]

{ #category : #accessing }
CpEnvironment >> communicator: aCommunicator [

	"Set the receiver's Communicator"

	communicator := aCommunicator
]

{ #category : #support }
CpEnvironment >> createCommunicator [

	"Create a new communicator for the receiver and answer it"

	^ self class communicatorClass newForOwner: self
]

{ #category : #'event handling' }
CpEnvironment >> handleMessageReceived: aByteArray [

	"Handle the message received"

	self subclassResponsibility
]

{ #category : #testing }
CpEnvironment >> hasCommunicator [

	"Answer whether the receiver has a Communicator setup"

	^ communicator notNil
]

{ #category : #accessing }
CpEnvironment >> id [

	"Answer the receivers identifier (a String)"

	^ id
]

{ #category : #accessing }
CpEnvironment >> id: identifier [

	"Set the identifier of the receiver"

	id := identifier
]

{ #category : #testing }
CpEnvironment >> isRunning [

	"Answer whether the receiver is running"

	^ id notNil and: [ communicator notNil ]
]

{ #category : #dependencies }
CpEnvironment >> release [

	"Release the receiver's instance variables"

	communicator ifNotNil: [
		communicator close.
		communicator := nil ].

	id := nil.

	super release
]

{ #category : #'input/output' }
CpEnvironment >> sendEncodedMessage: aByteArray [

	"Send encoded message to the connected party"

	self hasCommunicator ifFalse: [ ^ self ].

	self communicator sendMessage: aByteArray
]

{ #category : #'input/output' }
CpEnvironment >> sendMessage: aMessageSend [

	"Send the specified MessageSend to the server"

	self sendEncodedMessage: aMessageSend cpEncoded
]

{ #category : #support }
CpEnvironment >> startCommunication [

	"Start communication with the other party"

	self communicator: self createCommunicator
]

{ #category : #support }
CpEnvironment >> stopCommunication [

	"Stop communication with server"

	self hasCommunicator ifFalse: [ ^ self ].

	self communicator close
]
