Extension { #name : #AdditionalMethodState }

{ #category : #'*CodeParadise-RemoteEnvironment' }
AdditionalMethodState >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	self hasNonEmptyProperties
		ifTrue: [ self error: 'Methods with properties are currently not supported' ].

	anEncoder encodeAdditionalMethodState: self
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
AdditionalMethodState >> hasNonEmptyProperties [

	^ self properties
		ifNotEmpty: [ :properties | properties anySatisfy: [ :property | property notNil ] ]
		ifEmpty: [ false ]

]
