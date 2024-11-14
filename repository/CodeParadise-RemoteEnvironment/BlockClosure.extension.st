Extension { #name : #BlockClosure }

{ #category : #'*CodeParadise-RemoteEnvironment' }
BlockClosure >> asJavaScriptFunction [

	"Answer the receiver as a JavaScript Function.

	Implementation:
	Because of a circular dependency, this method can't be installed by defining
	it as a <applicationExtension> method. This method is therefore explicitly
	installed in CpServerApplication >> #load"

	^ CpJavaScriptFunction wrap: self
]
