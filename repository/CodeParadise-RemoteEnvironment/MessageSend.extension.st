Extension { #name : #MessageSend }

{ #category : #'*CodeParadise-RemoteEnvironment' }
MessageSend >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeMessageSend: self
]
