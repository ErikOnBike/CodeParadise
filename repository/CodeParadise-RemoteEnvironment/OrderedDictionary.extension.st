Extension { #name : #OrderedDictionary }

{ #category : #'*CodeParadise-RemoteEnvironment' }
OrderedDictionary >> asDictionary [

	"Answer the receiver as a Dictionary.

	Implementation:
	Since I am a Dictionary, answer myself."

	<applicationExtension>

	^ self
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
OrderedDictionary >> asJsonObjectValue [

	"Answer a representation of the receiver to be used in a JSON Object.

	Implementation:
	Since values of the receiver's properties can be any value,
	convert these to JSON Object values."

	<applicationExtension>

	| result |

	result := OrderedDictionary new.

	self keysAndValuesDo: [ :key :value |
		result at: key asString put: value asJsonObjectValue ].

	^ result
]
