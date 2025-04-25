Class {
	#name : #CpNodeJSSharpInputCreateOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpInputCreateOptions >> background [

	"Parsed by the color  module to extract values for red, green, blue and alpha.

	Type: String | Object"

	^ options at: #background
]

{ #category : #accessing }
CpNodeJSSharpInputCreateOptions >> background: aString [

	"Parsed by the color  module to extract values for red, green, blue and alpha."

	options at: #background put: aString
]

{ #category : #accessing }
CpNodeJSSharpInputCreateOptions >> channels [

	"Integral number of channels, either 3 (RGB) or 4 (RGBA).

	Type: Integer"

	^ options at: #channels
]

{ #category : #accessing }
CpNodeJSSharpInputCreateOptions >> channels: anInteger [

	"Integral number of channels, either 3 (RGB) or 4 (RGBA)."

	options at: #channels put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpInputCreateOptions >> height [

	"Integral number of pixels high.

	Type: Integer"

	^ options at: #height
]

{ #category : #accessing }
CpNodeJSSharpInputCreateOptions >> height: anInteger [

	"Integral number of pixels high."

	options at: #height put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpInputCreateOptions >> width [

	"Integral number of pixels wide.

	Type: Integer"

	^ options at: #width
]

{ #category : #accessing }
CpNodeJSSharpInputCreateOptions >> width: anInteger [

	"Integral number of pixels wide."

	options at: #width put: anInteger
]
