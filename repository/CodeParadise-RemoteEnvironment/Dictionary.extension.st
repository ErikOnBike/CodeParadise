Extension { #name : #Dictionary }

{ #category : #'*CodeParadise-RemoteEnvironment' }
Dictionary >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeDictionary: self
]
