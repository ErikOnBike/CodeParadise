Extension { #name : #Point }

{ #category : #'*CodeParadise-RemoteEnvironment' }
Point >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodePoint: self
]
