Extension { #name : #Pragma }

{ #category : #'*RemoteEnvironment' }
Pragma >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodePragma: self
]
