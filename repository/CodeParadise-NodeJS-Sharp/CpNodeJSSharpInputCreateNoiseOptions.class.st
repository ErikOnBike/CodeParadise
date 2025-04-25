Class {
	#name : #CpNodeJSSharpInputCreateNoiseOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpInputCreateNoiseOptions >> mean [

	"Mean of pixels in generated noise.

	Type: Number"

	^ options at: #mean
]

{ #category : #accessing }
CpNodeJSSharpInputCreateNoiseOptions >> mean: aNumber [

	"Mean of pixels in generated noise."

	options at: #mean put: aNumber
]

{ #category : #accessing }
CpNodeJSSharpInputCreateNoiseOptions >> sigma [

	"Standard deviation of pixels in generated noise.

	Type: Number"

	^ options at: #sigma
]

{ #category : #accessing }
CpNodeJSSharpInputCreateNoiseOptions >> sigma: aNumber [

	"Standard deviation of pixels in generated noise."

	options at: #sigma put: aNumber
]

{ #category : #accessing }
CpNodeJSSharpInputCreateNoiseOptions >> type [

	"Type of generated noise, currently only gaussian is supported.

	Type: String"

	^ options at: #type
]

{ #category : #accessing }
CpNodeJSSharpInputCreateNoiseOptions >> type: aString [

	"Type of generated noise, currently only gaussian is supported."

	options at: #type put: aString
]
