Extension { #name : 'False' }

{ #category : '*CodeParadise-RemoteEnvironment' }
False >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeFalse
]
