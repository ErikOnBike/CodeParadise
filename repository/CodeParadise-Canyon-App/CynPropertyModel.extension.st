Extension { #name : #CynPropertyModel }

{ #category : #'*CodeParadise-Canyon-App' }
CynPropertyModel class >> labelAt: aSymbol [

	"Answer the label of the specified property"

	| labelKey labelValue |

	"Create label key"
	labelKey := (String streamContents: [ :stream |
		stream
			nextPutAll: 'app.label.' ;
			nextPutAll: (self nameWithoutPrefix withoutPrefix: #Canyon) uncapitalized ;
			nextPut: $. ;
			nextPutAll: aSymbol ]) asSymbol.

	"Retrieve label value"
	labelValue := self text: labelKey.

	"If no label value is found and not yet at root, try superclass"
	(labelValue == labelKey and: [ self ~~ CynPropertyModel ])
		ifTrue: [ labelValue := self superclass labelAt: aSymbol ].

	^ labelValue
]

{ #category : #'*CodeParadise-Canyon-App' }
CynPropertyModel >> labelAt: aSymbol [

	"Answer the label of the specified property"

	^ self class
		labelAt: aSymbol
]

{ #category : #'*CodeParadise-Canyon-App' }
CynPropertyModel class >> text: aSymbol [

	"Answer the text for the specified Symbol.

	Implementation:
	Subclasses should override this.
	For now it simply answers the Symbol."

	^ aSymbol
]
