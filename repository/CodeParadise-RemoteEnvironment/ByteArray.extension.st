Extension { #name : #ByteArray }

{ #category : #'*CodeParadise-RemoteEnvironment' }
ByteArray >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeByteArray: self
]
