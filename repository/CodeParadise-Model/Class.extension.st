Extension { #name : #Class }

{ #category : #'*CodeParadise-Model' }
Class >> definedPropertyNames [

	<applicationExtension>

	^ self allInstVarNames
]

{ #category : #'*CodeParadise-Model' }
Class >> hasDefinedProperty: aSymbol [

	<applicationExtension>

	(self instVarNames includes: aSymbol)
		ifTrue: [ ^ true ].

	^ self superclass
		ifNotNil: [ :sup | sup hasDefinedProperty: aSymbol ]
		ifNil: [ false ]
]
