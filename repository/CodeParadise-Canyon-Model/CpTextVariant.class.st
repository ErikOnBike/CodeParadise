"
I am a TextVariant. I am responsible to maintain and provide variants of a text.
I am aware of regular text and both cardinal and ordinal text.

I will answer a text for a specific cardinality or ordinality if known, but
otherwise fall back to more generic cardinality/ordinality using the plural form
answered by Intl.PluralRules.select. Finally I'll resort to using the default text.

Negative ordinal values are meant to represent elements from the end of a
collection. -1 is the last element, -2 the second last elements, etc.
The value 0 should not be used for ordinal values.

I can be instantiated with a Dictionary, typically created from a JSON file.
Since JSON only supports String values for the keys, I will convert any key
'all digits' or a minus and 'all digits' to an Integer for faster access.

Example JSON input which is acceptable. The numeric keys are all converted to Integers.
'{
	""default"": ""a person"",
	""1"": ""{index}st person"",
	""2"": ""{index}nd persons"",
	""-1"": ""last person"",
	""-2"": ""second last person""
}'

The use of '{count}' or '{index}' is optional. If no such formatting element
is present (like in example above for the negative index), there simply is no
formatting performed on that specific term.
"
Class {
	#name : #CpTextVariant,
	#superclass : #Object,
	#instVars : [
		'texts'
	],
	#category : #'CodeParadise-Canyon-Model-Language'
}

{ #category : #initialization }
CpTextVariant >> initialize [

	super initialize.

	texts := Dictionary new
]

{ #category : #accessing }
CpTextVariant >> lookup: aTextLookup [

	^ aTextLookup inTextVariant: self
]

{ #category : #accessing }
CpTextVariant >> text [

	"Answer the default text (no fallback possible, answer nil)"

	^ texts at: #default ifAbsent: [ nil ]
]

{ #category : #accessing }
CpTextVariant >> textCount: anInteger pluralForm: aString [

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
CpTextVariant >> textIndex: anInteger pluralForm: aString [

	"Answer the ordinal text for the specified index using the specified plural form.
	If the specified index and/or plural form is not present, answer the default text."

	"Use specific index match"
	texts at: anInteger ifPresent: [ :text | ^ text ].

	"Use plural form"
	texts at: aString ifPresent: [ :text | ^ text ].

	"Resort to default"
	^ self text
]
