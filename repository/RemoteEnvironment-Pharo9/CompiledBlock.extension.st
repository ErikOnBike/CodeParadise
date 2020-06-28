Extension { #name : #CompiledBlock }

{ #category : #'*RemoteEnvironment-Pharo9' }
CompiledBlock >> cpEncodeWith: anEncoder [

	self error: 'RemoteEnvironment does not support the Sista bytecode set used in the current image (yet)'
]
