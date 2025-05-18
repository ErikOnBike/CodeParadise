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
CynPropertyModel >> labelAt: aSymbol [

	"Answer the label of the specified property"

	^ self textAspect: #label at: aSymbol
]

{ #category : #'*CodeParadise-Canyon-App' }
CynPropertyModel >> labelFor: propertySymbol selection: selectionSymbol [

	"Answer the label for the specified selection of the specified property"

	^ self
		textAspect: #selection
		at: (String streamContents: [ :stream |
			stream
				nextPutAll: propertySymbol ;
				nextPut: $. ;
				nextPutAll: selectionSymbol ]) asSymbol
]

{ #category : #'*CodeParadise-Canyon-App' }
CynPropertyModel class >> shortName [

	"Answer the short name for the receiver.

	This short name is used (among others) in multi language keys."

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

{ #category : #'*CodeParadise-Canyon-App' }
CynPropertyModel class >> textAspect: aString at: aSymbol [

	"Answer the specified text aspect of the specified property.
	Answer nil if such an aspect is missing.

	The text aspect can for example be: 'label', 'placeholder', etc.

	Implementation:
	Since Models can inherit properties from a superclass, perform repeated
	requests on the superclass when no text is found yet."

	| key value |

	"Create key"
	key := (String streamContents: [ :stream |
		stream
			nextPutAll: 'app.' ;
			nextPutAll: aString ;
			nextPut: $. ;
			nextPutAll: self shortName ;
			nextPut: $. ;
			nextPutAll: aSymbol ]) asSymbol.

	"Retrieve value"
	value := self text: key.

	"If no label value is found and not yet at root, try superclass"
	(value = key and: [ self ~~ CynPropertyModel ])
		ifTrue: [ value := self superclass textAspect: aString at: aSymbol ].

	"Answer nil if still not found (i.e. key = value)"
	^ value = key
		ifFalse: [ value ]
]

{ #category : #'*CodeParadise-Canyon-App' }
CynPropertyModel >> textAspect: aString at: aSymbol [

	"Answer the specified text aspect of the specified property.
	Answer nil if such an aspect is missing.

	The text aspect can for example be: 'label', 'placeholder', etc."

	^ self class
		textAspect: aString at: aSymbol
]
