Extension { #name : #Interval }

{ #category : #'*CodeParadise-RemoteEnvironment' }
Interval >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeInterval: self
]
