Extension { #name : #CompiledBlock }

{ #category : #'*CodeParadise-RemoteEnvironment-Pharo9' }
CompiledBlock >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeCompiledBlock: self
]
