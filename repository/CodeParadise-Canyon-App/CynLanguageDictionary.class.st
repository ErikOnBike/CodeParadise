"
I am a LanguageDictionary. I am responsible for providing text (String) values
when looking up text values.

My text is stored in LanguageVolume instances. My Volumes are ordered to allow Volumes to
be shared between different applications and have specific Volumes override generic Volumes.
Generic Volumes should be added first. The specific Volumes should be added last.
(I.e. I lookup text starting with the last Volume added.)

Example JSON input which is acceptable. The numeric keys are all converted to Integers.
```
{
	""errors"": {
		""error.domain.noPersonsFound"": ""no persons found"",
		""error.domain.thingUnknown"": {
			""default"": ""unknown thing"",
			""1"": ""first thing unknown"",
			""2"": ""second thing unknown""
		}
	},
	""domain"": {
		""domain.ordinalPerson"": {
			""default"": ""a person"",
			""1"": ""{index}st person"",
			""2"": ""{index}nd person"",
			""-1"": ""last person"",
			""-2"": ""second last person""
		},
		""domain.cardinalThing"": {
			""default"": ""some things"",
			""0"": ""no things"",
			""one"": ""one thing"",
			""other"": ""{count} things""
		}
	}
}
```

"
Class {
	#name : #CynLanguageDictionary,
	#superclass : #Object,
	#instVars : [
		'volumes'
	],
	#category : #'CodeParadise-Canyon-App-Language'
}

{ #category : #'instance creation' }
CynLanguageDictionary class >> fromOrderedDictionary: anOrderedDictionary [

	"Answer an instance of the receiver using the specified OrderedDictionary as input.
	Be aware: providing a non-ordered Dictionary might result in unexpected behavior,
	since Volumes are searched in (reverse) order. See class comment."

	^ self new
		addLanguageVolumesFromDictionary: anOrderedDictionary ;
		yourself
]

{ #category : #'instance creation' }
CynLanguageDictionary class >> fromString: aString [

	"Answer an instance of the receiver using the specified JSON string as input"

	^ self fromOrderedDictionary: (CpJavaScriptJSON parse: aString)
]

{ #category : #adding }
CynLanguageDictionary >> addLanguageVolumesFromDictionary: anOrderedDictionary [

	"Add the content of the OrderedDictionary to the receiver.
	The order is important! The first elements are considered
	'generic' and every element after it is assumed to be more
	'specific'. Lookup is performed from the last to the first
	element.
	The volume keys are ignored here.
	Assume the values are Dictionaries which can be converted
	to LanguageVolume instances."

	anOrderedDictionary keysAndValuesDo: [ :key :value |
		self traceCr: 'Adding text volume: ', key.
		self addVolume: (CynLanguageVolume fromDictionary: value) ]
]

{ #category : #accessing }
CynLanguageDictionary >> addVolume: aVolume [

	"Add the specified LanguageVolume to the receiver.
	It is assumed the Volume is at least as specific as the last Volume added.
	Therefore always add Volumes in order from generic to specific."

	^ volumes add: aVolume
]

{ #category : #initialization }
CynLanguageDictionary >> initialize [

	super initialize.

	volumes := OrderedCollection new
]

{ #category : #accessing }
CynLanguageDictionary >> lookup: aTextLookup [

	"Lookup the text specified in the receiver's LanguageVolumes and answer it.
	Answer nil if no matching text is found.

	Implementation:
	Start with the last added Volume, it is assumed to contain the more specific
	text variants than the first added Volume(s)."

	self volumes reverseDo: [ :each |
		(each lookup: aTextLookup)
			ifNotNil: [ :text | ^ text ] ].

	^ nil
]

{ #category : #accessing }
CynLanguageDictionary >> volumes [

	"Answer the LanguageVolumes of the receiver.
	The Volumes are answered in order from generic to specific."

	^ volumes
]
