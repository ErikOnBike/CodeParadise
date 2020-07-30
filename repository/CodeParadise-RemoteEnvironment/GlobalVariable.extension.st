Extension { #name : #GlobalVariable }

{ #category : #'*CodeParadise-RemoteEnvironment' }
GlobalVariable >> cpEncodeWith: anEncoder [

	anEncoder encodeGlobalVariable: self
]
