Extension { #name : #CynMobileWebApplication }

{ #category : #'*CodeParadise-Canyon-Development' }
CynMobileWebApplication class >> addWebResourcesDelegateTo: aServer [

	"Add a simplified delegate to map all (unknown) paths to the Canyon app"
	
	| originalDelegate |

	super addWebResourcesDelegateTo: aServer.

	"Add replacement delegate only once"
	originalDelegate := aServer delegate.
	originalDelegate class = CynMobileApplicationServerDelegate
		ifFalse: [ aServer delegate: (CynMobileApplicationServerDelegate delegate: originalDelegate) ]
]

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
