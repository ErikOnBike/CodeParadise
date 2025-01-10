Extension { #name : #Collection }

{ #category : #'*CodeParadise-RemoteEnvironment' }
Collection >> asJsonObjectValue [

	"Answer a representation of the receiver to be used in a JSON Object.

	JSON values can either be: String, Number (Float or Integer), Boolean, nil,
	a Dictionary-like value (Dictionary, OrderedDictionary or subclasses)
	or an Array of such elements."

	<applicationExtension>

	^ Array new: self size streamContents: [ :stream |
		self do: [ :each | stream nextPut: each asJsonObjectValue ] ]
]
