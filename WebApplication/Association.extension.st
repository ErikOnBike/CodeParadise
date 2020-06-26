Extension { #name : #Association }

{ #category : #'*WebApplication' }
Association >> cpEncodeWith: anEncoder [

	<clientEnvironment>

(self class name ~= #Association and: [ self class name ~= #ClassVariable and: [ self class name ~= #GlobalVariable and: [ self class name ~= #UndeclaredVariable ] ] ]) ifTrue: [ self halt. ].
	anEncoder encodeAssociation: self
]
