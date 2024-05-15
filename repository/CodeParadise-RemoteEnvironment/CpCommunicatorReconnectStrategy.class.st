"
I am a reconnection strategy for ClientCommunicators. I decide whether a reconnect is needed based on the state of a ClientCommunicator. I expect to be invoked when the ClientCommunicator has lost connection or has a disfunctioning connection (ie I do not need to test whether a valid connection is present).

My default behavior is to always suggest a reconnect. My subclasses can implement more elaborate strategies. For example based on the amount of retries in a given period to prevent flooding the server with connection requests. The ClientCommunicator's state can also be used: it knows the amount of pending/unsent messages.

"
Class {
	#name : 'CpCommunicatorReconnectStrategy',
	#superclass : 'Object',
	#category : 'CodeParadise-RemoteEnvironment-Core',
	#package : 'CodeParadise-RemoteEnvironment',
	#tag : 'Core'
}

{ #category : 'asserting' }
CpCommunicatorReconnectStrategy >> shouldReconnect: aCommunicator [

	"There is no usable connection for the Communicator.
	Answer whether the specified Communicator should reconnect.
	Subclasses should override this behavior."

	^ true
]
