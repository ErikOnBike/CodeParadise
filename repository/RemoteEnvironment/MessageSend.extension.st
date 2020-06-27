Extension { #name : #MessageSend }

{ #category : #'*RemoteEnvironment' }
MessageSend >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeMessageSend: self
]
