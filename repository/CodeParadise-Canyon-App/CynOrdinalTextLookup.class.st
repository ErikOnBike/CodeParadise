Class {
	#name : #CynOrdinalTextLookup,
	#superclass : #CynTextLookup,
	#instVars : [
		'index'
	],
	#classVars : [
		'PluralRulesCache'
	],
	#category : #'CodeParadise-Canyon-App-Language'
}

{ #category : #'instance creation' }
CynOrdinalTextLookup class >> key: aSymbol [

	self errorNewReplacedBy: #key:index:
]

{ #category : #'instance creation' }
CynOrdinalTextLookup class >> key: aSymbol index: anInteger [

	^ self basicNew
		initializeWithKey: aSymbol index: anInteger ;
		yourself
]

{ #category : #'instance creation' }
CynOrdinalTextLookup class >> new [

	self errorNewReplacedBy: #key:index:
]

{ #category : #resources }
CynOrdinalTextLookup class >> pluralRulesForLocale: aString [

	"Answer an instance of PluralRules for the specified locale and ordinal text"

	PluralRulesCache ifNil: [ PluralRulesCache := Dictionary new ].

	^ PluralRulesCache
		at: aString
		ifAbsentPut: [ CynIntl pluralRulesClass ordinalLocale: aString ]
]

{ #category : #accessing }
CynOrdinalTextLookup >> inTextVariant: aTextVariant [

	"Answer the text represented by the receiver using the specified TextVariant"

	^ aTextVariant textIndex: index pluralForm: self pluralForm
]

{ #category : #accessing }
CynOrdinalTextLookup >> index [

	^ index
]

{ #category : #initialization }
CynOrdinalTextLookup >> initializeWithKey: aSymbol index: anInteger [

	self initializeWithKey: aSymbol.

	index := anInteger
]

{ #category : #accessing }
CynOrdinalTextLookup >> pluralForm [

	"Answer the ordinal plural form for the receiver"

	^ (self class pluralRulesForLocale: self locale)
		select: index
]
