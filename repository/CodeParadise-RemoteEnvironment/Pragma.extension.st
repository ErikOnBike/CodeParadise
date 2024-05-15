Extension { #name : 'Pragma' }

{ #category : '*CodeParadise-RemoteEnvironment' }
Pragma >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodePragma: self
]
