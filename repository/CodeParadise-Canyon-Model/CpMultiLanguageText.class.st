"
I am a MultiLanguageText component. I am responsible for providing text (String) values
when looking up text values for a specific language (TextLanguage).

I am aware of text that can have an ordinal or cardinal value.
For example text with an index (ordinal text) like:
	'1st person', '2nd person', '3rd person' or
	'first person', 'second person', 'third person'

For example text with a count (cardinal text) like:
	'1 person', '2 persons', '3 persons' or
	'one person', 'two persons', 'three persons'

My text is stored in LanguageDictionary instances. Each Dictionary is specific for a locale.
This means a Dictionary is specific for a language and optionally a region. This allows
region specific text to be supported. 

When looking up text a text language should be provided. This text language defines a locale
and optionally fallback locales. See comment in TextLanguage for more information.

Formatting can be applied to replace text with variable values. These values are all converted
to String using #asString.
When using cardinal or ordinal text, a 'count' or respectively 'index' variable is automatically
added to the formatting (even though it might not be used if the text variant resolves to a
fixed text like 'first person' in which the index is absent).
"
Class {
	#name : #CpMultiLanguageText,
	#superclass : #Object,
	#instVars : [
		'dictionaries',
		'defaultLanguage'
	],
	#category : #'CodeParadise-Canyon-Model-Language'
}

{ #category : #'instance creation' }
CpMultiLanguageText class >> defaultLanguage: aLanguage [

	^ self basicNew
		initializeWithDefaultLanguage: aLanguage ;
		yourself
]

{ #category : #accessing }
CpMultiLanguageText >> addVolume: aVolume locale: aSymbol [

	"Add the specified LanguageVolume to the receiver for the specified Locale"

	^ (dictionaries at: aSymbol ifAbsentPut: [ CpLanguageDictionary new ])
		addVolume: aVolume
]

{ #category : #accessing }
CpMultiLanguageText >> addVolumeFromDictionary: aDictionary locale: aSymbol [

	"Convenience method to add Volumes based on an input Dictionary"

	^ self addVolume: (CpLanguageVolume fromDictionary: aDictionary) locale: aSymbol
]

{ #category : #accessing }
CpMultiLanguageText >> addVolumeFromString: aString locale: aSymbol [

	"Convenience method to add Volumes based on an input String (assume JSON)"

	^ self addVolume: (CpLanguageVolume fromString: aString) locale: aSymbol
]

{ #category : #'accessing - default lang' }
CpMultiLanguageText >> count: anInteger key: aSymbolOrParamText [

	"Answer the specified cardinal text for the default language"

	self validateDefaultLanguage.

	^ self lang: defaultLanguage count: anInteger key: aSymbolOrParamText format: nil
]

{ #category : #'accessing - default lang' }
CpMultiLanguageText >> count: anInteger key: aSymbolOrParamText format: aDictionary [

	"Answer the specified cardinal text for the default language and use the (optional) Dictionary to format the text"

	self validateDefaultLanguage.

	^ self lang: defaultLanguage count: anInteger key: aSymbolOrParamText format: aDictionary
]

{ #category : #private }
CpMultiLanguageText >> formatDict: aDictionary with: anAssociation [

	"Answer a new Dictionary containing the values from the (optional)
	Dictionary specified and the additional Association"

	^ (aDictionary ifNotNil: [ aDictionary copy ] ifNil: [ Dictionary new ])
		add: anAssociation ;
		yourself
]

{ #category : #private }
CpMultiLanguageText >> formatText: aString language: aLanguage using: aDictionary [

	"Answer the specified text in the specified language, formatted using the specified Dictionary"

	^ aString format: (CpTextFormat multiLanguageText: self language: aLanguage format: aDictionary)
]

{ #category : #'accessing - default lang' }
CpMultiLanguageText >> index: anInteger key: aSymbolOrParamText [

	"Answer the specified ordinal text for the default language"

	self validateDefaultLanguage.

	^ self lang: defaultLanguage index: anInteger key: aSymbolOrParamText format: nil
]

{ #category : #'accessing - default lang' }
CpMultiLanguageText >> index: anInteger key: aSymbolOrParamText format: aDictionary [

	"Answer the specified ordinal text for the default language and use the (optional) Dictionary to format the text"

	self validateDefaultLanguage.

	^ self lang: defaultLanguage index: anInteger key: aSymbolOrParamText format: aDictionary
]

{ #category : #initialization }
CpMultiLanguageText >> initialize [

	super initialize.

	dictionaries := Dictionary new
]

{ #category : #initialization }
CpMultiLanguageText >> initializeWithDefaultLanguage: aLanguage [

	self initialize.

	defaultLanguage := aLanguage
]

{ #category : #'accessing - default lang' }
CpMultiLanguageText >> key: aSymbolOrParamText [

	"Answer the specified text for the default language"

	self validateDefaultLanguage.

	^ self lang: defaultLanguage key: aSymbolOrParamText format: nil
]

{ #category : #'accessing - default lang' }
CpMultiLanguageText >> key: aSymbolOrParamText format: aDictionary [

	"Answer the specified text for the default language and use the (optional) Dictionary to format the text"

	self validateDefaultLanguage.

	^ self lang: defaultLanguage key: aSymbolOrParamText format: aDictionary
]

{ #category : #'accessing - specific lang' }
CpMultiLanguageText >> lang: aLanguage count: anInteger key: aSymbolOrParamText [

	"Answer the specified cardinal text for the given language"

	^ self lang: aLanguage count: anInteger key: aSymbolOrParamText format: nil
]

{ #category : #'accessing - specific lang' }
CpMultiLanguageText >> lang: aLanguage count: anInteger key: aSymbolOrParamText format: aDictionary [

	"Answer the specified cardinal text for the given language and use the (optional) Dictionary to format the text.

	Consider using only 0 and positive counts, since for non-developers/non-tech people, '-5 persons' is probably
	not a very valuable text."

	"Unwrap if a ParamText is supplied"
	aSymbolOrParamText isString
		ifFalse: [ ^ self lang: aLanguage count: anInteger key: aSymbolOrParamText key format: (aSymbolOrParamText formatWithAll: aDictionary) ].

	^ (self lang: aLanguage lookup: (CpCardinalTextLookup key: aSymbolOrParamText count: anInteger))
		ifNotNil: [ :text |
			self
				formatText: text
				language: aLanguage
				using: (self formatDict: aDictionary with: #count -> anInteger) ]
]

{ #category : #'accessing - specific lang' }
CpMultiLanguageText >> lang: aLanguage index: anInteger key: aSymbolOrParamText [

	"Answer the specified ordinal text for the given language"

	^ self lang: aLanguage index: anInteger key: aSymbolOrParamText format: nil
]

{ #category : #'accessing - specific lang' }
CpMultiLanguageText >> lang: aLanguage index: anInteger key: aSymbolOrParamText format: aDictionary [

	"Answer the specified ordinal text for the given language and use the (optional) Dictionary to format the text.
	A positive index is referring to the first elements of a collection.
	A negative index is referring to the last elements of a collection.

	For example:
	-1 refers to last element and could resolve to 'last person'.
	-2 refers to second last element and could resolve to 'second last person'.
	... etc.

	The index 0 should not be used (i.e. has no logical meaning)."

	"Unwrap if a ParamText is supplied"
	aSymbolOrParamText isString
		ifFalse: [ ^ self lang: aLanguage index: anInteger key: aSymbolOrParamText key format: (aSymbolOrParamText formatWithAll: aDictionary) ].

	^ (self lang: aLanguage lookup: (CpOrdinalTextLookup key: aSymbolOrParamText index: anInteger))
		ifNotNil: [ :text |
			self
				formatText: text
				language: aLanguage
				using: (self formatDict: aDictionary with: #index -> anInteger) ]
]

{ #category : #'accessing - specific lang' }
CpMultiLanguageText >> lang: aLanguage key: aSymbolOrParamText [

	"Answer the specified text for the given language"

	^ self lang: aLanguage key: aSymbolOrParamText format: nil
]

{ #category : #'accessing - specific lang' }
CpMultiLanguageText >> lang: aLanguage key: aSymbolOrParamText format: aDictionary [

	"Answer the specified text for the given language and use the (optional) Dictionary to format the text"

	"Unwrap if a ParamText is supplied"
	aSymbolOrParamText isString
		ifFalse: [ ^ self lang: aLanguage key: aSymbolOrParamText key format: (aSymbolOrParamText formatWithAll: aDictionary) ].

	^ (self lang: aLanguage lookup: (CpTextLookup key: aSymbolOrParamText))
		ifNotNil: [ :text | self formatText: text language: aLanguage using: aDictionary ]
		ifNil: [ aSymbolOrParamText ]
]

{ #category : #private }
CpMultiLanguageText >> lang: aLanguage lookup: aTextLookup [

	"Answer the specified text for the given language and TextLookup"

	aLanguage locales do: [ :each |

			"Set the locale we're working with"
			aTextLookup locale: each.

			"Perform lookup and answer result if successful"
			(self locale: each lookup: aTextLookup)
				ifNotNil: [ :text | ^ text ] ].

	"Reset lookup locale"
	aTextLookup removeLocale.

	^ nil
]

{ #category : #private }
CpMultiLanguageText >> locale: localeSymbol lookup: aTextLookup [

	^ (dictionaries at: localeSymbol ifAbsent: [ ^ nil ])
		lookup: aTextLookup
]

{ #category : #validating }
CpMultiLanguageText >> validateDefaultLanguage [

	defaultLanguage ifNil: [ self error: 'No default language specified' ]
]
