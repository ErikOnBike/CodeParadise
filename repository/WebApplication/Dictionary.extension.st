Extension { #name : #Dictionary }

{ #category : #'*WebApplication' }
Dictionary >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeDictionary: self
]
