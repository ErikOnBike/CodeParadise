Class {
	#name : #CpNodeJSSharpOperationThresholdOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpOperationThresholdOptions >> grayscale [

	"Convert to single channel greyscale.

	Type: Boolean
	Default: true"

	^ options at: #grayscale
]

{ #category : #accessing }
CpNodeJSSharpOperationThresholdOptions >> grayscale: aBoolean [

	"Convert to single channel greyscale.

	Type: Boolean
	Default: true"

	options at: #grayscale put: aBoolean
]
