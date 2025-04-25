Class {
	#name : #CpNodeJSSharpExtractOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpExtractOptions >> height [

	"Height of region to extract.

	Type: Integer"

	^ options at: #height
]

{ #category : #accessing }
CpNodeJSSharpExtractOptions >> height: anInteger [

	"Height of region to extract.

	Type: Integer"

	options at: #height put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpExtractOptions >> left [

	"Zero-indexed offset from left edge.

	Type: Integer"

	^ options at: #left
]

{ #category : #accessing }
CpNodeJSSharpExtractOptions >> left: anInteger [

	"Zero-indexed offset from left edge.

	Type: Integer"

	options at: #left put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpExtractOptions >> top [

	"Zero-indexed offset from top edge.

	Type: Integer"

	^ options at: #top
]

{ #category : #accessing }
CpNodeJSSharpExtractOptions >> top: anInteger [

	"Zero-indexed offset from top edge.

	Type: Integer"

	options at: #top put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpExtractOptions >> width [

	"Width of region to extract.

	Type: Integer"

	^ options at: #width
]

{ #category : #accessing }
CpNodeJSSharpExtractOptions >> width: anInteger [

	"Width of region to extract.

	Type: Integer"

	options at: #width put: anInteger
]
