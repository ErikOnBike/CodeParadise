Extension { #name : 'UndefinedObject' }

{ #category : '*CodeParadise-RemoteEnvironment' }
UndefinedObject >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeNil
]
