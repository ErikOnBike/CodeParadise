Extension { #name : #Symbol }

{ #category : #'*CodeParadise-RemoteEnvironment' }
Symbol >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeSymbol: self
]
