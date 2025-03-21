Extension { #name : #Number }

{ #category : #'*CodeParadise-JavaScript' }
Number >> asJsonObjectValue [

	"Answer a representation of the receiver to be used in a JSON Object.

	JSON values can either be: String, Number (Float or Integer), Boolean, nil,
	a Dictionary-like value (Dictionary, OrderedDictionary or subclasses)
	or an Array of such elements."

	<applicationExtension>

	^ self asFloat
]
