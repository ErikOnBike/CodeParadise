Extension { #name : #CpWebApplication }

{ #category : #'*CodeParadise-WebApplication-Development' }
CpWebApplication >> addViewInspector [

	CpViewInspectorSupport on: self environment
]

{ #category : #'*CodeParadise-WebApplication-Development' }
CpWebApplication class >> webResourceDirectory [

	"Answer the name of the directory (within the repository) containing the web resources"

	^ 'www'
]
