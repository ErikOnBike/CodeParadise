Class {
	#name : #CpNodeJSSharpOperationAffineOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpOperationAffineOptions >> background [

	"Parsed by the color  module to extract values for red, green, blue and alpha.

	Type: String | Object
	Default: '#000000'"

	^ options at: #background
]

{ #category : #accessing }
CpNodeJSSharpOperationAffineOptions >> background: aString [

	"Parsed by the color  module to extract values for red, green, blue and alpha.

	Type: String | Object
	Default: '#000000'"

	options at: #background put: aString
]

{ #category : #accessing }
CpNodeJSSharpOperationAffineOptions >> idx [

	"Input horizontal offset.

	Type: Integer
	Default: 0"

	^ options at: #idx
]

{ #category : #accessing }
CpNodeJSSharpOperationAffineOptions >> idx: anInteger [

	"Input horizontal offset.

	Type: Integer
	Default: 0"

	options at: #idx put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpOperationAffineOptions >> idy [

	"Input vertical offset.

	Type: Integer
	Default: 0"

	^ options at: #idy
]

{ #category : #accessing }
CpNodeJSSharpOperationAffineOptions >> idy: anInteger [

	"Input vertical offset.

	Type: Integer
	Default: 0"

	options at: #idy put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpOperationAffineOptions >> interpolator [

	"Interpolator.

	Type: String
	Default: 'sharp.interpolators.bicubic'"

	^ options at: #interpolator
]

{ #category : #accessing }
CpNodeJSSharpOperationAffineOptions >> interpolator: aString [

	"Interpolator.

	Type: String
	Default: 'sharp.interpolators.bicubic'"

	options at: #interpolator put: aString
]

{ #category : #accessing }
CpNodeJSSharpOperationAffineOptions >> odx [

	"Output horizontal offset.

	Type: Integer
	Default: 0"

	^ options at: #odx
]

{ #category : #accessing }
CpNodeJSSharpOperationAffineOptions >> odx: anInteger [

	"Output horizontal offset.

	Type: Integer
	Default: 0"

	options at: #odx put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpOperationAffineOptions >> ody [

	"Output vertical offset.

	Type: Integer
	Default: 0"

	^ options at: #ody
]

{ #category : #accessing }
CpNodeJSSharpOperationAffineOptions >> ody: anInteger [

	"Output vertical offset.

	Type: Integer
	Default: 0"

	options at: #ody put: anInteger
]
