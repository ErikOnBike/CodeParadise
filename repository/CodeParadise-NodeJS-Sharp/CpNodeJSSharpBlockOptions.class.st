Class {
	#name : #CpNodeJSSharpBlockOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpBlockOptions >> operation [

	"List of libvips low-level operation names to (un)block.

	Type: Collection"

	^ options at: #operation
]

{ #category : #accessing }
CpNodeJSSharpBlockOptions >> operation: aCollection [

	"List of libvips low-level operation names to (un)block.

	Type: Collection"

	options at: #operation put: aCollection
]
