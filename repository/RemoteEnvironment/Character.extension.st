Extension { #name : #Character }

{ #category : #'*RemoteEnvironment' }
Character >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeCharacter: self
]
