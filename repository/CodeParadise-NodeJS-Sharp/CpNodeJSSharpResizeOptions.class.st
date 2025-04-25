Class {
	#name : #CpNodeJSSharpResizeOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpResizeOptions >> background [

	"Background colour when fit is contain, parsed by the color  module, defaults to black without transparency.

	Type: Object | String
	Default: {r: 0, g: 0, b: 0, alpha: 1}"

	^ options at: #background
]

{ #category : #accessing }
CpNodeJSSharpResizeOptions >> background: anObject [

	"Background colour when fit is contain, parsed by the color  module, defaults to black without transparency.

	Type: Object | String
	Default: {r: 0, g: 0, b: 0, alpha: 1}"

	options at: #background put: anObject
]

{ #category : #accessing }
CpNodeJSSharpResizeOptions >> fastShrinkOnLoad [

	"Take greater advantage of the JPEG and WebP shrink-on-load feature, which can lead to a slight moiré pattern or round-down of an auto-scaled dimension.

	Type: Boolean
	Default: true"

	^ options at: #fastShrinkOnLoad
]

{ #category : #accessing }
CpNodeJSSharpResizeOptions >> fastShrinkOnLoad: aBoolean [

	"Take greater advantage of the JPEG and WebP shrink-on-load feature, which can lead to a slight moiré pattern or round-down of an auto-scaled dimension.

	Type: Boolean
	Default: true"

	options at: #fastShrinkOnLoad put: aBoolean
]

{ #category : #accessing }
CpNodeJSSharpResizeOptions >> fit [

	"How the image should be resized/cropped to fit the target dimension(s), one of cover, contain, fill, inside or outside.

	When both a width and height are provided, the possible methods by which the image should fit these are:

	cover: (default) Preserving aspect ratio, attempt to ensure the image covers both provided dimensions by cropping/clipping to fit.
	contain: Preserving aspect ratio, contain within both provided dimensions using ""letterboxing"" where necessary.
	fill: Ignore the aspect ratio of the input and stretch to both provided dimensions.
	inside: Preserving aspect ratio, resize the image to be as large as possible while ensuring its dimensions are less than or equal to both those specified.
	outside: Preserving aspect ratio, resize the image to be as small as possible while ensuring its dimensions are greater than or equal to both those specified.

	Type: String
	Defaul: 'cover'"

	^ options at: #fit
]

{ #category : #accessing }
CpNodeJSSharpResizeOptions >> fit: aString [

	"How the image should be resized/cropped to fit the target dimension(s), one of cover, contain, fill, inside or outside.

	When both a width and height are provided, the possible methods by which the image should fit these are:

	cover: (default) Preserving aspect ratio, attempt to ensure the image covers both provided dimensions by cropping/clipping to fit.
	contain: Preserving aspect ratio, contain within both provided dimensions using ""letterboxing"" where necessary.
	fill: Ignore the aspect ratio of the input and stretch to both provided dimensions.
	inside: Preserving aspect ratio, resize the image to be as large as possible while ensuring its dimensions are less than or equal to both those specified.
	outside: Preserving aspect ratio, resize the image to be as small as possible while ensuring its dimensions are greater than or equal to both those specified.

	Type: String
	Defaul: 'cover'"

	options at: #fit put: aString
]

{ #category : #accessing }
CpNodeJSSharpResizeOptions >> height [

	"An alternative means of specifying height. If both are present this takes priority.

	Type: Integer"

	^ options at: #height
]

{ #category : #accessing }
CpNodeJSSharpResizeOptions >> height: anInteger [

	"An alternative means of specifying height. If both are present this takes priority.

	Type: Integer"

	options at: #height put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpResizeOptions >> kernel [

	"The kernel to use for image reduction and the inferred interpolator to use for upsampling. Use the fastShrinkOnLoad option to control kernel vs shrink-on-load.

	Possible downsizing kernels are:

	nearest: Use nearest neighbour interpolation .
	linear: Use a triangle filter .
	cubic: Use a Catmull-Rom spline .
	mitchell: Use a Mitchell-Netravali spline .
	lanczos2: Use a Lanczos kernel  with a=2.
	lanczos3: Use a Lanczos kernel with a=3 (the default).
	When upsampling, these kernels map to nearest, linear and cubic interpolators. Downsampling kernels without a matching upsampling interpolator map to cubic.

	Type: String
	Default: 'lanczos3'"

	^ options at: #kernel
]

{ #category : #accessing }
CpNodeJSSharpResizeOptions >> kernel: aString [

	"The kernel to use for image reduction and the inferred interpolator to use for upsampling. Use the fastShrinkOnLoad option to control kernel vs shrink-on-load.

	Possible downsizing kernels are:

	nearest: Use nearest neighbour interpolation .
	linear: Use a triangle filter .
	cubic: Use a Catmull-Rom spline .
	mitchell: Use a Mitchell-Netravali spline .
	lanczos2: Use a Lanczos kernel  with a=2.
	lanczos3: Use a Lanczos kernel with a=3 (the default).
	When upsampling, these kernels map to nearest, linear and cubic interpolators. Downsampling kernels without a matching upsampling interpolator map to cubic.

	Type: String
	Default: 'lanczos3'"

	options at: #kernel put: aString
]

{ #category : #accessing }
CpNodeJSSharpResizeOptions >> position [

	"A position, gravity or strategy to use when fit is cover or contain.

	When using a fit of cover or contain, the default position is centre. Other options are:

	sharp.position: top, right top, right, right bottom, bottom, left bottom, left, left top.
	sharp.gravity: north, northeast, east, southeast, south, southwest, west, northwest, center or centre.
	sharp.strategy: cover only, dynamically crop using either the entropy or attention strategy.

	Some of these values are based on the object-position  CSS property.

	The strategy-based approach initially resizes so one dimension is at its target length then repeatedly ranks edge regions, discarding the edge with the lowest score based on the selected strategy.

	entropy: focus on the region with the highest Shannon entropy .
	attention: focus on the region with the highest luminance frequency, colour saturation and presence of skin tones.

	Type: String
	Default: 'centre'"

	^ options at: #position
]

{ #category : #accessing }
CpNodeJSSharpResizeOptions >> position: aString [

	"A position, gravity or strategy to use when fit is cover or contain.

	When using a fit of cover or contain, the default position is centre. Other options are:

	sharp.position: top, right top, right, right bottom, bottom, left bottom, left, left top.
	sharp.gravity: north, northeast, east, southeast, south, southwest, west, northwest, center or centre.
	sharp.strategy: cover only, dynamically crop using either the entropy or attention strategy.

	Some of these values are based on the object-position  CSS property.

	The strategy-based approach initially resizes so one dimension is at its target length then repeatedly ranks edge regions, discarding the edge with the lowest score based on the selected strategy.

	entropy: focus on the region with the highest Shannon entropy .
	attention: focus on the region with the highest luminance frequency, colour saturation and presence of skin tones.

	Type: String
	Default: 'centre'"

	options at: #position put: aString
]

{ #category : #accessing }
CpNodeJSSharpResizeOptions >> width [

	"An alternative means of specifying width. If both are present this takes priority.

	Type: Integer"

	^ options at: #width
]

{ #category : #accessing }
CpNodeJSSharpResizeOptions >> width: anInteger [

	"An alternative means of specifying width. If both are present this takes priority.

	Type: Integer"

	options at: #width put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpResizeOptions >> withoutEnlargement [

	"Do not scale up if the width or height are already less than the target dimensions, equivalent to GraphicsMagick's > geometry option. This may result in output dimensions smaller than the target dimensions.

	Type: Boolean
	Default: false"

	^ options at: #withoutEnlargement
]

{ #category : #accessing }
CpNodeJSSharpResizeOptions >> withoutEnlargement: aBoolean [

	"Do not scale up if the width or height are already less than the target dimensions, equivalent to GraphicsMagick's > geometry option. This may result in output dimensions smaller than the target dimensions.

	Type: Boolean
	Default: false"

	options at: #withoutEnlargement put: aBoolean
]

{ #category : #accessing }
CpNodeJSSharpResizeOptions >> withoutReduction [

	"Do not scale down if the width or height are already greater than the target dimensions, equivalent to GraphicsMagick's < geometry option. This may still result in a crop to reach the target dimensions.

	Type: Boolean
	Default: false"

	^ options at: #withoutReduction
]

{ #category : #accessing }
CpNodeJSSharpResizeOptions >> withoutReduction: aBoolean [

	"Do not scale down if the width or height are already greater than the target dimensions, equivalent to GraphicsMagick's < geometry option. This may still result in a crop to reach the target dimensions.

	Type: Boolean
	Default: false"

	options at: #withoutReduction put: aBoolean
]
