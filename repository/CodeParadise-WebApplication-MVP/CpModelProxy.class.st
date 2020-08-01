"
I am a Proxy for a Model in a Model-View-Presenter pattern.
I only live in a ClientEnvironment.
"
Class {
	#name : #CpModelProxy,
	#superclass : #Object,
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #'reflective operations' }
CpModelProxy >> doesNotUnderstand: aMessage [

	"Forward the message received as an update event to the server.

	Implementation: The id of the sender is added to the arguments for server side identification."

	| environment sender senderId |

	environment := CpClientEnvironment current.
	sender := thisContext sender receiver.
	senderId := environment objectRegistry
		idOfObject: sender
		ifAbsent: [
			environment serverAnnounce: (CpUnidentifiedObjectUsed
				description: 'ModelProxy used by an unidentified/unregistered Object: ', sender printString).
			^ self ].

	environment serverAnnounce: (CpMessageToProxyReceived
		messageSend: (MessageSend
			receiver: senderId
			selector: aMessage selector
			arguments: aMessage arguments))
]
