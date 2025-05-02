Extension { #name : #CynPropertyModel }

{ #category : #'*CodeParadise-Canyon-App' }
CynPropertyModel >> errorTextForPropertyAt: aSymbol [

	"Answer an error text for the specified property.
	The error text represents violations the user should 'fix'.
	If no errors are encountered, answer nil."

	| errorTextStream |

	self
		propertyViolationsAt: aSymbol
		do: [ :violation |

			"Add a space as separater between individual error texts"
			 errorTextStream
				ifNotNil: [ errorTextStream space ]
				ifNil: [ errorTextStream := WriteStream on: (String new: 80) ].

			"Add the error text for the current violation"
			errorTextStream nextPutAll: (self errorTextForViolation: violation) ].

	^ errorTextStream ifNotNil: [ errorTextStream contents ]
]

{ #category : #'*CodeParadise-Canyon-App' }
CynPropertyModel >> errorTextForViolation: aSymbolOrTextReference [

	"Answer an error text for the specified violation.
	The violation is represented by a Symbol or a CynTextReference.
	By default, the violation is looked up as text value."

	^ self class
		text: aSymbolOrTextReference
]

{ #category : #'*CodeParadise-Canyon-App' }
CynPropertyModel class >> labelAt: aSymbol [

	"Answer the label of the specified property.

	Implementation:
	Since Models can inherit properties from a superclass, perform repeated
	label requests on the superclass when no label is found yet."

	| labelKey labelValue |

	"Create label key"
	labelKey := (String streamContents: [ :stream |
		stream
			nextPutAll: 'app.label.' ;
			nextPutAll: self modelNameForLabel ;
			nextPut: $. ;
			nextPutAll: aSymbol ]) asSymbol.

	"Retrieve label value"
	labelValue := self text: labelKey.

	"If no label value is found and not yet at root, try superclass"
	(labelValue = labelKey and: [ self ~~ CynPropertyModel ])
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
CynPropertyModel class >> labelFor: propertySymbol selection: selectionSymbol [

	"Answer the label for the specified selection of the specified property.

	Implementation:
	Since Models can inherit properties from a superclass, perform repeated
	label requests on the superclass when no label is found yet."

	| labelKey labelValue |

	"Create label key"
	labelKey := (String streamContents: [ :stream |
		stream
			nextPutAll: 'app.selection.' ;
			nextPutAll: self modelNameForLabel ;
			nextPut: $. ;
			nextPutAll: propertySymbol ;
			nextPut: $. ;
			nextPutAll: selectionSymbol ]) asSymbol.

	"Retrieve label value"
	labelValue := self text: labelKey.

	"If no label value is found and not yet at root, try superclass"
	(labelValue = labelKey and: [ self ~~ CynPropertyEntity ])
		ifTrue: [ labelValue := self superclass labelFor: propertySymbol selection: selectionSymbol ].

	^ labelValue
]

{ #category : #'*CodeParadise-Canyon-App' }
CynPropertyModel >> labelFor: propertySymbol selection: selectionSymbol [

	"Answer the label for the specified selection of the specified property"

	^ self class
		labelFor: propertySymbol selection: selectionSymbol
]

{ #category : #'*CodeParadise-Canyon-App' }
CynPropertyModel class >> modelNameForLabel [

	"Answer the name of the model.
	This is used when creating keys for labels (see #labelAt: and #labelFor:selection:)"

	^ self nameWithoutPrefix uncapitalized
]

{ #category : #'*CodeParadise-Canyon-App' }
CynPropertyModel class >> text: aSymbol [

	"Answer the text for the specified Symbol.

	Implementation:
	Subclasses should override this.
	For now it simply answers the Symbol."

	^ aSymbol
]
