Class {
	#name : #CpNodeJSSharpOperationModulateOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpOperationModulateOptions >> brightness [

	"Brightness multiplier.

	Type: Number"

	^ options at: #brightness
]

{ #category : #accessing }
CpNodeJSSharpOperationModulateOptions >> brightness: aNumber [

	"Brightness multiplier.

	Type: Number"

	options at: #brightness put: aNumber
]

{ #category : #accessing }
CpNodeJSSharpOperationModulateOptions >> hue [

	"Degrees for hue rotation.

	Type: Number"

	^ options at: #hue
]

{ #category : #accessing }
CpNodeJSSharpOperationModulateOptions >> hue: aNumber [

	"Degrees for hue rotation.

	Type: Number"

	options at: #hue put: aNumber
]

{ #category : #accessing }
CpNodeJSSharpOperationModulateOptions >> lightness [

	"Lightness addend.

	Type: Number"

	^ options at: #lightness
]

{ #category : #accessing }
CpNodeJSSharpOperationModulateOptions >> lightness: aNumber [

	"Lightness addend.

	Type: Number"

	options at: #lightness put: aNumber
]

{ #category : #accessing }
CpNodeJSSharpOperationModulateOptions >> saturation [

	"Saturation multiplier.

	Type: Number"

	^ options at: #saturation
]

{ #category : #accessing }
CpNodeJSSharpOperationModulateOptions >> saturation: aNumber [

	"Saturation multiplier.

	Type: Number"

	options at: #saturation put: aNumber
]
