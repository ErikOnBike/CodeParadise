Extension { #name : 'ConstantBlockClosure' }

{ #category : '*CodeParadise-RemoteEnvironment-Pharo11' }
ConstantBlockClosure >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeConstantBlockClosure: self
]
