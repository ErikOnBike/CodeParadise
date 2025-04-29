"
I am a TextVariant. I am responsible to maintain and provide variants of a text.
I am aware of regular text and both cardinal and ordinal text.

I will answer a text for a specific cardinality or ordinality if known, but
otherwise fall back to more generic cardinality/ordinality using the plural form
answered by Intl.PluralRules.select. Finally I'll resort to using the default text.

See also:
https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl/PluralRules

Negative ordinal values are meant to represent elements from the end of a
collection. -1 is the last element, -2 the second last elements, etc.
The value 0 should not be used for ordinal values.

I can be instantiated with a Dictionary, typically created from a JSON file.
Since JSON only supports String values for the keys, I will convert any key
'all digits' or a minus and 'all digits' to an Integer for faster access.

Example JSON input which is acceptable. The numeric keys are all converted to Integers.
```
{
	""default"": ""a person"",
	""1"": ""{index}st person"",
	""2"": ""{index}nd person"",
	""-1"": ""last person"",
	""-2"": ""second last person""
}
```

The use of '{count}' or '{index}' is optional. If no such formatting element
is present (like in example above for the negative index), there simply is no
formatting performed on that specific term.
"
Class {
	#name : #CynTextVariant,
	#superclass : #Object,
	#instVars : [
		'texts'
	],
	#category : #'CodeParadise-Canyon-App-Language'
}

{ #category : #'instance creation' }
CynTextVariant class >> fromDictionary: aDictionary [

	"Answer an instance of the receiver using the specified Dictionary as input"

	^ self new
		addTextFromDictionary: aDictionary ;
		yourself
]

{ #category : #'instance creation' }
CynTextVariant class >> fromString: aString [

	"Answer an instance of the receiver using the specified JSON string as input"

	^ self fromDictionary: (CpJavaScriptJSON parse: aString)
]

{ #category : #adding }
CynTextVariant >> addTextFromDictionary: aDictionary [

	"Add the content of the Dictionary to the receiver.
	All keys with a numeric content are converted to integers."

	aDictionary keysAndValuesDo: [ :key :value |
		texts
			at: (key asNumberOrNil
				ifNotNil: [ :index | index ]
				ifNil: [ key ])
			put: value ]
]

{ #category : #initialization }
CynTextVariant >> initialize [

	super initialize.

	texts := Dictionary new
]

{ #category : #accessing }
CynTextVariant >> lookup: aTextLookup [

	^ aTextLookup inTextVariant: self
]

{ #category : #accessing }
CynTextVariant >> text [

	"Answer the default text (no fallback possible, answer nil)"

	^ texts at: #default ifAbsent: [ nil ]
]

{ #category : #accessing }
CynTextVariant >> textCount: anInteger pluralForm: aString [

	"Answer the cardinal text for the specified count using the specified plural form.
	If the specified count and/or plural form is not present, answer the default text."

	"Use specific count match"
	texts at: anInteger ifPresent: [ :text | ^ text ].

	"Use plural form"
	texts at: aString ifPresent: [ :text | ^ text ].

	"Resort to default"
	^ self text
]

{ #category : #accessing }
CynTextVariant >> textIndex: anInteger pluralForm: aString [

	"Answer the ordinal text for the specified index using the specified plural form.
	If the specified index and/or plural form is not present, answer the default text."

	"Use specific index match"
	texts at: anInteger ifPresent: [ :text | ^ text ].

	"Use plural form"
	texts at: aString ifPresent: [ :text | ^ text ].

	"Resort to default"
	^ self text
]
