Extension { #name : #Symbol }

{ #category : #'*RemoteEnvironment' }
Symbol >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeSymbol: self
]
