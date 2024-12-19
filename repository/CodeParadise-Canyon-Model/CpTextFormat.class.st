"
I am a TextFormat. I am responsible to provide a value when requesting one using a key.
I maintain an optional Dictionary of lookup values. When a key is provided which starts
with a hash (like '#other'), I will delegate the lookup to the MultiLanguageText and
language I am configured with (using the key without the hash, i.e. in this case 'other').

"
Class {
	#name : #CpTextFormat,
	#superclass : #Object,
	#instVars : [
		'text',
		'language',
		'format'
	],
	#category : #'CodeParadise-Canyon-Model-Language'
}

{ #category : #'instance creation' }
CpTextFormat class >> multiLanguageText: aMultiLanguageText language: aLanguage format: aDictionary [

	"Answer an instance of the receiver with the specified values.
	The format Dictionary can be nil if no format options are present/needed."

	^ self basicNew
		initializeWithText: aMultiLanguageText language: aLanguage format: aDictionary ;
		yourself
]

{ #category : #'instance creation' }
CpTextFormat class >> new [

	self errorNewReplacedBy: #multiLanguageText:language:format:
]

{ #category : #accessing }
CpTextFormat >> at: keyObject [

	"Answer the format value for the specified key.

	Implementation:
	The format Dictionary can be nil (i.e. is optional)."

	^ (keyObject isString and: [ keyObject beginsWith: '#' ])
		ifTrue: [ text lang: language key: (keyObject allButFirst: 1) asSymbol format: format ]
		ifFalse: [ format ifNotNil: [ format at: keyObject ifAbsent: [ nil ] ] ]
]

{ #category : #initialization }
CpTextFormat >> initializeWithText: aMultiLanguageText language: aLanguage format: aDictionary [

	self initialize.

	text := aMultiLanguageText.
	language := aLanguage.
	format := aDictionary
]
