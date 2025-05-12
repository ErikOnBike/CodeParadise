Extension { #name : #MessageSend }

{ #category : #'*CodeParadise-WebApplication' }
MessageSend >> deferred [

	"Answer a deferred version of the receiver"

	<webApplicationExtension>

	^ CpDeferredMessageSend
		receiver: receiver
		selector: selector
		arguments: arguments
]
