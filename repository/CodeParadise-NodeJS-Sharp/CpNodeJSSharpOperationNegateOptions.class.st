Class {
	#name : #CpNodeJSSharpOperationNegateOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpOperationNegateOptions >> alpha [

	"Whether or not to negate any alpha channel.

	Type: Boolean
	Default: true"

	^ options at: #alpha
]

{ #category : #accessing }
CpNodeJSSharpOperationNegateOptions >> alpha: aBoolean [

	"Whether or not to negate any alpha channel.

	Type: Boolean
	Default: true"

	options at: #alpha put: aBoolean
]
