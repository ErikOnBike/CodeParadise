Extension { #name : #Integer }

{ #category : #'*RemoteEnvironment' }
Integer >> byteSize [

	"Answer the size of receiver in bytes"

	<clientEnvironment>

	^ self digitLength
]

{ #category : #'*RemoteEnvironment' }
Integer >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeInteger: self
]
