Extension { #name : #Integer }

{ #category : #'*WebApplication' }
Integer >> byteSize [

	"Answer the size of receiver in bytes"

	<clientEnvironment>

	^ self digitLength
]

{ #category : #'*WebApplication' }
Integer >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeInteger: self
]
