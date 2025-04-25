Class {
	#name : #CpNodeJSSharpTrimOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpTrimOptions >> background [

	"Background colour, parsed by the color  module, defaults to that of the top-left pixel.

	Type: String | Object
	Default: 'top-left pixel'"

	^ options at: #background
]

{ #category : #accessing }
CpNodeJSSharpTrimOptions >> background: aString [

	"Background colour, parsed by the color  module, defaults to that of the top-left pixel.

	Type: String | Object
	Default: 'top-left pixel'"

	options at: #background put: aString
]

{ #category : #accessing }
CpNodeJSSharpTrimOptions >> lineArt [

	"Does the input more closely resemble line art (e.g. vector) rather than being photographic?

	Type: Boolean
	Default: false"

	^ options at: #lineArt
]

{ #category : #accessing }
CpNodeJSSharpTrimOptions >> lineArt: aBoolean [

	"Does the input more closely resemble line art (e.g. vector) rather than being photographic?

	Type: Boolean
	Default: false"

	options at: #lineArt put: aBoolean
]

{ #category : #accessing }
CpNodeJSSharpTrimOptions >> treshold [

	"Allowed difference from the above colour, a positive number.

	Type: Integer
	Default: 10"

	^ options at: #treshold
]

{ #category : #accessing }
CpNodeJSSharpTrimOptions >> treshold: anInteger [

	"Allowed difference from the above colour, a positive number.

	Type: Integer
	Default: 10"

	options at: #treshold put: anInteger
]
