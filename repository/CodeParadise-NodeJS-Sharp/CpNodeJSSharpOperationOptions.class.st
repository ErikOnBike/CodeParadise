Class {
	#name : #CpNodeJSSharpOperationOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpOperationOptions >> background [

	"Parsed by the color  module to extract values for red, green, blue and alpha.

	Type: String | Object
	Default: '#000000'"

	^ options at: #background
]

{ #category : #accessing }
CpNodeJSSharpOperationOptions >> background: aString [

	"Parsed by the color  module to extract values for red, green, blue and alpha.

	Type: String | Object
	Default: '#000000'"

	options at: #background put: aString
]
