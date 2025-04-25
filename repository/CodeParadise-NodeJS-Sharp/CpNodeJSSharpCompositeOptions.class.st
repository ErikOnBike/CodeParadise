Class {
	#name : #CpNodeJSSharpCompositeOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> animated [

	"Set to true to read all frames/pages of an animated image.

	Type: Boolean
	Default: false"

	^ options at: #animated
]

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> animated: aBoolean [

	"Set to true to read all frames/pages of an animated image.

	Type: Boolean
	Default: false"

	options at: #animated put: aBoolean
]

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> blend [

	"How to blend this image with the image below.

	The blend option can be one of clear, source, over, in, out, atop, dest, dest-over, dest-in, dest-out, dest-atop, xor, add, saturate, multiply, screen, overlay, darken, lighten, colour-dodge, color-dodge, colour-burn,color-burn, hard-light, soft-light, difference, exclusion.

	More information about blend modes can be found at https://www.libvips.org/API/current/libvips-conversion.html#VipsBlendMode  and https://www.cairographics.org/operators/ 

	Type: String
	Default: 'over'"

	^ options at: #blend
]

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> blend: aString [

	"How to blend this image with the image below.

	The blend option can be one of clear, source, over, in, out, atop, dest, dest-over, dest-in, dest-out, dest-atop, xor, add, saturate, multiply, screen, overlay, darken, lighten, colour-dodge, color-dodge, colour-burn,color-burn, hard-light, soft-light, difference, exclusion.

	More information about blend modes can be found at https://www.libvips.org/API/current/libvips-conversion.html#VipsBlendMode  and https://www.cairographics.org/operators/ 

	Type: String
	Default: 'over'"

	options at: #blend put: aString
]

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> density [

	"Number representing the DPI for vector overlay image.

	Type: Integer
	Default: 72"

	^ options at: #density
]

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> density: anInteger [

	"Number representing the DPI for vector overlay image.

	Type: Integer
	Default: 72"

	options at: #density put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> failOn [

	"When to abort processing of invalid pixel data, one of (in order of sensitivity, least to most): 'none', 'truncated', 'error', 'warning'. Higher levels imply lower levels. Invalid metadata will always abort.

	Type: String
	Default: 'warning'"

	^ options at: #failOn
]

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> failOn: aString [

	"When to abort processing of invalid pixel data, one of (in order of sensitivity, least to most): 'none', 'truncated', 'error', 'warning'. Higher levels imply lower levels. Invalid metadata will always abort.

	Type: String
	Default: 'warning'"

	options at: #failOn put: aString
]

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> gravity [

	"Gravity at which to place the overlay.

	Type: String
	Default: 'centre'"

	^ options at: #gravity
]

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> gravity: aString [

	"Gravity at which to place the overlay.

	Type: String
	Default: 'centre'"

	options at: #gravity put: aString
]

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> input [

	"Buffer containing image data, String containing the path to an image file, or Create object (see below).

	Type: Buffer | String | CompositeImageOptions"

	^ options at: #input
]

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> input: aBuffer [

	"Buffer containing image data, String containing the path to an image file, or Create object (see below).

	Type: Buffer | String | CompositeImageOptions"

	options at: #input put: aBuffer
]

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> left [

	"The pixel offset from the left edge.

	Type: Integer"

	^ options at: #left
]

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> left: anInteger [

	"The pixel offset from the left edge.

	Type: Integer"

	options at: #left put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> limitInputPixels [

	"Do not process input images where the number of pixels (width x height) exceeds this limit. Assumes image dimensions contained in the input metadata can be trusted. An integral Number of pixels, zero or false to remove limit, true to use default limit of 268402689 (0x3FFF x 0x3FFF).

	Type: Integer|Boolean
	Default: true"

	^ options at: #limitInputPixels
]

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> premultiplied [

	"Set to true to avoid premultiplying the image below. Equivalent to the --premultiplied vips option.

	Type: Boolean
	Default: false"

	^ options at: #premultiplied
]

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> premultiplied: aBoolean [

	"Set to true to avoid premultiplying the image below. Equivalent to the --premultiplied vips option.

	Type: Boolean
	Default: false"

	options at: #premultiplied put: aBoolean
]

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> raw [

	"Describes overlay when using raw pixel data.

	Type: InputRawOptions"

	^ options at: #raw
]

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> raw: anInputRawOptions [

	"Describes overlay when using raw pixel data.

	Type: InputRawOptions"

	options at: #raw put: anInputRawOptions
]

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> tile [

	"Set to true to repeat the overlay image across the entire image with the given gravity.

	Type: Boolean
	Default: false"

	^ options at: #tile
]

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> tile: aBoolean [

	"Set to true to repeat the overlay image across the entire image with the given gravity.

	Type: Boolean
	Default: false"

	options at: #tile put: aBoolean
]

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> top [

	"The pixel offset from the top edge.

	Type: Integer"

	^ options at: #top
]

{ #category : #accessing }
CpNodeJSSharpCompositeOptions >> top: anInteger [

	"The pixel offset from the top edge.

	Type: Integer"

	options at: #top put: anInteger
]
