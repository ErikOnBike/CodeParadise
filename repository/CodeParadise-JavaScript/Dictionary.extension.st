Extension { #name : #Dictionary }

{ #category : #'*CodeParadise-JavaScript' }
Dictionary >> asJsonObjectValue [

	"Answer a representation of the receiver to be used in a JSON Object.

	Implementation:
	Since values of the receiver's properties can be any value,
	convert these to JSON Object values."

	<applicationExtension>

	| result |

	result := Dictionary new.

	self keysAndValuesDo: [ :key :value |
		result at: key asString put: value asJsonObjectValue ].

	^ result
]

{ #category : #'*CodeParadise-JavaScript' }
Dictionary >> asRelaxedJsonObjectValue [

	"Answer a representation of the receiver to be used in a relaxed JSON Object.
	This means the representation allows JavaScriptFunction property values too.

	JSON values can either be: String, Number (Float or Integer), Boolean, nil,
	a Dictionary-like value (Dictionary, OrderedDictionary or subclasses)
	or an Array of such elements.
	This variant accepts JavaScriptFunction values too."

	<applicationExtension>

	| result |

	result := Dictionary new.

	self keysAndValuesDo: [ :key :value |
		result at: key asString put: value asRelaxedJsonObjectValue ].

	^ result
]
