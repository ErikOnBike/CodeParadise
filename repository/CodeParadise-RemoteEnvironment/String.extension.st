Extension { #name : #String }

{ #category : #'*CodeParadise-RemoteEnvironment' }
String >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeString: self
]
