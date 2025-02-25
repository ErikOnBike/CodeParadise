"
I am a LanguageVolume. I am responsible for providing text (String) values
when looking up text values.

I maintain a collection of TextVariants which store different variants of a
certain text. These variants can be ""regular"", ""cardinal"", ""ordinal"".
I delegate the lookup for the specific variant to the TextVariant matching
the lookup value requested.
The definition does NOT specify which text variant is present. This is a
responsibility of the Dictionary/Volume creator. It is good practice to use
keys which make the distinction clear.

All text variants are identified using a key, which is a Symbol (will be
converted to a Symbol on creation).

Example JSON input which is acceptable. The numeric keys are all converted to Integers.
```
{
	""ordinalPerson"": {
		""default"": ""a person"",
		""1"": ""{index}st person"",
		""2"": ""{index}nd person"",
		""-1"": ""last person"",
		""-2"": ""second last person""
	},
	""cardinalThing"": {
		""default"": ""some things"",
		""0"": ""no things"",
		""one"": ""one thing"",
		""other"": ""{count} things""
	}
}
```

"
Class {
	#name : #CpLanguageVolume,
	#superclass : #Object,
	#instVars : [
		'textVariants'
	],
	#category : #'CodeParadise-Canyon-Model-Language'
}

{ #category : #'instance creation' }
CpLanguageVolume class >> fromDictionary: aDictionary [

	"Answer an instance of the receiver using the specified Dictionary as input"

	^ self new
		addTextVariantsFromDictionary: aDictionary ;
		yourself
]

{ #category : #'instance creation' }
CpLanguageVolume class >> fromString: aString [

	"Answer an instance of the receiver using the specified JSON string as input"

	^ self fromDictionary: (CpJavaScriptJSON parse: aString)
]

{ #category : #adding }
CpLanguageVolume >> addTextVariantsFromDictionary: aDictionary [

	"Add the content of the Dictionary to the receiver.
	All keys are converted to Symbols.
	Assume the values are Dictionaries which can be converted
	to TextVariant instances."

	aDictionary keysAndValuesDo: [ :key :value |
		textVariants
			at: key asSymbol
			put: (CpTextVariant fromDictionary: value) ]
]

{ #category : #initialization }
CpLanguageVolume >> initialize [

	super initialize.

	textVariants := Dictionary new
]

{ #category : #accessing }
CpLanguageVolume >> lookup: aTextLookup [

	"Lookup the text specified in the receiver's TextVariants and answer it.
	Answer nil if no matching text is found.

	Implementation:
	TextVariants are stored based on a key (Symbol). Within the TextVariant
	the appropriate variant (regular, ordinal, cardinal) is looked up."

	^ (textVariants at: aTextLookup key ifAbsent: [ ^ nil ])
		lookup: aTextLookup
]
