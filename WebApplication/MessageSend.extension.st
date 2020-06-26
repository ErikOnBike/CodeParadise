Extension { #name : #MessageSend }

{ #category : #'*WebApplication' }
MessageSend >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeMessageSend: self
]
