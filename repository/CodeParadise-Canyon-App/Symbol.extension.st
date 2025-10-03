Extension { #name : #Symbol }

{ #category : #'*CodeParadise-Canyon-App' }
Symbol >> langCountText: anInteger [

	"Answer the language specific cardinal text for the receiver"

	<canyonApplicationExtension>

	^ CynPropertyEntity count: anInteger text: self
]

{ #category : #'*CodeParadise-Canyon-App' }
Symbol >> langCountText: anInteger format: aDictionaryOrAssociation [

	"Answer the language specific cardinal text for the receiver"

	<canyonApplicationExtension>

	^ CynPropertyEntity count: anInteger text: self format: (aDictionaryOrAssociation isDictionary
		ifTrue: [ aDictionaryOrAssociation ]
		ifFalse: [ Dictionary with: aDictionaryOrAssociation ])
]

{ #category : #'*CodeParadise-Canyon-App' }
Symbol >> langIndexText: anInteger [

	"Answer the language specific ordinal text for the receiver"

	<canyonApplicationExtension>

	^ CynPropertyEntity index: anInteger text: self
]

{ #category : #'*CodeParadise-Canyon-App' }
Symbol >> langIndexText: anInteger format: aDictionaryOrAssociation [

	"Answer the language specific ordinal text for the receiver"

	<canyonApplicationExtension>

	^ CynPropertyEntity index: anInteger text: self format: (aDictionaryOrAssociation isDictionary
		ifTrue: [ aDictionaryOrAssociation ]
		ifFalse: [ Dictionary with: aDictionaryOrAssociation ])
]

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
