Extension { #name : #Symbol }

{ #category : #'*CodeParadise-Canyon-App' }
Symbol >> langText [

	"Answer the language specific text for the receiver"

	<canyonApplicationExtension>

	^ CynPropertyEntity text: self
]

{ #category : #'*CodeParadise-Canyon-App' }
Symbol >> langTextWith: aDictionaryOrAssociation [

	"Answer the language specific text for the receiver"

	<canyonApplicationExtension>

	^ CynPropertyEntity text: self format: (aDictionaryOrAssociation class = Association
		ifTrue: [ Dictionary with: aDictionaryOrAssociation ]
		ifFalse: [ aDictionaryOrAssociation ])
]
