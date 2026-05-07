Extension { #name : #CleanBlockClosure }

{ #category : #'*CodeParadise-RemoteEnvironment' }
CleanBlockClosure >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeCleanBlockClosure: self
]
