Class {
	#name : #CpNodeJSSharpOperationNormalizeOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpOperationNormalizeOptions >> lower [

	"Percentile below which luminance values will be underexposed.

	Type: Number
	Default: 1"

	^ options at: #lower
]

{ #category : #accessing }
CpNodeJSSharpOperationNormalizeOptions >> lower: aNumber [

	"Percentile below which luminance values will be underexposed.

	Type: Number
	Default: 1"

	options at: #lower put: aNumber
]

{ #category : #accessing }
CpNodeJSSharpOperationNormalizeOptions >> upper [

	"Percentile above which luminance values will be overexposed.

	Type: Number
	Default: 99"

	^ options at: #upper
]

{ #category : #accessing }
CpNodeJSSharpOperationNormalizeOptions >> upper: aNumber [

	"Percentile above which luminance values will be overexposed.

	Type: Number
	Default: 99"

	options at: #upper put: aNumber
]
