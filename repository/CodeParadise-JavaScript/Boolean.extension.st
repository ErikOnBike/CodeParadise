Extension { #name : #Boolean }

{ #category : #'*CodeParadise-JavaScript' }
Boolean >> asJsonObjectValue [

	"Answer a representation of the receiver to be used in a JSON Object.

	JSON values can either be: String, Number (Float or Integer), Boolean, nil,
	a Dictionary-like value (Dictionary, OrderedDictionary or subclasses)
	or an Array of such elements."

	<applicationExtension>

	^ self
]
