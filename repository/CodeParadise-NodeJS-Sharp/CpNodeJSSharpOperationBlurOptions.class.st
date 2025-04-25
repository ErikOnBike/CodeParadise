Class {
	#name : #CpNodeJSSharpOperationBlurOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpOperationBlurOptions >> minAmplitude [

	"A value between 0.001 and 1. A smaller value will generate a larger, more accurate mask.

	Type: Number
	Default: 0.2"

	^ options at: #minAmplitude
]

{ #category : #accessing }
CpNodeJSSharpOperationBlurOptions >> minAmplitude: aNumber [

	"A value between 0.001 and 1. A smaller value will generate a larger, more accurate mask.

	Type: Number
	Default: 0.2"

	options at: #minAmplitude put: aNumber
]

{ #category : #accessing }
CpNodeJSSharpOperationBlurOptions >> precision [

	"How accurate the operation should be, one of: integer, float, approximate.

	Type: String
	Default: 'integer'"

	^ options at: #precision
]

{ #category : #accessing }
CpNodeJSSharpOperationBlurOptions >> precision: aString [

	"How accurate the operation should be, one of: integer, float, approximate.

	Type: String
	Default: 'integer'"

	options at: #precision put: aString
]

{ #category : #accessing }
CpNodeJSSharpOperationBlurOptions >> sigma [

	"A value between 0.3 and 1000 representing the sigma of the Gaussian mask, where sigma = 1 + radius / 2.

	Type: Number"

	^ options at: #sigma
]

{ #category : #accessing }
CpNodeJSSharpOperationBlurOptions >> sigma: aNumber [

	"A value between 0.3 and 1000 representing the sigma of the Gaussian mask, where sigma = 1 + radius / 2.

	Type: Number"

	options at: #sigma put: aNumber
]
