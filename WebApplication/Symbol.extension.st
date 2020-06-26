Extension { #name : #Symbol }

{ #category : #'*WebApplication' }
Symbol >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeSymbol: self
]
