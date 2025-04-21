Extension { #name : #CpPropertyModel }

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyModel class >> labelAt: aSymbol [

	"Answer the label of the specified property"

	| labelKey labelValue |

	"Create label key"
	labelKey := String streamContents: [ :stream |
		stream
			nextPutAll: 'app.label.' ;
			nextPutAll: self nameWithoutPrefix uncapitalized ;
			nextPut: $. ;
			nextPutAll: aSymbol ].

	"Retrieve label value"
	labelValue := CpPropertyEntity text: labelKey.

	"If no label value is found and not yet at root, try superclass"
	(labelValue isNil and: [ self ~~ CpPropertyModel ])
		ifTrue: [ labelValue := self superclass labelAt: aSymbol ].

	^ labelValue
]

{ #category : #'*CodeParadise-Canyon-App' }
CpPropertyModel >> labelAt: aSymbol [

	"Answer the label of the specified property"

	^ self class
		labelAt: aSymbol
]
