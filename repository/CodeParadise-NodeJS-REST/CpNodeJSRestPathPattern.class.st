Class {
	#name : #CpNodeJSRestPathPattern,
	#superclass : #CpNodeJSRestPath,
	#instVars : [
		'paramMapping'
	],
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #validating }
CpNodeJSRestPathPattern class >> validatePath: aString [

	"Validate the specified path as REST endpoint"

	| pathSegments |

	aString isNotEmpty
		ifFalse: [ self error: 'REST path should not be empty' ].

	aString first = $/
		ifFalse: [ self error: 'REST path should start with a (forward) slash' ].

	pathSegments := aString findTokens: $/.
	pathSegments isNotEmpty
		ifFalse: [ self error: 'REST path should contain at least one path "segment"' ].

	pathSegments do: [ :each | self validatePathSegment: each ]
]

{ #category : #validating }
CpNodeJSRestPathPattern class >> validatePathSegment: aString [

	"Validate the specified path segment for a REST endpoint.
	Only lower case character, numbers and _ - and $ are allowed.
	A segment my start with a colon to indicate a parameter."

	| validCharacterBlock |

	aString isNotEmpty
		ifFalse: [ self error: 'REST path segments should not be empty' ].

	validCharacterBlock := [ :each |
			| unicode |
			unicode := each asUnicode.
			((unicode between: 97 and: 122)       "between $a asUnicode and $z asUnicode"
			or: [ (unicode between: 48 and: 57)   "between $0 asUnicode and $9 asUnicode"
			or: [ '_-$' includes: each ] ]) "special characters: _ - $"
				ifFalse: [ self error: 'REST path segment contains invalid character ', each asString ] ].

	aString first = $:
		ifTrue: [ aString allButFirst do: [ :each | validCharacterBlock value: each ] ]
		ifFalse: [ aString do: [ :each | validCharacterBlock value: each ] ]
]

{ #category : #testing }
CpNodeJSRestPathPattern >> hasParameterNamed: aString [

	^ paramMapping includesKey: aString
]

{ #category : #initialization }
CpNodeJSRestPathPattern >> initializeFromString: aString [

	super initializeFromString: aString.

	"Create a mapping containing parameter name and position"
	paramMapping := Dictionary new.
	pathSegments withIndexDo: [ :each :index |
		(each beginsWith: ':')
			ifTrue: [
				paramMapping
					at: each allButFirst asSymbol
					ifPresent: [ self error: ('Duplicate parameter {1} in REST path pattern' format: { each allButFirst }) ]
					ifAbsentPut: index ] ]
]

{ #category : #accessing }
CpNodeJSRestPathPattern >> parameterCount [

	"Answer the number of parameters"

	^ paramMapping size
]

{ #category : #accessing }
CpNodeJSRestPathPattern >> parameterNamed: aString fromPath: aPath [

	"Answer the value of the named parameter from the specified path segments (or nil if not available)"

	| paramIndex |

	paramIndex := paramMapping at: aString ifAbsent: [ ^ nil ].

	^ aPath segmentAt: paramIndex
]

{ #category : #accessing }
CpNodeJSRestPathPattern >> parameterNames [

	"Answer the parameter names"

	^ paramMapping keys
]

{ #category : #accessing }
CpNodeJSRestPathPattern >> parametersFromPath: aPath [

	"Answer a Dictionary containing the named parameters of the receiver
	with the respective parameter value from the specified path.
	It is assumed the specified path matches the receiver."

	| parameters |

	parameters := Dictionary new.
	paramMapping keysAndValuesDo: [ :key :index |
		parameters at: key put: (aPath segmentAt: index) ].

	^ parameters
]

{ #category : #accessing }
CpNodeJSRestPathPattern >> pathUsingParameters: aDictionary [

	"Answer a path (String) representing a filled in pattern path"

	^ String streamContents: [ :stream |
		pathSegments do: [ :each |
			stream nextPut: $/.
			(each beginsWith: ':')
				ifTrue: [ stream nextPutAll: (aDictionary at: each allButFirst ifAbsent: [ self error: ('Missing parameter {1} in path {2}' format: { each . self asString }) ]) ]
				ifFalse: [ stream nextPutAll: each ] ] ]
]

{ #category : #printing }
CpNodeJSRestPathPattern >> printOn: aStream [

	super printOn: aStream.

	aStream
		nextPutAll: ', params: ' ;
		print: paramMapping
]

{ #category : #private }
CpNodeJSRestPathPattern >> segmentAt: anInteger matches: aString [

	| segment |
	
	segment := self segmentAt: anInteger.

	^ (segment beginsWith: ':') or: [ segment = aString ]
]
