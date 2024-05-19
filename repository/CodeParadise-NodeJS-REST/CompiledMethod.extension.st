Extension { #name : #CompiledMethod }

{ #category : #'*CodeParadise-NodeJS-REST' }
CompiledMethod >> asRestEndPoint [

	^ CpNodeJSRestEndpoint fromCompiledMethod: self
]
