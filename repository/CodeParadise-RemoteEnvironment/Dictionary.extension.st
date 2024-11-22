Extension { #name : #Dictionary }

{ #category : #'*CodeParadise-RemoteEnvironment' }
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

{ #category : #'*CodeParadise-RemoteEnvironment' }
Dictionary >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeDictionary: self
]
