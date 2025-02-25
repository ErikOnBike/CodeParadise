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
CpParamText class >> key: aSymbol format: aDictionary [

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

{ #category : #accessing }
CpParamText >> format [

	^ format
]

{ #category : #accessing }
CpParamText >> formatWithAll: aDictionary [

	^ format copy
		addAll: aDictionary ;
		yourself
]

{ #category : #initialization }
CpParamText >> initializeWithKey: aSymbol format: aDictionary [

	self initialize.

	key := aSymbol.
	format := aDictionary
]

{ #category : #accessing }
CpParamText >> key [

	^ key
]
