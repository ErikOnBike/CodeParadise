Class {
	#name : #CpNodeJSSharpOutputToBufferOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpOutputToBufferOptions >> resolveWithObject [

	"Resolve the Promise with an Object containing data and info properties instead of resolving only with data.

	Type: Boolean"

	^ options at: #resolveWithObject
]

{ #category : #accessing }
CpNodeJSSharpOutputToBufferOptions >> resolveWithObject: aBoolean [

	"Resolve the Promise with an Object containing data and info properties instead of resolving only with data."

	options at: #resolveWithObject put: aBoolean
]
