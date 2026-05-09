Extension { #name : #SortedCollection }

{ #category : #'*CodeParadise-RemoteEnvironment' }
SortedCollection >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeSortedCollection: self
]
