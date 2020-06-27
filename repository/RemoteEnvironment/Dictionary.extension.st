Extension { #name : #Dictionary }

{ #category : #'*RemoteEnvironment' }
Dictionary >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeDictionary: self
]
