Extension { #name : #String }

{ #category : #'*RemoteEnvironment' }
String >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeString: self
]
