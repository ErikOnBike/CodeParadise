Extension { #name : #BlockClosure }

{ #category : #'*CodeParadise-JavaScript' }
BlockClosure >> asJavaScriptFunction [

	"Answer the receiver as a JavaScript Function.

	Implementation:
	Because of a circular dependency, this method can't be installed by defining
	it as a <applicationExtension> method. This method is therefore explicitly
	installed in CpServerApplication >> #load"

	^ CpJavaScriptFunction wrap: self
]

{ #category : #'*CodeParadise-JavaScript' }
BlockClosure >> asRelaxedJsonObjectValue [

	"Answer a representation of the receiver to be used in a relaxed JSON Object.
	This means the representation allows JavaScriptFunction property values too.

	JSON values can either be: String, Number (Float or Integer), Boolean, nil,
	a Dictionary-like value (Dictionary, OrderedDictionary or subclasses)
	or an Array of such elements.
	This variant accepts JavaScriptFunction values too."

	<applicationExtension>

	^ self asJavaScriptFunction
]
