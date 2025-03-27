Extension { #name : #Object }

{ #category : #'*CodeParadise-JavaScript' }
Object >> asJsonObjectValue [

	"Answer a representation of the receiver to be used in a JSON Object.

	JSON values can either be: String, Number (Float or Integer), Boolean, nil,
	a Dictionary-like value (Dictionary, OrderedDictionary or subclasses)
	or an Array of such elements."

	<applicationExtension>

	^ self printString
]

{ #category : #'*CodeParadise-JavaScript' }
Object >> asRelaxedJsonObjectValue [

	"Answer a representation of the receiver to be used in a relaxed JSON Object.
	This means the representation allows JavaScriptFunction property values too.

	JSON values can either be: String, Number (Float or Integer), Boolean, nil,
	a Dictionary-like value (Dictionary, OrderedDictionary or subclasses)
	or an Array of such elements.
	This variant accepts JavaScriptFunction values too."

	<applicationExtension>

	^ self asJsonObjectValue
]

{ #category : #'*CodeParadise-JavaScript' }
Object >> consoleLog [

	self traceCr: self printString
]

{ #category : #'*CodeParadise-JavaScript' }
Object >> isErrorObject [

	"Answer whether the receiver represents an Error"

	<applicationExtension>

	^ false
]

{ #category : #'*CodeParadise-JavaScript' }
Object >> isJavaScriptObject [

	<applicationExtension>

	^ false
]
