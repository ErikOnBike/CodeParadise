Class {
	#name : #CpNodeJSSharpExtendOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpExtendOptions >> background [

	"Background colour, parsed by the color module, defaults to black without transparency.

	Type: Object | String
	Default: {r: 0, g: 0, b: 0, alpha: 1}"

	^ options at: #background
]

{ #category : #accessing }
CpNodeJSSharpExtendOptions >> background: anObject [

	"Background colour, parsed by the color module, defaults to black without transparency.

	Type: Object | String
	Default: {r: 0, g: 0, b: 0, alpha: 1}"

	options at: #background put: anObject
]

{ #category : #accessing }
CpNodeJSSharpExtendOptions >> bottom [

	"Pixels to extend.

	Type: Integer
	Default: 0"

	^ options at: #bottom
]

{ #category : #accessing }
CpNodeJSSharpExtendOptions >> bottom: anInteger [

	"Pixels to extend.

	Type: Integer
	Default: 0"

	options at: #bottom put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpExtendOptions >> extendWith [

	"Populate new pixels using this method, one of: background, copy, repeat, mirror.

	Type: String
	Default: 'background'"

	^ options at: #extendWith
]

{ #category : #accessing }
CpNodeJSSharpExtendOptions >> extendWith: aString [

	"Populate new pixels using this method, one of: background, copy, repeat, mirror.

	Type: String
	Default: 'background'"

	options at: #extendWith put: aString
]

{ #category : #accessing }
CpNodeJSSharpExtendOptions >> left [

	"Pixels to extend.

	Type: Integer
	Default: 0"

	^ options at: #left
]

{ #category : #accessing }
CpNodeJSSharpExtendOptions >> left: anInteger [

	"Pixels to extend.

	Type: Integer
	Default: 0"

	options at: #left put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpExtendOptions >> right [

	"Pixels to extend.

	Type: Integer
	Default: 0"

	^ options at: #right
]

{ #category : #accessing }
CpNodeJSSharpExtendOptions >> right: anInteger [

	"Pixels to extend.

	Type: Integer
	Default: 0"

	options at: #right put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpExtendOptions >> top [

	"Pixels to extend.

	Type: Integer
	Default: 0"

	^ options at: #top
]

{ #category : #accessing }
CpNodeJSSharpExtendOptions >> top: anInteger [

	"Pixels to extend.

	Type: Integer
	Default: 0"

	options at: #top put: anInteger
]
