Extension { #name : #CpCanyonMobileWebApplication }

{ #category : #'*CodeParadise-Canyon-Development' }
CpCanyonMobileWebApplication >> loadDevelopment [

	"Add development tools"

	self
		addDebugger ;
		addViewInspector
]
