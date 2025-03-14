Class {
	#name : #CpCanyonMobileWebClientBehavior,
	#superclass : #CpWebClientBehavior,
	#category : #'CodeParadise-Canyon-App-Application'
}

{ #category : #accessing }
CpCanyonMobileWebClientBehavior >> defaultFallbackLocales [

	"Answer the collection of fallback locales for the app.
	By default there are no fallback locales specified."

	^ #()
]

{ #category : #accessing }
CpCanyonMobileWebClientBehavior >> defaultLanguage [

	"Answer the app's text language"

	^ CpTextLanguage locale: self defaultLocale fallbackLocales: self defaultFallbackLocales
]

{ #category : #accessing }
CpCanyonMobileWebClientBehavior >> defaultLocale [

	"Answer the default language locale.
	By default the English language (with no explicit region specified) is answered."

	^ #en
]

{ #category : #initialization }
CpCanyonMobileWebClientBehavior >> initialize [

	"Initialize the receiver ny setting the default language texts and initializing the main app View"

	super initialize.

	self initializeLanguageText.

	CpHtmlElement documentBody
		appendChild: CpCanyonAppMainView current
]

{ #category : #initialization }
CpCanyonMobileWebClientBehavior >> initializeLanguageText [

	"Initialize the language text by setting the default language, locale and fallback locales"

	CpPropertyEntity languageText: (CpMultiLanguageText defaultLanguage: self defaultLanguage)
]
