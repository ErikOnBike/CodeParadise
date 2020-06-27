Extension { #name : #Float }

{ #category : #'*RemoteEnvironment' }
Float >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeFloat: self
]
