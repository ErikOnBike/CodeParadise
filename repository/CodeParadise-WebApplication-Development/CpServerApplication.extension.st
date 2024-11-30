Extension { #name : #CpServerApplication }

{ #category : #'*CodeParadise-WebApplication-Development' }
CpServerApplication >> stopIfNotConnected [

	"Stop the receiver if it is no longer connected
	(i.e. has built up unsent messages)"

	self environment ifNotNil: [ :serverEnvironment |

		"Send two 'ping' messages to the client"
		serverEnvironment sendMessageDirectly: (MessageSend receiver: nil selector: #yourself).
		serverEnvironment sendMessageDirectly: (MessageSend receiver: nil selector: #yourself).

		serverEnvironment communicator ifNotNil: [ :communicator |
			communicator unsentMessagesCount > 1
				ifTrue: [ self stop ] ] ]
]
