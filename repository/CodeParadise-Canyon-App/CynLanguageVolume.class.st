"
I am a LanguageVolume. I am responsible for providing text (String) values
when looking up text values.

I maintain a collection of TextVariants which store different variants of a
certain text. These variants can be ""regular"", ""cardinal"", ""ordinal"".
I delegate the lookup for the specific variant to the TextVariant matching
the lookup value requested.
The definition does NOT specify which text variant is present. This is a
responsibility of the Dictionary/Volume creator. It is good practice to use
keys which make the distinction clear. Also it is probably good practice to
prepend keys with their usage context to prevent 'key collisions'.

All text variants are identified using a key, which is a Symbol (will be
converted to a Symbol on creation). Using a Symbol to store the text variants
allows to quickly find occurrences using the 'senders' of these Symbols.
Because it is a best practice to use keys with a 'namespace' the Symbols do
become slightly more involved to enter: #'domain.ordinalPerson'. An
alternative is to use underscores as separator and camelCase for multiple
words. The underscore is part of a regular Symbol and does not require escaping
like the dot (.) does.

Example JSON input which is acceptable. The numeric keys are all converted to Integers.
```
{
	""domain.ordinalPerson"": {
		""default"": ""a person"",
		""1"": ""{index}st person"",
		""2"": ""{index}nd person"",
		""-1"": ""last person"",
		""-2"": ""second last person""
	},
	""domain.cardinalThing"": {
		""default"": ""some things"",
		""0"": ""no things"",
		""one"": ""one thing"",
		""other"": ""{count} things""
	}
}
```

For convenience when no ordinal or cardinal differentiation is required and a simple
default text suffices, the following elements are allowed too. They become the value
of the ""default"" key. As can be seen, formatting can still be part of the text.
```
{
	""domain.greeting"": ""Hello world"",
	""domain.label.login"": ""Login"",
	""error.game.attempt"": ""Failed attempt, {1} attempts remaining""
}
```
"
Class {
	#name : #CynLanguageVolume,
	#superclass : #Object,
	#instVars : [
		'textVariants'
	],
	#category : #'CodeParadise-Canyon-App-Language'
}

{ #category : #'instance creation' }
CynLanguageVolume class >> fromDictionary: aDictionary [

	"Answer an instance of the receiver using the specified Dictionary as input"

	^ self new
		addTextVariantsFromDictionary: aDictionary ;
		yourself
]

{ #category : #'instance creation' }
CynLanguageVolume class >> fromString: aString [

	"Answer an instance of the receiver using the specified JSON string as input"

	^ self fromDictionary: (CpJavaScriptJSON parse: aString)
]

{ #category : #adding }
CynLanguageVolume >> addTextVariantsFromDictionary: aDictionary [

	"Add the content of the Dictionary to the receiver.
	All keys are converted to Symbols.
	Assume the values are Dictionaries which can be converted
	to TextVariant instances."

	aDictionary keysAndValuesDo: [ :key :value |
		textVariants
			at: key asSymbol
			put: (CynTextVariant fromDictionary: (value isString
				ifTrue: [ Dictionary with: #default -> value ]
				ifFalse: [ value ])) ]
]

{ #category : #initialization }
CynLanguageVolume >> initialize [

	super initialize.

	textVariants := Dictionary new
]

{ #category : #accessing }
CynLanguageVolume >> lookup: aTextLookup [

	"Lookup the text specified in the receiver's TextVariants and answer it.
	Answer nil if no matching text is found.

	Implementation:
	TextVariants are stored based on a key (Symbol). Within the TextVariant
	the appropriate variant (regular, ordinal, cardinal) is looked up."

	^ (textVariants at: aTextLookup key ifAbsent: [ ^ nil ])
		lookup: aTextLookup
]
