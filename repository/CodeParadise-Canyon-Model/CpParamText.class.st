"
I am a parameterized Text.
I have a key referencing some TextVariant and formatting values.
"
Class {
	#name : #CpParamText,
	#superclass : #Object,
	#instVars : [
		'key',
		'format'
	],
	#category : #'CodeParadise-Canyon-Model-Language'
}

{ #category : #'accessing - default lang' }
CpParamText class >> key: aSymbol [

	^ self key: aSymbol format: nil
]

{ #category : #'accessing - default lang' }
CpParamText class >> key: aSymbol format: aDictionary [

	"Answer a new instance of the receiver with the specified key and optional formatting Dictionary"

	^ self basicNew
		initializeWithKey: aSymbol format: aDictionary ;
		yourself
]

{ #category : #'accessing - default lang' }
CpParamText class >> key: aSymbol with: aString [

	^ self key: aSymbol format: (Dictionary with: 1 -> aString)
]

{ #category : #'accessing - default lang' }
CpParamText class >> key: aSymbol with: firstString with: secondString [

	^ self key: aSymbol format: (Dictionary with: 1 -> firstString with: 2 -> secondString)
]

{ #category : #'accessing - default lang' }
CpParamText class >> key: aSymbol with: firstString with: secondString with: thirdString [

	^ self key: aSymbol format: (Dictionary with: 1 -> firstString with: 2 -> secondString with: 3 -> thirdString)
]

{ #category : #'instance creation' }
CpParamText class >> new [

	self errorNewReplacedBy: #key:format:
]

{ #category : #converting }
CpParamText >> asParamText [

	^ self
]

{ #category : #accessing }
CpParamText >> format [

	^ format
]

{ #category : #accessing }
CpParamText >> formatWithAll: aDictionary [

	"Answer a new formatting Dictionary containing the values from the receiver and
	the (optional) Dictionary specified"

	| baseDictionary |

	baseDictionary := format
		ifNotNil: [ format copy ]
		ifNil: [ Dictionary new ].

	aDictionary ifNotNil: [
		baseDictionary addAll: aDictionary ].

	^ aDictionary
]

{ #category : #testing }
CpParamText >> hasEmptyFormat [

	"Answer whether the receiver has something to format"

	^ format isEmptyOrNil
]

{ #category : #initialization }
CpParamText >> initializeWithKey: aSymbol format: aDictionary [

	self initialize.

	key := aSymbol.
	format := aDictionary
]

{ #category : #accessing }
CpParamText >> textKey [

	"Answer the receiver's key.
	This method is to allow for a single access protocol for both the receiver class and Symbol."

	^ key
]
