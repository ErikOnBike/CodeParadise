Class {
	#name : #CpOrdinalTextLookup,
	#superclass : #CpTextLookup,
	#instVars : [
		'index'
	],
	#classVars : [
		'PluralRulesCache'
	],
	#category : #'CodeParadise-Canyon-Model-Language'
}

{ #category : #'instance creation' }
CpOrdinalTextLookup class >> key: aSymbol [

	self errorNewReplacedBy: #key:index:
]

{ #category : #'instance creation' }
CpOrdinalTextLookup class >> key: aSymbol index: anInteger [

	^ self basicNew
		initializeWithKey: aSymbol index: anInteger ;
		yourself
]

{ #category : #'instance creation' }
CpOrdinalTextLookup class >> new [

	self errorNewReplacedBy: #key:index:
]

{ #category : #resources }
CpOrdinalTextLookup class >> pluralRulesForLocale: aString [

	"Answer an instance of PluralRules for the specified locale and ordinal text"

	PluralRulesCache ifNil: [ PluralRulesCache := Dictionary new ].

	^ PluralRulesCache
		at: aString
		ifAbsentPut: [ CpBrowserPluralRules ordinalLocale: aString ]
]

{ #category : #accessing }
CpOrdinalTextLookup >> inTextVariant: aTextVariant [

	"Answer the text represented by the receiver using the specified TextVariant"

	^ aTextVariant textIndex: index pluralForm: self pluralForm
]

{ #category : #accessing }
CpOrdinalTextLookup >> index [

	^ index
]

{ #category : #initialization }
CpOrdinalTextLookup >> initializeWithKey: aSymbol index: anInteger [

	self initializeWithKey: aSymbol.

	index := anInteger
]

{ #category : #accessing }
CpOrdinalTextLookup >> pluralForm [

	"Answer the ordinal plural form for the receiver"

	^ (self class pluralRulesForLocale: self locale)
		select: index
]
