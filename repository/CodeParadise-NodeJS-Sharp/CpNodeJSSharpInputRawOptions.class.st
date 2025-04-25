Class {
	#name : #CpNodeJSSharpInputRawOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpInputRawOptions >> channels [

	"Integral number of channels, between 1 and 4.

	Type: Integer"

	^ options at: #channels
]

{ #category : #accessing }
CpNodeJSSharpInputRawOptions >> channels: anInteger [

	"Integral number of channels, between 1 and 4."

	options at: #channels put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpInputRawOptions >> height [

	"Integral number of pixels high.

	Type: Integer"

	^ options at: #height
]

{ #category : #accessing }
CpNodeJSSharpInputRawOptions >> height: anInteger [

	"Integral number of pixels high."

	options at: #height put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpInputRawOptions >> premultiplied [

	"Specifies that the raw input has already been premultiplied, set to true to avoid sharp premultiplying the image. (optional, default false).

	Type: Boolean"

	^ options at: #premultiplied
]

{ #category : #accessing }
CpNodeJSSharpInputRawOptions >> premultiplied: aBoolean [

	"Specifies that the raw input has already been premultiplied, set to true to avoid sharp premultiplying the image. (optional, default false)."

	options at: #premultiplied put: aBoolean
]

{ #category : #accessing }
CpNodeJSSharpInputRawOptions >> width [

	"Integral number of pixels wide.

	Type: Integer"

	^ options at: #width
]

{ #category : #accessing }
CpNodeJSSharpInputRawOptions >> width: anInteger [

	"Integral number of pixels wide."

	options at: #width put: anInteger
]
