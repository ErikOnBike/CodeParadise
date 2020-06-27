Extension { #name : #ClassVariable }

{ #category : #'*RemoteEnvironment' }
ClassVariable >> cpEncodeWith: anEncoder [

	anEncoder encodeClassVariable: self
]
