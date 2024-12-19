Class {
	#name : #CpCardinalTextLookup,
	#superclass : #CpTextLookup,
	#instVars : [
		'count'
	],
	#classVars : [
		'PluralRulesCache'
	],
	#category : #'CodeParadise-Canyon-Model-Language'
}

{ #category : #'instance creation' }
CpCardinalTextLookup class >> key: aSymbol [

	self errorNewReplacedBy: #key:count:
]

{ #category : #'instance creation' }
CpCardinalTextLookup class >> key: aSymbol count: anInteger [

	^ self basicNew
		initializeWithKey: aSymbol count: anInteger ;
		yourself
]

{ #category : #'instance creation' }
CpCardinalTextLookup class >> new [

	self errorNewReplacedBy: #key:count:
]

{ #category : #resources }
CpCardinalTextLookup class >> pluralRulesForLocale: aString [

	"Answer an instance of PluralRules for the specified locale and cardinal text"

	PluralRulesCache ifNil: [ PluralRulesCache := Dictionary new ].

	^ PluralRulesCache
		at: aString
		ifAbsentPut: [ CpBrowserPluralRules cardinalLocale: aString ]
]

{ #category : #accessing }
CpCardinalTextLookup >> count [

	^ count
]

{ #category : #accessing }
CpCardinalTextLookup >> inTextVariant: aTextVariant [

	"Answer the text represented by the receiver using the specified TextVariant"

	^ aTextVariant textCount: count pluralForm: self pluralForm
]

{ #category : #initialization }
CpCardinalTextLookup >> initializeWithKey: aSymbol count: anInteger [

	self initializeWithKey: aSymbol.

	count := anInteger
]

{ #category : #accessing }
CpCardinalTextLookup >> pluralForm [

	"Answer the cardinal plural form for the receiver"

	^ (self class pluralRulesForLocale: self locale)
		select: count
]
