Extension { #name : #CynMobileWebApplication }

{ #category : #'*CodeParadise-Canyon-Development' }
CynMobileWebApplication >> loadDevelopment [

	"Add development tools"

	self
		addDebugger ;
		addViewInspector
]

{ #category : #'*CodeParadise-Canyon-Development' }
CynMobileWebApplication >> methodChanged: anAnnouncement [

	"Handle the changed method.

	When a language resource method is changed, update the multi language text."

	| result method |

	result := super methodChanged: anAnnouncement.

	method := anAnnouncement method.
	(method pragmaAt: CynApp languageResourcePragmaName)
		ifNotNil: [ self recreateMultiLanguageText ].

	^ result
]

{ #category : #'*CodeParadise-Canyon-Development' }
CynMobileWebApplication >> recreateMultiLanguageText [

	"Update the multi language text in the browser"

	self environment ifDevelopment: [
		self environment
			sendMessage: (MessageSend
			receiver: CynApp name
			selector: #recreateMultiLanguageText
			arguments: nil) ]
]
