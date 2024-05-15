Extension { #name : 'LiteralVariable' }

{ #category : '*CodeParadise-RemoteEnvironment-Pharo9' }
LiteralVariable >> cpEncodeWith: anEncoder [

	"Encode the receiver based on fact that it implements similar protocol as Associaton (ie #key and #value)"

	<clientEnvironment>

	anEncoder encodeAssociation: self
]
