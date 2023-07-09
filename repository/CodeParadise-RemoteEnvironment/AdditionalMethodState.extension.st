Extension { #name : #AdditionalMethodState }

{ #category : #'*CodeParadise-RemoteEnvironment' }
AdditionalMethodState >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	self hasNonEmptyProperties
		ifTrue: [ self crTrace: 'WARNING: Methods with properties are currently not supported: ' , method printString ].

	anEncoder encodeAdditionalMethodState: self
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
AdditionalMethodState >> hasNonEmptyProperties [

	^ self properties
		ifNotEmpty: [ :properties | properties anySatisfy: [ :property | property notNil ] ]
		ifEmpty: [ false ]

]
