Extension { #name : #GlobalVariable }

{ #category : #'*WebApplication' }
GlobalVariable >> cpEncodeWith: anEncoder [

	anEncoder encodeGlobalVariable: self
]
