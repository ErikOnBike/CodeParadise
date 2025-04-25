Class {
	#name : #CpNodeJSSharpWithIccProfileOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #'as yet unclassified' }
CpNodeJSSharpWithIccProfileOptions >> attach [

	"Should the ICC profile be included in the output image metadata?

	Type: Boolean"

	^ options at: #attach
]

{ #category : #'as yet unclassified' }
CpNodeJSSharpWithIccProfileOptions >> attach: aBoolean [

	"Should the ICC profile be included in the output image metadata?"

	options at: #attach put: aBoolean
]
