Class {
	#name : #CpNodeJSSharpKernelOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpKernelOptions >> height [

	"Height of the kernel in pixels.

	Type: Integer"

	^ options at: #height
]

{ #category : #accessing }
CpNodeJSSharpKernelOptions >> height: anInteger [

	"Height of the kernel in pixels.

	Type: Integer"

	options at: #height put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpKernelOptions >> kernel [

	"Array of length width*height containing the kernel values.

	Type: Array"

	^ options at: #kernel
]

{ #category : #accessing }
CpNodeJSSharpKernelOptions >> kernel: anArray [

	"Array of length width*height containing the kernel values.

	Type: Array"

	options at: #kernel put: anArray
]

{ #category : #accessing }
CpNodeJSSharpKernelOptions >> offset [

	"The offset of the kernel in pixels.

	Type: Integer
	Default: 0"

	^ options at: #offset
]

{ #category : #accessing }
CpNodeJSSharpKernelOptions >> offset: anInteger [

	"The offset of the kernel in pixels.

	Type: Integer
	Default: 0"

	options at: #offset put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpKernelOptions >> scale [

	"The scale of the kernel in pixels.

	Type: Integer.
	Default: sum"

	^ options at: #scale
]

{ #category : #accessing }
CpNodeJSSharpKernelOptions >> scale: anInteger [.

	"The scale of the kernel in pixels.

	Type: Integer.
	Default: sum"

	options at: #scale put: anInteger.
]

{ #category : #accessing }
CpNodeJSSharpKernelOptions >> width [

	"Width of the kernel in pixels.

	Type: Integer"

	^ options at: #width
]

{ #category : #accessing }
CpNodeJSSharpKernelOptions >> width: anInteger [

	"Width of the kernel in pixels.

	Type: Integer"

	options at: #width put: anInteger
]
