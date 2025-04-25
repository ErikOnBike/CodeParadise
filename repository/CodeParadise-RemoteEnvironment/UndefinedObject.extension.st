Extension { #name : #UndefinedObject }

{ #category : #'*CodeParadise-RemoteEnvironment' }
UndefinedObject >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeNil
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
UndefinedObject >> ifEmptyOrNil: aBlock [

	<clientEnvironment>

	^ aBlock value
]
