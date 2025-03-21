Extension { #name : #String }

{ #category : #'*CodeParadise-JavaScript' }
String >> asJsonObjectValue [

	"Answer a representation of the receiver to be used in a JSON Object.

	Implementation:
	Override the Collection >> #asJsonObjectValue implementation, since Strings are supported natively
	and should not be seen as an Array of Characters."

	<applicationExtension>

	^ self
]

{ #category : #'*CodeParadise-JavaScript' }
String >> asRelaxedJsonObjectValue [

	"Answer a representation of the receiver to be used in a JSON Object.

	Implementation:
	Override the Collection >> #asRelaxedJsonObjectValue implementation, since Strings are supported natively
	and should not be seen as an Array of Characters."

	<applicationExtension>

	^ self
]
