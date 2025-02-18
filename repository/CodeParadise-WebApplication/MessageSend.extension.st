Extension { #name : #MessageSend }

{ #category : #'*CodeParadise-WebApplication' }
MessageSend >> forked [

	"Answer a forked version of the receiver"

	<webApplicationExtension>

	^ CpForkedMessageSend
		receiver: receiver
		selector: selector
		arguments: arguments
]
