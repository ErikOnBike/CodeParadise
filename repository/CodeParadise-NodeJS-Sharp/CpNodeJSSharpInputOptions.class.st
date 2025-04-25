Class {
	#name : #CpNodeJSSharpInputOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpInputOptions >> animated [

	"Set to true to read all frames/pages of an animated image (GIF, WebP, TIFF), equivalent of setting pages to -1.

	Type: Boolean
	Default: false"

	^ options at: #animated
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> animated: aBoolean [

	"Set to true to read all frames/pages of an animated image (GIF, WebP, TIFF), equivalent of setting pages to -1."

	options at: #animated put: aBoolean
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> create [

	"Describes a new image to be created.

	Type: InputCreateOptions"

	^ options at: #create
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> create: anInputCreateOptions [

	"Describes a new image to be created."

	options at: #create put: anInputCreateOptions
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> density [

	"Number representing the DPI for vector images in the range 1 to 100000.

	Type: Integer
	Defaukt: 72"

	^ options at: #density
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> density: anInteger [

	"Number representing the DPI for vector images in the range 1 to 100000."

	options at: #density put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> failOn [

	"When to abort processing of invalid pixel data, one of (in order of sensitivity, least to most): 'none', 'truncated', 'error', 'warning'. Higher levels imply lower levels. Invalid metadata will always abort.

	Type: String
	Default: 'warning'"

	^ options at: #failOn
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> failOn: aString [

	"When to abort processing of invalid pixel data, one of (in order of sensitivity, least to most): 'none', 'truncated', 'error', 'warning'. Higher levels imply lower levels. Invalid metadata will always abort."

	options at: #failOn put: aString
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> ignoreIcc [

	"Should the embedded ICC profile, if any, be ignored.

	Type: Boolean
	Default: false"

	^ options at: #ignoreIcc
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> ignoreIcc: aBoolean [

	"Should the embedded ICC profile, if any, be ignored."

	options at: #ignoreIcc put: aBoolean
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> level [

	"Level to extract from a multi-level input (OpenSlide), zero based.

	Type: Integer
	Default: 0"

	^ options at: #level
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> level: anInteger [

	"Level to extract from a multi-level input (OpenSlide), zero based."

	options at: #level put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> limitInputPixels [

	"Do not process input images where the number of pixels (width x height) exceeds this limit. Assumes image dimensions contained in the input metadata can be trusted. An integral Number of pixels, zero or false to remove limit, true to use default limit of 268402689 (0x3FFF x 0x3FFF).

	Type: Integer | Boolean
	Default: true"

	^ options at: #limitInputPixels
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> limitInputPixels: anIntegerOrBoolean [

	"Do not process input images where the number of pixels (width x height) exceeds this limit. Assumes image dimensions contained in the input metadata can be trusted. An integral Number of pixels, zero or false to remove limit, true to use default limit of 268402689 (0x3FFF x 0x3FFF)."

	options at: #limitInputPixels put: anIntegerOrBoolean
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> noise [

	"Describes a noise to be created.

	Type: InputCreateNoiseOptions"

	^ options at: #noise
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> noise: anInputCreateNoiseOptions [

	"Describes a noise to be created."

	options at: #noise put: anInputCreateNoiseOptions
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> page [

	"Page number to start extracting from for multi-page input (GIF, WebP, TIFF), zero based.

	Type: Integer
	Default: 0"

	^ options at: #page
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> page: anInteger [

	"Page number to start extracting from for multi-page input (GIF, WebP, TIFF), zero based."

	options at: #page put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> pages [

	"Number of pages to extract for multi-page input (GIF, WebP, TIFF), use -1 for all pages.

	Type: Integer
	Default: 1"

	^ options at: #pages
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> pages: anInteger [

	"Number of pages to extract for multi-page input (GIF, WebP, TIFF), use -1 for all pages."

	options at: #pages put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> raw [

	"Describes raw pixel input image data. See raw() for pixel ordering.

	Type: InputRawOptions"

	^ options at: #raw
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> raw: anInputRawOptions [

	"Describes raw pixel input image data. See raw() for pixel ordering."

	options at: #raw put: anInputRawOptions
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> sequentialRead [

	"Set this to false to use random access rather than sequential read. Some operations will do this automatically.

	Type: Boolean
	Default: true"

	^ options at: #sequentialRead
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> sequentialRead: aBoolean [

	"Set this to false to use random access rather than sequential read. Some operations will do this automatically."

	options at: #sequentialRead put: aBoolean
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> subIfd [

	"subIFD (Sub Image File Directory) to extract for OME-TIFF, defaults to main image.

	Type: Integer
	Default: -1"

	^ options at: #subIfd
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> subIfd: anInteger [

	"subIFD (Sub Image File Directory) to extract for OME-TIFF, defaults to main image."

	options at: #subIfd put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> text [

	"Describes a new text image to be created.

	Type: InputTextOptions"

	^ options at: #text
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> text: anInputTextOptions [

	"Describes a new text image to be created."

	options at: #text put: anInputTextOptions
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> unlimited [

	"Set this to true to remove safety features that help prevent memory exhaustion (JPEG, PNG, SVG, HEIF).

	Type: Boolean
	Default: false"

	^ options at: #unlimited
]

{ #category : #accessing }
CpNodeJSSharpInputOptions >> unlimited: aBoolean [

	"Set this to true to remove safety features that help prevent memory exhaustion (JPEG, PNG, SVG, HEIF)."

	options at: #unlimited put: aBoolean
]
