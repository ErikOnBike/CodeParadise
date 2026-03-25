Extension { #name : #ZnServer }

{ #category : #'*CodeParadise-WebApplication' }
ZnServer >> globalStaticFileServerDelegate [

	"Answer the global static file server delegate.

	Implementation:
	Assume the server has a prefix mapping delegate installed."

	^ self delegate prefixDictionary values
		detect: [ :each | each isGlobalStaticFileServerDelegate ]
		ifFound: [ :each | each ]
		ifNone: [ nil ]
]
