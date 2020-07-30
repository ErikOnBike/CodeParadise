Extension { #name : #CompiledBlock }

{ #category : #'*CodeParadise-RemoteEnvironment-Pharo9' }
CompiledBlock >> cpEncodeWith: anEncoder [

	self error: 'RemoteEnvironment does not support the Sista bytecode set used in the current image (yet)'
]
