"
I am a TextLookup. I am responsible for looking up text in a TextVariant.
I lookup a default text, but my subclasses can lookup cardinal and ordinal texts.
"
Class {
	#name : #CpTextLookup,
	#superclass : #Object,
	#instVars : [
		'key',
		'locale'
	],
	#category : #'CodeParadise-Canyon-Model-Language'
}

{ #category : #'instance creation' }
CpTextLookup class >> key: aSymbol [

	^ self basicNew
		initializeWithKey: aSymbol ;
		yourself
]

{ #category : #'instance creation' }
CpTextLookup class >> new [

	self errorNewReplacedBy: #key:
]

{ #category : #accessing }
CpTextLookup >> inTextVariant: aTextVariant [

	"Answer the text represented by the receiver using the specified TextVariant"

	^ aTextVariant text
]

{ #category : #initialization }
CpTextLookup >> initializeWithKey: aSymbol [

	self initialize.

	key := aSymbol
]

{ #category : #accessing }
CpTextLookup >> key [

	^ key
]

{ #category : #accessing }
CpTextLookup >> locale [

	"Answer the receiver's locale"

	^ locale
]

{ #category : #accessing }
CpTextLookup >> locale: aString [

	"Set the receiver's locale to the specified value"

	locale := aString
]

{ #category : #accessing }
CpTextLookup >> removeLocale [

	locale := nil
]
