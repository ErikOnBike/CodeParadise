Extension { #name : #False }

{ #category : #'*RemoteEnvironment' }
False >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeFalse
]
