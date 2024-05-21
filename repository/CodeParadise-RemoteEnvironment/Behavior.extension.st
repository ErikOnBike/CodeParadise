Extension { #name : #Behavior }

{ #category : #'*CodeParadise-RemoteEnvironment' }
Behavior >> installClassMethod: aCompiledMethod [

	<clientEnvironment>

	self classSide addSelector: aCompiledMethod selector withMethod: aCompiledMethod.
	aCompiledMethod bindClassVariablesTo: self classSide
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Behavior >> installInstanceMethod: aCompiledMethod [

	<clientEnvironment>

	self instanceSide addSelector: aCompiledMethod selector withMethod: aCompiledMethod.
	aCompiledMethod bindClassVariablesTo: self instanceSide
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Behavior >> installMethodDictionary: aMethodDictionary [

	"Install the specified method dictionary and bind any class variables
	in the installed methods to the receiver"

	methodDict := aMethodDictionary.
	aMethodDictionary valuesDo: [ :each | each bindClassVariablesTo: self ]

]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Behavior >> removeClassMethod: aCompiledMethod [

	<clientEnvironment>

	self classSide removeSelector: aCompiledMethod selector
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Behavior >> removeInstanceMethod: aCompiledMethod [

	<clientEnvironment>

	self instanceSide removeSelector: aCompiledMethod selector
]
