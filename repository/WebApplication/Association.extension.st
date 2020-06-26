Extension { #name : #Association }

{ #category : #'*WebApplication' }
Association >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	(#(#Association #ClassVariable #GlobalVariable #UndeclaredVariable #LiteralVariable) includes: self class name)
		ifFalse: [ self halt ].

	anEncoder encodeAssociation: self
]
