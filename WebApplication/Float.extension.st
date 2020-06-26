Extension { #name : #Float }

{ #category : #'*WebApplication' }
Float >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeFloat: self
]
