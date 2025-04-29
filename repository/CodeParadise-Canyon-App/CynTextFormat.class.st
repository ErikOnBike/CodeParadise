"
I am a TextFormat. I am responsible to provide a value when requesting one using a key.
I maintain an optional Dictionary of lookup values. When a key is provided which starts
with a hash (like '#other') AND I don't store a matching value, I will delegate the
lookup to the MultiLanguageText and language I am configured with (using the key without
the hash, i.e. in this case 'other'). This mechanism allows nesting of text variants.

Example JSON input with references (incl. nested) to other entries.

```
{
	""sorry"": ""I'm sorry I don't understand your input, "",
	""error.input.name.missing"": ""{#sorry} the name is missing."",
	""error.input.name.required"": ""{#error.input.name.missing} And I really need it to operate correctly.""
}
```

When the above is used in a LanguageDictionary executing:
```
multiLanguageText key: #'error.input.name.required'
```
will yield:
```
""I'm sorry I don't understand your input, the name is missing. And I really need it to operate correctly.""
```

Regular formatting parameters can also be used and the position of parameters is not limited to the
start (as in the example above).
"
Class {
	#name : #CynTextFormat,
	#superclass : #Object,
	#instVars : [
		'language',
		'format',
		'languageText'
	],
	#category : #'CodeParadise-Canyon-App-Language'
}

{ #category : #'instance creation' }
CynTextFormat class >> multiLanguageText: aMultiLanguageText language: aLanguage format: aDictionary [

	"Answer an instance of the receiver with the specified values.
	The format Dictionary can be nil if no format options are present/needed."

	^ self basicNew
		initializeWithLanguageText: aMultiLanguageText language: aLanguage format: aDictionary ;
		yourself
]

{ #category : #'instance creation' }
CynTextFormat class >> new [

	self errorNewReplacedBy: #multiLanguageText:language:format:
]

{ #category : #accessing }
CynTextFormat >> at: keyObject [

	"Answer the format value for the specified key.

	Implementation:
	The format Dictionary can be nil (i.e. is optional)."

	| result |

	"First retrieve 'local' result"
	result := format ifNotNil: [ format at: keyObject ifAbsent: [ nil ] ].

	result
		ifNotNil: [
			"Not a nice check. Update if subclasses of CpParamText are required or even more generic mechanisms.
			Don't want to pollute the Object class with more #isParamText messages."
			result class == CynTextReference
				ifTrue: [ result := result textUsingLanguageText: languageText lang: language ] ]
		ifNil: [
			"If result is indirect value, perform another lookup"
			(keyObject isString and: [ keyObject beginsWith: '#'])
				ifTrue: [ result := languageText lang: language key: (keyObject allButFirst: 1) asSymbol format: format ] ].

	^ result
]

{ #category : #initialization }
CynTextFormat >> initializeWithLanguageText: aMultiLanguageText language: aLanguage format: aDictionary [

	self initialize.

	languageText := aMultiLanguageText.
	language := aLanguage.
	format := aDictionary
]
