Class {
	#name : #CpNodeJSSharpOperationClaheOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpOperationClaheOptions >> height [

	"Integral height of the search window, in pixels.

	Type: Integer"

	^ options at: #height
]

{ #category : #accessing }
CpNodeJSSharpOperationClaheOptions >> height: anInteger [

	"Integral height of the search window, in pixels.

	Type: Integer"

	options at: #height put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpOperationClaheOptions >> maxSlope [

	"Integral level of brightening, between 0 and 100, where 0 disables contrast limiting.

	Type: Integer
	Default: 3"

	^ options at: #maxSlope
]

{ #category : #accessing }
CpNodeJSSharpOperationClaheOptions >> maxSlope: anInteger [

	"Integral level of brightening, between 0 and 100, where 0 disables contrast limiting.

	Type: Integer
	Default: 3"

	options at: #maxSlope put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpOperationClaheOptions >> width [

	"Integral width of the search window, in pixels.

	Type: Integer"

	^ options at: #width
]

{ #category : #accessing }
CpNodeJSSharpOperationClaheOptions >> width: anInteger [

	"Integral width of the search window, in pixels.

	Type: Integer"

	options at: #width put: anInteger
]
