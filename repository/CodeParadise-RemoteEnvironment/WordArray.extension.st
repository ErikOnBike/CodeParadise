Extension { #name : #WordArray }

{ #category : #'*CodeParadise-RemoteEnvironment' }
WordArray >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeWordArray: self
]
