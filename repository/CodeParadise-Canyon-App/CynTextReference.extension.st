Extension { #name : #CynTextReference }

{ #category : #'*CodeParadise-Canyon-App' }
CynTextReference >> textUsingLanguageText: aMultiLanguageText lang: aLanguage [

	"Answer the receiver's text value using the specified language text and language"

	^ aMultiLanguageText lang: aLanguage key: key format: format
]
