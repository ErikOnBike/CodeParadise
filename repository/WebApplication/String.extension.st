Extension { #name : #String }

{ #category : #'*WebApplication' }
String >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeString: self
]
