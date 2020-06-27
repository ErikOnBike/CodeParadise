Extension { #name : #AdditionalMethodState }

{ #category : #'*RemoteEnvironment' }
AdditionalMethodState >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	self properties
		ifNotEmpty: [ self error: 'Methods with properties are currently not supported' ].

	anEncoder encodeAdditionalMethodState: self
]
