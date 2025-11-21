Extension { #name : #CynApp }

{ #category : #'*CodeParadise-Canyon-Development' }
CynApp class >> prodPathFrom: aString [

	"Answer the path how it will be in production"

	| pathParts |

	pathParts := (aString findTokens: '/')
		reject: [ :each | each isEmpty or: [ each = 'index.html' ] ].

	"Extract the app name as prefix"
	pathParts ifNotEmpty: [
		pathParts first = CpClientEnvironment current app
			ifTrue: [ pathParts := pathParts allButFirst ] ].

	pathParts ifEmpty: [ ^ '/' ].

	^ String streamContents: [ :stream |
		pathParts do: [ :each |
			stream
				nextPut: $/ ;
				nextPutAll: each ] ]
]

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
