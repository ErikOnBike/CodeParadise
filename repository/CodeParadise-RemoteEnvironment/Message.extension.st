Extension { #name : 'Message' }

{ #category : '*CodeParadise-RemoteEnvironment' }
Message >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeMessage: self
]
