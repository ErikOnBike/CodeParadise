Extension { #name : 'Character' }

{ #category : '*CodeParadise-RemoteEnvironment' }
Character >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeCharacter: self
]
