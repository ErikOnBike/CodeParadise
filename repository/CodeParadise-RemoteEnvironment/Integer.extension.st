Extension { #name : #Integer }

{ #category : #'*CodeParadise-RemoteEnvironment' }
Integer >> byteSize [
	"Answer the size of receiver in bytes"

	<clientEnvironment>
	^ self bytesCount
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Integer >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeInteger: self
]
