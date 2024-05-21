Extension { #name : #Metaclass }

{ #category : #'*CodeParadise-RemoteEnvironment' }
Metaclass >> installMethod: aCompiledMethod [

	"Install thw specified CompiledMethod in the receiver"

	<clientEnvironment>

	self installClassMethod: aCompiledMethod
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Metaclass >> removeMethod: aCompiledMethod [

	"Remove the specified CompiledMethod from the receiver"

	<clientEnvironment>

	self removeClassMethod: aCompiledMethod
]
