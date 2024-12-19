"
I am a LanguageDictionary. I am responsible for providing text (String) values
when looking up text values.

My text is stored in LanguageVolume instances. My Volumes are ordered to allow Volumes to
be shared between different applications and have specific Volumes override generic Volumes.
Generic Volumes should be added first. The specific Volumes should be added last.
(I.e. I lookup text starting with the last Volume added.)

"
Class {
	#name : #CpLanguageDictionary,
	#superclass : #Object,
	#instVars : [
		'volumes'
	],
	#category : #'CodeParadise-Canyon-Model-Language'
}

{ #category : #accessing }
CpLanguageDictionary >> addVolume: aVolume [

	"Add the specified LanguageVolume to the receiver.
	It is assumed the Volume is at least as specific as the last Volume added.
	Therefore always add Volumes in order from generic to specific."

	^ volumes add: aVolume
]

{ #category : #initialization }
CpLanguageDictionary >> initialize [

	super initialize.

	volumes := OrderedCollection new
]

{ #category : #accessing }
CpLanguageDictionary >> lookup: aTextLookup [

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
CpLanguageDictionary >> volumes [

	"Answer the LanguageVolumes of the receiver.
	The Volumes are answered in order from generic to specific."

	^ volumes
]
