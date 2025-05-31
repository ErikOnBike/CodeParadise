Extension { #name : #Integer }

{ #category : #'*CodeParadise-Canyon-App' }
Integer >> countText: aSymbol [

	"Answer the language specific cardinal text for the receiver"

	<canyonApplicationExtension>

	^ CynPropertyEntity count: self text: aSymbol
]

{ #category : #'*CodeParadise-Canyon-App' }
Integer >> countText: aSymbol with: aDictionaryOrAssociation [

	"Answer the language specific cardinal text for the receiver"

	<canyonApplicationExtension>

	^ CynPropertyEntity count: self text: aSymbol format: (aDictionaryOrAssociation isDictionary
		ifTrue: [ aDictionaryOrAssociation ]
		ifFalse: [ Dictionary with: aDictionaryOrAssociation ])
]

{ #category : #'*CodeParadise-Canyon-App' }
Integer >> indexText: aSymbol [

	"Answer the language specific ordinal text for the receiver"

	<canyonApplicationExtension>

	^ CynPropertyEntity index: self text: aSymbol
]

{ #category : #'*CodeParadise-Canyon-App' }
Integer >> indexText: aSymbol with: aDictionaryOrAssociation [

	"Answer the language specific ordinal text for the receiver"

	<canyonApplicationExtension>

	^ CynPropertyEntity index: self text: aSymbol format: (aDictionaryOrAssociation isDictionary
		ifTrue: [ aDictionaryOrAssociation ]
		ifFalse: [ Dictionary with: aDictionaryOrAssociation ])
]
