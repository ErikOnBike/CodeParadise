Class {
	#name : #CpWaInterfaceProperty,
	#superclass : #Object,
	#instVars : [
		'name',
		'typeDescription',
		'defaultValue',
		'description',
		'readonly',
		'instanceSide'
	],
	#category : #'CodeParadise-WebApplication-WebAwesome-Support'
}

{ #category : #accessing }
CpWaInterfaceProperty >> allowedValues [

	"Answer a Collection of allowed values for the receiver.
	Values can either be actual Object instances, but can also be a Smalltalk
	class which is sometimes used in combination with a String value.
	See WaNumberInput >> #step."

	^ CpWaInterfaceInstaller allowedValuesFromTypeDescription: typeDescription
]

{ #category : #accessing }
CpWaInterfaceProperty >> argumentName [

	| typeName |

	typeName := self typeName.

	^ ((typeName first isVowel or: [ typeName beginsWith: #Html ])
		ifTrue: [ 'an' ]
		ifFalse: [ 'a' ]), typeName
]

{ #category : #testing }
CpWaInterfaceProperty >> booleanConvenienceVariantsSourceCode [

	"Answer the source code for a #beXyz and #beNotXyz method"

	| trueSelector falseSelector |

	trueSelector := ('be', self name capitalized) asSymbol.
	falseSelector := (String streamContents: [ :stream |
		stream nextPutAll: 'be'.
		self nameStartsWithWith
			ifTrue: [ stream nextPutAll: 'Without' ; nextPutAll: (self name allButFirst: 4) capitalized ]
			ifFalse: [
				self nameStartsWithWithout
					ifTrue: [ stream nextPutAll: 'With' ; nextPutAll: (self name allButFirst: 7) capitalized ]
					ifFalse: [ stream nextPutAll: 'Not' ; nextPutAll: self name capitalized ] ] ]) asSymbol.

	^ Dictionary new
		add: trueSelector -> (String streamContents: [ :stream |
			stream
				nextPutAll: trueSelector ; cr ;
				cr ;
				tab ; nextPut: $" ; nextPutAll: self convenienceMethodComment ; nextPut: $" ; cr ;
				cr ;
				tab ; nextPutAll: 'self ' ; nextPutAll: self name ; nextPutAll: ': true' ]) ;
		add: falseSelector -> (String streamContents: [ :stream |
			stream
				nextPutAll: falseSelector ; cr ;
				cr ;
				tab ; nextPut: $" ; nextPutAll: self convenienceMethodComment ; nextPut: $" ; cr ;
				cr ;
				tab ; nextPutAll: 'self ' ; nextPutAll: self name ; nextPutAll: ': false' ]) ;
		yourself
]

{ #category : #accessing }
CpWaInterfaceProperty >> comment [

	"Answer the comment for the receiver"

	^ String streamContents: [ :stream |
		stream
			nextPutAll: description trimmed ; cr ;
			cr ;
			nextPutAll: 'Type: ' ; nextPutAll: self typeName ; nextPutAll: (self typeDescriptionComment ifNotNil: [ :typeDescriptionComment | ' (', typeDescriptionComment, ')' ] ifNil: [ '' ]); cr.
		self defaultValue ifNotNil: [
			stream nextPutAll: 'Default: ' ; nextPutAll: self defaultValue printString ; cr ].
		self allowedValues ifNotNil: [
			stream nextPutAll: 'Allowed: ' ; nextPutAll: (' | ' join: (self allowedValues collect: [ :each | each printString ])) ; cr ].
		self readonly ifTrue: [
			stream nextPutAll: 'Read-only: true' ] ]
]

{ #category : #accessing }
CpWaInterfaceProperty >> convenienceMethodComment [

	^ 'This is a convenience method to prevent having to provide arguments to a genric setter method'
]

{ #category : #testing }
CpWaInterfaceProperty >> convenienceVariantsSourceCode [

	"Answer a Dictionary of source code strings for each convenience variant of the receiver.
	Keys are the selectors and values the source code."

	| typeName |

	typeName := self typeName.

	typeName = #Boolean
		ifTrue: [ ^ self booleanConvenienceVariantsSourceCode ].

	"Some special style elements"
	(typeName = #String and: [ self allowedValues isNotNil and: [ #(appearance variant size) includes: self name ] ])
		ifTrue: [ ^ self stringConvenienceVariantsSourceCode ].

	^ Dictionary new
]

{ #category : #accessing }
CpWaInterfaceProperty >> defaultValue [

	^ defaultValue
]

{ #category : #accessing }
CpWaInterfaceProperty >> defaultValue: anObject [

	defaultValue := anObject
]

{ #category : #accessing }
CpWaInterfaceProperty >> description [

	^ description
]

{ #category : #accessing }
CpWaInterfaceProperty >> description: aString [

	description := aString
]

{ #category : #accessing }
CpWaInterfaceProperty >> getterSource [

	"Answer the source code for the getter"

	^ String streamContents: [ :stream |
		stream
			nextPutAll: name ; cr ;
			cr ;
			nextPutAll: (CpWaInterfaceInstaller generateComment: self comment indent: 1) ; cr ;
			cr ;
			tab.
		self isTypeBlock
			ifTrue: [ stream nextPutAll: '^ (self propertyAt: #' ; nextPutAll: name ; nextPutAll: ') ifNotNil: [ :function | function asBlock ifNil: [ function ] ]' ]
			ifFalse: [ stream nextPutAll: '^ self propertyAt: #' ; nextPutAll: name ] ]
]

{ #category : #testing }
CpWaInterfaceProperty >> hasConvenienceVariants [

	| typeName |

	typeName := self typeName.

	typeName = #Boolean
		ifTrue: [ ^ true ].

	"Some special style elements"
	(typeName = #String and: [ #(appearance variant size) includes: self name ])
		ifTrue: [ ^ true ].

	^ false
]

{ #category : #actions }
CpWaInterfaceProperty >> installMethodsIn: aClass [

	CpWaInterfaceInstaller
		installMethodSource:  self getterSource
		selector: self name
		protocol: 'accessing'
		in: aClass.

	self setterSource ifNotNil: [ :source |
		CpWaInterfaceInstaller
			installMethodSource:  source
			selector: self name, ':'
			protocol: 'accessing'
			in: aClass ].

	self convenienceVariantsSourceCode keysAndValuesDo: [ :selector :source |
		CpWaInterfaceInstaller
			installMethodSource: source
			selector: selector
			protocol: 'convenience'
			in: aClass ]
]

{ #category : #accessing }
CpWaInterfaceProperty >> instanceSide [

	^ instanceSide
]

{ #category : #accessing }
CpWaInterfaceProperty >> instanceSide: aBoolean [

	instanceSide := aBoolean
]

{ #category : #testing }
CpWaInterfaceProperty >> isTypeBlock [

	"Answer whether the property is of type Block (i.e. TS function)"

	^ self typeName = #Block
]

{ #category : #accessing }
CpWaInterfaceProperty >> name [

	^ name
]

{ #category : #accessing }
CpWaInterfaceProperty >> name: aString [

	name := aString
]

{ #category : #testing }
CpWaInterfaceProperty >> nameStartsWith: aString [

	"Answer if the receiver's name start with the specified prefix
	AND has an uppercase character following it.

	This allows checking for names like 'withValue' and 'withoutValue'
	although both have the same prefix 'with'."

	^ (self name beginsWith: aString)
		and: [ self name size > aString size
			and: [ (self name at: aString size + 1) isUppercase ] ]
]

{ #category : #testing }
CpWaInterfaceProperty >> nameStartsWithWith [

	^ self nameStartsWith: 'with'
]

{ #category : #testing }
CpWaInterfaceProperty >> nameStartsWithWithout [

	^ self nameStartsWith: 'without'
]

{ #category : #accessing }
CpWaInterfaceProperty >> readonly [

	^ readonly
]

{ #category : #accessing }
CpWaInterfaceProperty >> readonly: aBoolean [

	readonly := aBoolean
]

{ #category : #accessing }
CpWaInterfaceProperty >> setterSource [

	"Answer the source code for the setter (or nil if the receiver is readonly)"

	^ readonly
		ifFalse: [
			| argumentName |
			argumentName := self argumentName.
			String streamContents: [ :stream |
				stream
					nextPutAll: name ; nextPutAll: ': ' ; nextPutAll: argumentName ; cr ;
					cr ;
					nextPutAll: (CpWaInterfaceInstaller generateComment: self comment indent: 1) ; cr ;
					cr ;
					tab ; nextPutAll: 'self propertyAt: #' ; nextPutAll: name ; nextPutAll: ' put: ' ; nextPutAll: argumentName ; nextPutAll: (self isTypeBlock ifTrue: [ ' asJavaScriptFunction' ] ifFalse: [ '' ]) ] ]
]

{ #category : #testing }
CpWaInterfaceProperty >> stringConvenienceVariantsSourceCode [

	"Answer the source code for a #beAbc and #beDef methods (depending on allowed values).
	A Dictionary is answered with selector as key and source code as value."

	^ (self allowedValues collect: [ :each |

		| selector source |
		selector := (String streamContents: [ :stream |
			stream nextPutAll: 'be'.
			each size <= 2
				ifTrue: [ stream nextPutAll: self name capitalized ].
			stream nextPutAll: (self unkebabCase: each initialUppercase: true) ]) asSymbol.

		source := String streamContents: [ :stream |
			stream
				nextPutAll: selector ; cr ;
				cr ;
				tab ; nextPut: $" ; nextPutAll: self convenienceMethodComment ; nextPut: $" ; cr ;
				cr ;
				tab ; nextPutAll: 'self ' ; nextPutAll: self name ; nextPutAll: ': ' ; print: each asSymbol ].
		
		selector -> source ]) asDictionary
]

{ #category : #accessing }
CpWaInterfaceProperty >> typeDescription [

	^ typeDescription
]

{ #category : #accessing }
CpWaInterfaceProperty >> typeDescription: aString [

	typeDescription := aString
]

{ #category : #accessing }
CpWaInterfaceProperty >> typeDescriptionComment [

	"Answer a piece of comment for the type description, only if it is non-standard.

	Implementation:
	Ignore 'simple' types like string/number/date/boolean and string literals and the undefined/null values."

	(typeDescription includesSubstring: '=>')
		ifTrue: [ ^ typeDescription ].

	(typeDescription includesSubstring: '[]')
		ifTrue: [ ^ typeDescription ].

	^ (((typeDescription substrings: '|')
		collect: [ :each | each trimmed ])
			reject: [ :each | (#(undefined null string number Date boolean Object HTMLElement) includes: each) or: [ each first = $' and: [ each last = $' ] ] ])
				ifNotEmpty: [ typeDescription ]
				ifEmpty: [ nil ]
]

{ #category : #accessing }
CpWaInterfaceProperty >> typeName [

	"Answer a Smalltalk class name (or combined name like 'NumberOrString') representing
	the type of the receiver.

	Implementation:
	Special case where a type definition is some WebAwesome internal (enumeration) type
	and therefore the resulting Smalltalk type name is 'Object', but the default value
	is a String, then answer 'String' as type name (instead of 'Object')."

	"Special situation where a TS function is involved (because it can have multiple |'s making,
	parsing difficult, but we know a property has a single value)"
	(CpWaInterfaceInstaller typeStringContainsFunction: self typeDescription)
		ifTrue: [ ^ #Block ].

	^ (CpWaInterfaceInstaller typeNameFromTypeDescription: typeDescription) ifNotNil: [ :typeName |
		(typeName = #Object and: [ self defaultValue isString ])
			ifTrue: [ #String ]
			ifFalse: [ typeName ] ]
]

{ #category : #accessing }
CpWaInterfaceProperty >> unkebabCase: aString initialUppercase: aBoolean [

	"Replace kebab-case with kebabCase"

	| nextUpper |

	nextUpper := aBoolean.

	^ String streamContents: [ :stream |
		aString do: [ :each |
			nextUpper
				ifTrue: [
					stream nextPut: each asUppercase.
					nextUpper := false ]
				ifFalse: [
					each = $-
						ifTrue: [ nextUpper := true ]
						ifFalse: [ stream nextPut: each ] ] ] ]
]
