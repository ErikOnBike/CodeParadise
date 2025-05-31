Extension { #name : #Symbol }

{ #category : #'*CodeParadise-Canyon-App' }
Symbol >> langText [

	"Answer the language specific text for the receiver"

	<canyonApplicationExtension>

	^ CynPropertyEntity text: self
]

{ #category : #'*CodeParadise-Canyon-App' }
Symbol >> langTextFormat: aDictionaryOrAssociation [

	"Answer the language specific text for the receiver"

	<canyonApplicationExtension>

	^ CynPropertyEntity text: self format: (aDictionaryOrAssociation isDictionary
		ifTrue: [ aDictionaryOrAssociation ]
		ifFalse: [ Dictionary with: aDictionaryOrAssociation ])
]
