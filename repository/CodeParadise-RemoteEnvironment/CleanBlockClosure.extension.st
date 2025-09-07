Extension { #name : #CleanBlockClosure }

{ #category : #'*CodeParadise-RemoteEnvironment' }
CleanBlockClosure >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeCleanBlockClosure: self
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
CleanBlockClosure class >> numArgs: numArgs [

	<clientEnvironment>

	^ self new
		numArgs: numArgs ;
		yourself
]
