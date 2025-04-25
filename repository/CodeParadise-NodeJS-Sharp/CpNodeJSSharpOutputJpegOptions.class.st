Class {
	#name : #CpNodeJSSharpOutputJpegOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpOutputJpegOptions >> chromaSubsampling [

	"Set to '4:4:4' to prevent chroma subsampling otherwise defaults to '4:2:0' chroma subsampling.

	Type: String
	Default: '4:2:0'"

	^ options at: #chromaSubsampling
]

{ #category : #accessing }
CpNodeJSSharpOutputJpegOptions >> chromaSubsampling: aString [

	"Set to '4:4:4' to prevent chroma subsampling otherwise defaults to '4:2:0' chroma subsampling.

	Type: String
	Default: '4:2:0'"

	options at: #chromaSubsampling put: aString
]

{ #category : #accessing }
CpNodeJSSharpOutputJpegOptions >> force [

	"Force JPEG output, otherwise attempt to use input format.

	Type: Boolean
	Default: true"

	^ options at: #force
]

{ #category : #accessing }
CpNodeJSSharpOutputJpegOptions >> force: aBoolean [

	"Force JPEG output, otherwise attempt to use input format.

	Type: Boolean
	Default: true"

	options at: #force put: aBoolean
]

{ #category : #accessing }
CpNodeJSSharpOutputJpegOptions >> mozjpeg [

	"Use mozjpeg defaults, equivalent to { trellisQuantisation: true, overshootDeringing: true, optimiseScans: true, quantisationTable: 3 }.

	Type: Boolean
	Default: false"

	^ options at: #mozjpeg
]

{ #category : #accessing }
CpNodeJSSharpOutputJpegOptions >> mozjpeg: aBoolean [

	"Use mozjpeg defaults, equivalent to { trellisQuantisation: true, overshootDeringing: true, optimiseScans: true, quantisationTable: 3 }.

	Type: Boolean
	Default: false"

	options at: #mozjpeg put: aBoolean
]

{ #category : #accessing }
CpNodeJSSharpOutputJpegOptions >> optimizeCoding [

	"Optimise Huffman coding tables.

	Type: Boolean
	Default: true"

	^ options at: #optimizeCoding
]

{ #category : #accessing }
CpNodeJSSharpOutputJpegOptions >> optimizeCoding: aBoolean [

	"Optimise Huffman coding tables.

	Type: Boolean
	Default: true"

	options at: #optimizeCoding put: aBoolean
]

{ #category : #accessing }
CpNodeJSSharpOutputJpegOptions >> optimizeScans [

	"Optimise progressive scans, forces progressive.

	Type: Boolean
	Default: false"

	^ options at: #optimizeScans
]

{ #category : #accessing }
CpNodeJSSharpOutputJpegOptions >> optimizeScans: aBoolean [

	"Optimise progressive scans, forces progressive.

	Type: Boolean
	Default: false"

	options at: #optimizeScans put: aBoolean
]

{ #category : #accessing }
CpNodeJSSharpOutputJpegOptions >> overshootDeringing [

	"Apply overshoot deringing.

	Type: Boolean
	Default: false"

	^ options at: #overshootDeringing
]

{ #category : #accessing }
CpNodeJSSharpOutputJpegOptions >> overshootDeringing: aBoolean [

	"Apply overshoot deringing.

	Type: Boolean
	Default: false"

	options at: #overshootDeringing put: aBoolean
]

{ #category : #accessing }
CpNodeJSSharpOutputJpegOptions >> progressive [

	"Use progressive (interlace) scan.

	Type: Boolean
	Default: false"

	^ options at: #progressive
]

{ #category : #accessing }
CpNodeJSSharpOutputJpegOptions >> progressive: aBoolean [

	"Use progressive (interlace) scan.

	Type: Boolean
	Default: false"

	options at: #progressive put: aBoolean
]

{ #category : #accessing }
CpNodeJSSharpOutputJpegOptions >> quality [

	"Quality, integer 1-100.

	Type: Integer
	Default: 80"

	^ options at: #quality
]

{ #category : #accessing }
CpNodeJSSharpOutputJpegOptions >> quality: anInteger [

	"Quality, integer 1-100.

	Type: Integer
	Default: 80"

	options at: #quality put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpOutputJpegOptions >> quantizationTable [

	"Quantization table to use, integer 0-8.

	Type: Integer
	Default: 0"

	^ options at: #quantizationTable
]

{ #category : #accessing }
CpNodeJSSharpOutputJpegOptions >> quantizationTable: anInteger [

	"Quantization table to use, integer 0-8.

	Type: Integer
	Default: 0"

	options at: #quantizationTable put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpOutputJpegOptions >> trellisQuantisation [

	"Apply trellis quantisation.

	Type: Boolean
	Default: false"

	^ options at: #trellisQuantisation
]

{ #category : #accessing }
CpNodeJSSharpOutputJpegOptions >> trellisQuantisation: aBoolean [

	"Apply trellis quantisation.

	Type: Boolean
	Default: false"

	options at: #trellisQuantisation put: aBoolean
]
