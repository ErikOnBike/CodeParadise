Extension { #name : #ClassVariable }

{ #category : #'*CodeParadise-RemoteEnvironment' }
ClassVariable >> cpEncodeWith: anEncoder [

	anEncoder encodeClassVariable: self
]
