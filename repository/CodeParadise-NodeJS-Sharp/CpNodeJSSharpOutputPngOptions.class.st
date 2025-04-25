Class {
	#name : #CpNodeJSSharpOutputPngOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpOutputPngOptions >> adaptiveFiltering [

	"Use adaptive row filtering.

	Type: Boolean
	Default: false"

	^ options at: #adaptiveFiltering
]

{ #category : #accessing }
CpNodeJSSharpOutputPngOptions >> adaptiveFiltering: aBoolean [

	"Use adaptive row filtering.

	Type: Boolean
	Default: false"

	options at: #adaptiveFiltering put: aBoolean
]

{ #category : #accessing }
CpNodeJSSharpOutputPngOptions >> colors [

	"Maximum number of palette entries, sets palette to true.

	Type: Integer
	Default: 256"

	^ options at: #colors
]

{ #category : #accessing }
CpNodeJSSharpOutputPngOptions >> colors: anInteger [

	"Maximum number of palette entries, sets palette to true.

	Type: Integer
	Default: 256"

	options at: #colors put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpOutputPngOptions >> compressionLevel [

	"zlib compression level, 0 (fastest, largest) to 9 (slowest, smallest).

	Type: Integer
	Default: 6"

	^ options at: #compressionLevel
]

{ #category : #accessing }
CpNodeJSSharpOutputPngOptions >> compressionLevel: anInteger [

	"zlib compression level, 0 (fastest, largest) to 9 (slowest, smallest).

	Type: Integer
	Default: 6"

	options at: #compressionLevel put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpOutputPngOptions >> dither [

	"Level of Floyd-Steinberg error diffusion, sets palette to true.

	Type: Number
	Default: 1.0"

	^ options at: #dither
]

{ #category : #accessing }
CpNodeJSSharpOutputPngOptions >> dither: aNumber [

	"Level of Floyd-Steinberg error diffusion, sets palette to true.

	Type: Number
	Default: 1.0"

	options at: #dither put: aNumber
]

{ #category : #accessing }
CpNodeJSSharpOutputPngOptions >> effort [

	"CPU effort, between 1 (fastest) and 10 (slowest), sets palette to true.

	Type: Integer
	Default: 7"

	^ options at: #effort
]

{ #category : #accessing }
CpNodeJSSharpOutputPngOptions >> effort: anInteger [

	"CPU effort, between 1 (fastest) and 10 (slowest), sets palette to true.

	Type: Integer
	Default: 7"

	options at: #effort put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpOutputPngOptions >> force [

	"Force PNG output, otherwise attempt to use input format.

	Type: Boolean
	Default: true"

	^ options at: #force
]

{ #category : #accessing }
CpNodeJSSharpOutputPngOptions >> force: aBoolean [

	"Force PNG output, otherwise attempt to use input format.

	Type: Boolean
	Default: true"

	options at: #force put: aBoolean
]

{ #category : #accessing }
CpNodeJSSharpOutputPngOptions >> palette [

	"Quantise to a palette-based image with alpha transparency support.

	Type: Boolean
	Default: false"

	^ options at: #palette
]

{ #category : #accessing }
CpNodeJSSharpOutputPngOptions >> palette: aBoolean [

	"Quantise to a palette-based image with alpha transparency support.

	Type: Boolean
	Default: false"

	options at: #palette put: aBoolean
]

{ #category : #accessing }
CpNodeJSSharpOutputPngOptions >> progressive [

	"Use progressive (interlace) scan.

	Type: Boolean
	Default: false"

	^ options at: #progressive
]

{ #category : #accessing }
CpNodeJSSharpOutputPngOptions >> progressive: aBoolean [

	"Use progressive (interlace) scan.

	Type: Boolean
	Default: false"

	options at: #progressive put: aBoolean
]

{ #category : #accessing }
CpNodeJSSharpOutputPngOptions >> quality [

	"Use the lowest number of colours needed to achieve given quality, sets palette to true.

	Type: Integer
	Default: 100"

	^ options at: #quality
]

{ #category : #accessing }
CpNodeJSSharpOutputPngOptions >> quality: anInteger [

	"Use the lowest number of colours needed to achieve given quality, sets palette to true.

	Type: Integer
	Default: 100"

	options at: #quality put: anInteger
]
