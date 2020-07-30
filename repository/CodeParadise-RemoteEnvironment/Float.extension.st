Extension { #name : #Float }

{ #category : #'*CodeParadise-RemoteEnvironment' }
Float >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeFloat: self
]
