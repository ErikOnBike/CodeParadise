Class {
	#name : #CpNodeJSSharpOperationSharpenOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpOperationSharpenOptions >> m1 [

	"The level of sharpening to apply to ""flat"" areas, between 0 and 1000000.

	Type: Number
	Default: 1.0"

	^ options at: #m1
]

{ #category : #accessing }
CpNodeJSSharpOperationSharpenOptions >> m1: aNumber [

	"The level of sharpening to apply to ""flat"" areas, between 0 and 1000000.

	Type: Number
	Default: 1.0"

	options at: #m1 put: aNumber
]

{ #category : #accessing }
CpNodeJSSharpOperationSharpenOptions >> m2 [

	"The level of sharpening to apply to ""jagged"" areas, between 0 and 1000000.

	Type: Number
	Default: 2.0"

	^ options at: #m2
]

{ #category : #accessing }
CpNodeJSSharpOperationSharpenOptions >> m2: aNumber [

	"The level of sharpening to apply to ""jagged"" areas, between 0 and 1000000.

	Type: Number
	Default: 2.0"

	options at: #m2 put: aNumber
]

{ #category : #accessing }
CpNodeJSSharpOperationSharpenOptions >> sigma [

	"The sigma of the Gaussian mask, where sigma = 1 + radius / 2, between 0.000001 and 10.

	Type: aNumber"

	^ options at: #sigma
]

{ #category : #accessing }
CpNodeJSSharpOperationSharpenOptions >> sigma: aaNumber [

	"The sigma of the Gaussian mask, where sigma = 1 + radius / 2, between 0.000001 and 10.

	Type: aNumber"

	options at: #sigma put: aaNumber
]

{ #category : #accessing }
CpNodeJSSharpOperationSharpenOptions >> x1 [

	"Threshold between ""flat"" and ""jagged"", between 0 and 1000000.

	Type: Number
	Default: 2.0"

	^ options at: #x1
]

{ #category : #accessing }
CpNodeJSSharpOperationSharpenOptions >> x1: aNumber [

	"Threshold between ""flat"" and ""jagged"", between 0 and 1000000.

	Type: Number
	Default: 2.0"

	options at: #x1 put: aNumber
]

{ #category : #accessing }
CpNodeJSSharpOperationSharpenOptions >> y2 [

	"Maximum amount of brightening, between 0 and 1000000.

	Type: Number
	Default: 10.0"

	^ options at: #y2
]

{ #category : #accessing }
CpNodeJSSharpOperationSharpenOptions >> y2: aNumber [

	"Maximum amount of brightening, between 0 and 1000000.

	Type: Number
	Default: 10.0"

	options at: #y2 put: aNumber
]

{ #category : #accessing }
CpNodeJSSharpOperationSharpenOptions >> y3 [

	"Maximum amount of darkening, between 0 and 1000000.

	Type: Number
	Default: 20.0"

	^ options at: #y3
]

{ #category : #accessing }
CpNodeJSSharpOperationSharpenOptions >> y3: aNumber [

	"Maximum amount of darkening, between 0 and 1000000.

	Type: Number
	Default: 20.0"

	options at: #y3 put: aNumber
]
