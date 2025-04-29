"
I am a TextLookup. I am responsible for looking up text in a TextVariant.
I lookup a default text, but my subclasses can lookup cardinal and ordinal texts.
"
Class {
	#name : #CynTextLookup,
	#superclass : #Object,
	#instVars : [
		'key',
		'locale'
	],
	#category : #'CodeParadise-Canyon-App-Language'
}

{ #category : #'instance creation' }
CynTextLookup class >> key: aSymbol [

	^ self basicNew
		initializeWithKey: aSymbol ;
		yourself
]

{ #category : #'instance creation' }
CynTextLookup class >> new [

	self errorNewReplacedBy: #key:
]

{ #category : #accessing }
CynTextLookup >> inTextVariant: aTextVariant [

	"Answer the text represented by the receiver using the specified TextVariant"

	^ aTextVariant text
]

{ #category : #initialization }
CynTextLookup >> initializeWithKey: aSymbol [

	self initialize.

	key := aSymbol
]

{ #category : #accessing }
CynTextLookup >> key [

	^ key
]

{ #category : #accessing }
CynTextLookup >> locale [

	"Answer the receiver's locale"

	^ locale
]

{ #category : #accessing }
CynTextLookup >> locale: aString [

	"Set the receiver's locale to the specified value"

	locale := aString
]

{ #category : #accessing }
CynTextLookup >> removeLocale [

	locale := nil
]
