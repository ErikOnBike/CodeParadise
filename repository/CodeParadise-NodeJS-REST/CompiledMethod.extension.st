Extension { #name : #CompiledMethod }

{ #category : #'*CodeParadise-NodeJS-REST' }
CompiledMethod >> asRestEndPoint [

	^ CpNodeJSRestEndpointOperation fromCompiledMethod: self
]
