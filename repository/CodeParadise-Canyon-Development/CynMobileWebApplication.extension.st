Extension { #name : #CynMobileWebApplication }

{ #category : #'*CodeParadise-Canyon-Development' }
CynMobileWebApplication >> loadDevelopment [

	"Add development tools"

	self
		addDebugger ;
		addViewInspector
]
