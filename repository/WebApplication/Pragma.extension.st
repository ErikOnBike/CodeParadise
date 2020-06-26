Extension { #name : #Pragma }

{ #category : #'*WebApplication' }
Pragma >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodePragma: self
]
