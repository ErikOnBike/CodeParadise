Class {
	#name : #CynCardinalTextLookup,
	#superclass : #CynTextLookup,
	#instVars : [
		'count'
	],
	#classVars : [
		'PluralRulesCache'
	],
	#category : #'CodeParadise-Canyon-App-Language'
}

{ #category : #'instance creation' }
CynCardinalTextLookup class >> key: aSymbol [

	self errorNewReplacedBy: #key:count:
]

{ #category : #'instance creation' }
CynCardinalTextLookup class >> key: aSymbol count: anInteger [

	^ self basicNew
		initializeWithKey: aSymbol count: anInteger ;
		yourself
]

{ #category : #'instance creation' }
CynCardinalTextLookup class >> new [

	self errorNewReplacedBy: #key:count:
]

{ #category : #resources }
CynCardinalTextLookup class >> pluralRulesForLocale: aString [

	"Answer an instance of PluralRules for the specified locale and cardinal text"

	PluralRulesCache ifNil: [ PluralRulesCache := Dictionary new ].

	^ PluralRulesCache
		at: aString
		ifAbsentPut: [ CynIntl pluralRulesClass cardinalLocale: aString ]
]

{ #category : #accessing }
CynCardinalTextLookup >> count [

	^ count
]

{ #category : #accessing }
CynCardinalTextLookup >> inTextVariant: aTextVariant [

	"Answer the text represented by the receiver using the specified TextVariant"

	^ aTextVariant textCount: count pluralForm: self pluralForm
]

{ #category : #initialization }
CynCardinalTextLookup >> initializeWithKey: aSymbol count: anInteger [

	self initializeWithKey: aSymbol.

	count := anInteger
]

{ #category : #accessing }
CynCardinalTextLookup >> pluralForm [

	"Answer the cardinal plural form for the receiver"

	^ (self class pluralRulesForLocale: self locale)
		select: count
]
