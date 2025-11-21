Extension { #name : #CynApp }

{ #category : #'*CodeParadise-Canyon-Development' }
CynApp class >> recreateMultiLanguageText [

	"Recreate the multi language text of the current instance.
	This method should only be used during development to update the
	multi language text if a language resource (method) has changed."

	self traceCr: 'Update multi language text'.

	Current
		createLanguageText ;
		initializeLanguageText.

	self updateMultiLanguageText
]
