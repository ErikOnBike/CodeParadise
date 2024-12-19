"
I am a TextLanguage. I am responsible for maintaining a locale value and
optionally fallback locales. The fallback locales are ordered.

For example my instances could be:

A region specific locale falling back to other region specific locale, then to region-less locale:
locale 'en-UK' with fallbacks 'en-US' and 'en'

A region specific locale falling back to region-less locale, then to other language:
locale 'nl-NL' with fallbacks 'nl' and 'en'

"
Class {
	#name : #CpTextLanguage,
	#superclass : #Object,
	#instVars : [
		'locales',
		'locale',
		'fallbackLocales'
	],
	#category : #'CodeParadise-Canyon-Model-Language'
}

{ #category : #'instance creation' }
CpTextLanguage class >> locale: aSymbol [

	^ self locale: aSymbol fallbackLocales: #()
]

{ #category : #'instance creation' }
CpTextLanguage class >> locale: aSymbol fallbackLocales: aCollection [

	^ self basicNew
		initializeWithLocale: aSymbol fallbackLocales: aCollection ;
		yourself
]

{ #category : #'instance creation' }
CpTextLanguage class >> new [

	self errorNewReplacedBy: (' or ' join: { #locale: . #locale:fallbackLocales: })
]

{ #category : #initialization }
CpTextLanguage >> initializeWithLocale: aSymbol fallbackLocales: aCollection [

	self initialize.

	locales := Array new: 1 + aCollection size.
	locales at: 1 put: aSymbol.
	locales replaceFrom: 2 to: locales size with: aCollection
]

{ #category : #accessing }
CpTextLanguage >> locales [

	"Answer my locale and fallback locales in order.

	Implementation:
	During instantiation the locale and fallback locales have been
	put in an ordered collection (Array).

	See method: #initializeWithLocale:fallbackLocales:"

	^ locales
]
