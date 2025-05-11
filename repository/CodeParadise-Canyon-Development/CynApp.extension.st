Extension { #name : #CynApp }

{ #category : #'*CodeParadise-Canyon-Development' }
CynApp class >> updateMultiLanguageText [

	"Update the multi language text of the current instance.

	Implementation:
	Simply re-initialize the multi language text."

	Current ifNotNil: [ Current initializeLanguageText ]
]
