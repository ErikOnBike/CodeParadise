Extension { #name : 'Behavior' }

{ #category : '*CodeParadise-RemoteEnvironment' }
Behavior >> installMethodDictionary: aMethodDictionary [

	"Install the specified method dictionary and bind any class variables
	in the installed methods to the receiver"

	methodDict := aMethodDictionary.
	aMethodDictionary valuesDo: [ :each | each bindClassVariablesTo: self ]

]
