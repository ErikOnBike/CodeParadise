Extension { #name : #GlobalVariable }

{ #category : #'*RemoteEnvironment' }
GlobalVariable >> cpEncodeWith: anEncoder [

	anEncoder encodeGlobalVariable: self
]
