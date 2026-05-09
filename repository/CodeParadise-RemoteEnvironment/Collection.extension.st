Extension { #name : #Collection }

{ #category : #'*CodeParadise-RemoteEnvironment' }
Collection >> asCpEncodedArray [

	^ self asArray
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Collection >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeCollection: self
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Collection >> ifEmptyOrNil: aBlock [

	<clientEnvironment>

	^ self isEmpty
		ifTrue: [ aBlock value ]
		ifFalse: [ self ]
]
