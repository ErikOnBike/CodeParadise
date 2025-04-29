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
	#name : #CynMultiLanguageText,
	#superclass : #Object,
	#instVars : [
		'dictionaries',
		'defaultLanguage'
	],
	#category : #'CodeParadise-Canyon-App-Language'
}

{ #category : #'instance creation' }
CynMultiLanguageText class >> defaultLanguage: aLanguage [

	^ self basicNew
		initializeWithDefaultLanguage: aLanguage ;
		yourself
]

{ #category : #accessing }
CynMultiLanguageText >> addVolume: aVolume locale: aSymbol [

	"Add the specified LanguageVolume to the receiver for the specified Locale"

	^ (dictionaries at: aSymbol ifAbsentPut: [ CynLanguageDictionary new ])
		addVolume: aVolume
]

{ #category : #accessing }
CynMultiLanguageText >> addVolumeFromDictionary: aDictionary locale: aSymbol [

	"Convenience method to add Volumes based on an input Dictionary"

	^ self addVolume: (CynLanguageVolume fromDictionary: aDictionary) locale: aSymbol
]

{ #category : #accessing }
CynMultiLanguageText >> addVolumeFromString: aString locale: aSymbol [

	"Convenience method to add Volumes based on an input String (assume JSON)"

	^ self addVolume: (CynLanguageVolume fromString: aString) locale: aSymbol
]

{ #category : #'accessing - default lang' }
CynMultiLanguageText >> count: anInteger key: aSymbolOrTextReference [

	"Answer the specified cardinal text for the default language"

	self validateDefaultLanguage.

	^ self lang: defaultLanguage count: anInteger key: aSymbolOrTextReference format: nil
]

{ #category : #'accessing - default lang' }
CynMultiLanguageText >> count: anInteger key: aSymbolOrTextReference format: aDictionary [

	"Answer the specified cardinal text for the default language and use the (optional) Dictionary to format the text"

	self validateDefaultLanguage.

	^ self lang: defaultLanguage count: anInteger key: aSymbolOrTextReference format: aDictionary
]

{ #category : #private }
CynMultiLanguageText >> formatDict: aDictionary with: anAssociation lang: aLanguage key: aSymbolOrTextReference [

	"Answer a new formatting Dictionary containing the values from the ParamText (if applicable),
	from the (optional) Dictionary specified and from the (optional) Association.
	Any ParamTexts in the specified key are resolved to a text using the specified Language.
	IF no formatting Dictionary is needed (i.e. is empty), answer nil."

	| baseDictionary |

	(aDictionary isNil and: [ anAssociation isNil and: [ aSymbolOrTextReference isString or: [ aSymbolOrTextReference hasEmptyFormat ] ] ])
		ifTrue: [ ^ nil ].

	baseDictionary := aSymbolOrTextReference isString
		ifTrue: [
			aDictionary
				ifNotNil: [ aDictionary copy ]
				ifNil: [ Dictionary new ] ]
		ifFalse: [ aSymbolOrTextReference formatWithAll: aDictionary ].

	anAssociation ifNotNil: [
		baseDictionary add: anAssociation ].

	^ baseDictionary ifEmpty: [ nil ]
]

{ #category : #private }
CynMultiLanguageText >> formatText: aString language: aLanguage using: aDictionary [

	"Answer the specified text in the specified language, formatted using the specified Dictionary"

	aDictionary ifNil: [ ^ aString ].

	^ aString format: (CynTextFormat multiLanguageText: self language: aLanguage format: aDictionary)
]

{ #category : #'accessing - default lang' }
CynMultiLanguageText >> index: anInteger key: aSymbolOrTextReference [

	"Answer the specified ordinal text for the default language"

	self validateDefaultLanguage.

	^ self lang: defaultLanguage index: anInteger key: aSymbolOrTextReference format: nil
]

{ #category : #'accessing - default lang' }
CynMultiLanguageText >> index: anInteger key: aSymbolOrTextReference format: aDictionary [

	"Answer the specified ordinal text for the default language and use the (optional) Dictionary to format the text"

	self validateDefaultLanguage.

	^ self lang: defaultLanguage index: anInteger key: aSymbolOrTextReference format: aDictionary
]

{ #category : #initialization }
CynMultiLanguageText >> initialize [

	super initialize.

	dictionaries := Dictionary new
]

{ #category : #initialization }
CynMultiLanguageText >> initializeWithDefaultLanguage: aLanguage [

	self initialize.

	defaultLanguage := aLanguage
]

{ #category : #'accessing - default lang' }
CynMultiLanguageText >> key: aSymbolOrTextReference [

	"Answer the specified text for the default language"

	self validateDefaultLanguage.

	^ self lang: defaultLanguage key: aSymbolOrTextReference format: nil
]

{ #category : #'accessing - default lang' }
CynMultiLanguageText >> key: aSymbolOrTextReference format: aDictionary [

	"Answer the specified text for the default language and use the (optional) Dictionary to format the text"

	self validateDefaultLanguage.

	^ self lang: defaultLanguage key: aSymbolOrTextReference format: aDictionary
]

{ #category : #'accessing - specific lang' }
CynMultiLanguageText >> lang: aLanguage count: anInteger key: aSymbolOrTextReference [

	"Answer the specified cardinal text for the given language"

	^ self lang: aLanguage count: anInteger key: aSymbolOrTextReference format: nil
]

{ #category : #'accessing - specific lang' }
CynMultiLanguageText >> lang: aLanguage count: anInteger key: aSymbolOrTextReference format: aDictionary [

	"Answer the specified cardinal text for the given language and use the (optional) Dictionary to format the text.

	Consider using only 0 and positive counts, since for non-developers/non-tech people, '-5 persons' is probably
	not a very valuable text."

	| count |

	count := #count -> anInteger.

	^ (self lang: aLanguage lookup: (CynCardinalTextLookup key: aSymbolOrTextReference textKey count: anInteger))
		ifNotNil: [ :text |
			self
				formatText: text
				language: aLanguage
				using: (self formatDict: aDictionary with: count lang: aLanguage key: aSymbolOrTextReference) ]
		ifNil: [ self missingText: aSymbolOrTextReference formatDict: aDictionary with: count lang: aLanguage ]
]

{ #category : #'accessing - specific lang' }
CynMultiLanguageText >> lang: aLanguage index: anInteger key: aSymbolOrTextReference [

	"Answer the specified ordinal text for the given language"

	^ self lang: aLanguage index: anInteger key: aSymbolOrTextReference format: nil
]

{ #category : #'accessing - specific lang' }
CynMultiLanguageText >> lang: aLanguage index: anInteger key: aSymbolOrTextReference format: aDictionary [

	"Answer the specified ordinal text for the given language and use the (optional) Dictionary to format the text.
	A positive index is referring to the first elements of a collection.
	A negative index is referring to the last elements of a collection.

	For example:
	-1 refers to last element and could resolve to 'last person'.
	-2 refers to second last element and could resolve to 'second last person'.
	... etc.

	The index 0 should not be used (i.e. has no logical meaning)."

	| index |

	index := #index -> anInteger.

	^ (self lang: aLanguage lookup: (CynOrdinalTextLookup key: aSymbolOrTextReference textKey index: anInteger))
		ifNotNil: [ :text |
			self
				formatText: text
				language: aLanguage
				using: (self formatDict: aDictionary with: index lang: aLanguage key: aSymbolOrTextReference) ]
		ifNil: [ self missingText: aSymbolOrTextReference formatDict: aDictionary with: index lang: aLanguage ]
]

{ #category : #'accessing - specific lang' }
CynMultiLanguageText >> lang: aLanguage key: aSymbolOrTextReference [

	"Answer the specified text for the given language"

	^ self lang: aLanguage key: aSymbolOrTextReference format: nil
]

{ #category : #'accessing - specific lang' }
CynMultiLanguageText >> lang: aLanguage key: aSymbolOrTextReference format: aDictionary [

	"Answer the specified text for the given language and use the (optional) Dictionary to format the text"

	^ (self lang: aLanguage lookup: (CynTextLookup key: aSymbolOrTextReference textKey))
		ifNotNil: [ :text |
			self
				formatText: text
				language: aLanguage
				using: (self formatDict: aDictionary with: nil lang: aLanguage key: aSymbolOrTextReference) ]
		ifNil: [ self missingText: aSymbolOrTextReference formatDict: aDictionary with: nil lang: aLanguage ]
]

{ #category : #private }
CynMultiLanguageText >> lang: aLanguage lookup: aTextLookup [

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
CynMultiLanguageText >> locale: localeSymbol lookup: aTextLookup [

	^ (dictionaries at: localeSymbol ifAbsent: [ ^ nil ])
		lookup: aTextLookup
]

{ #category : #private }
CynMultiLanguageText >> missingText: aSymbolOrTextReference formatDict: aDictionary with: anAssocation lang: aLanguage [

	^ String streamContents: [ :stream |
		aSymbolOrTextReference isString
			ifTrue: [ stream nextPutAll: aSymbolOrTextReference ]
			ifFalse: [ stream print: aSymbolOrTextReference ].
		aDictionary isEmptyOrNil
			ifFalse: [
				| first |
				stream nextPut: $[.
				first := true.
				aDictionary keysAndValuesDo: [ :key :value |
					first
						ifTrue: [ first := false ]
						ifFalse: [ stream nextPut: $, ].
					stream
						nextPutAll: key ;
						nextPut: $= ;
						print: value ].
				stream nextPut: $] ].
		anAssocation ifNotNil: [
			stream
				nextPut: $: ;
				print: anAssocation ] ]
]

{ #category : #validating }
CynMultiLanguageText >> validateDefaultLanguage [

	defaultLanguage ifNil: [ self error: 'No default language specified' ]
]
