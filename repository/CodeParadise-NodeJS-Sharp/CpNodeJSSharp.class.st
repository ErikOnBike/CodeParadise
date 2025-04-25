Class {
	#name : #CpNodeJSSharp,
	#superclass : #CpNodeJSStreamDuplex,
	#category : #'CodeParadise-NodeJS-Sharp-Core'
}

{ #category : #accessing }
CpNodeJSSharp class >> block: aBlockOptions [

	"Block libvips operations at runtime.

	This is in addition to the VIPS_BLOCK_UNTRUSTED environment variable, which when set will block all ""untrusted"" operations."

	^ self getClass
		apply: #block withArguments: { aBlockOptions }
]

{ #category : #accessing }
CpNodeJSSharp class >> cache [

	"Gets or, when options are provided, sets the limits of libvips' operation cache. Existing entries in the cache will be trimmed after any change in limits. This method always returns cache statistics, useful for determining how much working memory is required for a particular task."

	^ self getClass
		apply: #cache
]

{ #category : #accessing }
CpNodeJSSharp class >> cache: aCacheOptions [

	"Gets or, when options are provided, sets the limits of libvips' operation cache. Existing entries in the cache will be trimmed after any change in limits. This method always returns cache statistics, useful for determining how much working memory is required for a particular task."

	^ self getClass
		apply: #cache withArguments: { aCacheOptions }
]

{ #category : #accessing }
CpNodeJSSharp class >> concurrency [

	"Gets or, when a concurrency is provided, sets the maximum number of threads libvips should use to process each image. These are from a thread pool managed by glib, which helps avoid the overhead of creating new threads.

	This method always returns the current concurrency.

	The default value is the number of CPU cores, except when using glibc-based Linux without jemalloc, where the default is 1 to help reduce memory fragmentation.

	A value of 0 will reset this to the number of CPU cores.

	Some image format libraries spawn additional threads, e.g. libaom manages its own 4 threads when encoding AVIF images, and these are independent of the value set here.

	The maximum number of images that sharp can process in parallel is controlled by libuv's UV_THREADPOOL_SIZE environment variable, which defaults to 4.

	https://nodejs.org/api/cli.html#uv_threadpool_sizesize 

	For example, by default, a machine with 8 CPU cores will process 4 images in parallel and use up to 8 threads per image, so there will be up to 32 concurrent threads.

	Returns: Integer - concurrency"

	^ self getClass
		apply: #concurrency
]

{ #category : #accessing }
CpNodeJSSharp class >> concurrency: anInteger [

	"Gets or, when a concurrency is provided, sets the maximum number of threads libvips should use to process each image. These are from a thread pool managed by glib, which helps avoid the overhead of creating new threads.

	This method always returns the current concurrency.

	The default value is the number of CPU cores, except when using glibc-based Linux without jemalloc, where the default is 1 to help reduce memory fragmentation.

	A value of 0 will reset this to the number of CPU cores.

	Some image format libraries spawn additional threads, e.g. libaom manages its own 4 threads when encoding AVIF images, and these are independent of the value set here.

	The maximum number of images that sharp can process in parallel is controlled by libuv's UV_THREADPOOL_SIZE environment variable, which defaults to 4.

	https://nodejs.org/api/cli.html#uv_threadpool_sizesize 

	For example, by default, a machine with 8 CPU cores will process 4 images in parallel and use up to 8 threads per image, so there will be up to 32 concurrent threads.

	Returns: Integer - concurrency"

	^ self getClass
		apply: #concurrency withArguments: { anInteger }
]

{ #category : #accessing }
CpNodeJSSharp class >> counters [

	"Provides access to internal task counters.

	queue is the number of tasks this module has queued waiting for libuv to provide a worker thread from its pool.
	process is the number of resize tasks currently being processed."

	^ self getClass
		apply: #counters
]

{ #category : #accessing }
CpNodeJSSharp class >> format [

	"An Object containing nested boolean values representing the available input and output formats/methods."

	^ self getClass
		propertyAt: #format
]

{ #category : #accessing }
CpNodeJSSharp class >> getClass [

	"The receiver's constructor is answered by the module"

	^ CpNodeJSSharpModule require as: CpJavaScriptClass
]

{ #category : #'instance creation' }
CpNodeJSSharp class >> input: anObject [

	^ self input: anObject options: Dictionary new
]

{ #category : #'instance creation' }
CpNodeJSSharp class >> input: anObject options: anInputOptions [

	"Constructor factory to create an instance of sharp, to which further methods are chained.

	JPEG, PNG, WebP, GIF, AVIF or TIFF format image data can be streamed out from this object.
	When using Stream based output, derived attributes are available from the info event.

	Non-critical problems encountered during processing are emitted as warning events.

	Implements the stream.Duplex  class.

	When loading more than one page/frame of an animated image, these are combined as a
	vertically-stacked ""toilet roll"" image where the overall height is the pageHeight multiplied
	by the number of pages."

	^ self newInstanceWithArguments: { anObject . anInputOptions asDictionary }
]

{ #category : #accessing }
CpNodeJSSharp class >> interpolators [

	"An Object containing the available interpolators and their proper values."

	^ self getClass
		propertyAt: #interpolators
]

{ #category : #accessing }
CpNodeJSSharp class >> queue [

	"An EventEmitter that emits a change event when a task is either:

	queued, waiting for libuv to provide a worker thread
	complete"

	^ self getClass
		propertyAt: #format resultAs: CpNodeJSEventEmitter
]

{ #category : #accessing }
CpNodeJSSharp class >> simd [

	"Get and set use of SIMD vector unit instructions. Requires libvips to have been compiled with highway support.

	Improves the performance of resize, blur and sharpen operations by taking advantage of the SIMD vector unit of the CPU, e.g. Intel SSE and ARM NEON."

	^ self getClass
		apply: #simd
]

{ #category : #accessing }
CpNodeJSSharp class >> simd: aBoolean [

	"Get and set use of SIMD vector unit instructions. Requires libvips to have been compiled with highway support.

	Improves the performance of resize, blur and sharpen operations by taking advantage of the SIMD vector unit of the CPU, e.g. Intel SSE and ARM NEON."

	^ self getClass
		apply: #simd withArguments: { aBoolean }
]

{ #category : #accessing }
CpNodeJSSharp class >> unblock: aBlockOptions [

	"Unblock libvips operations at runtime.

	This is useful for defining a list of allowed operations."

	^ self getClass
		apply: #unblock withArguments: { aBlockOptions }
]

{ #category : #accessing }
CpNodeJSSharp class >> versions [

	"An Object containing the version numbers of sharp, libvips and (when using prebuilt binaries) its dependencies."

	^ self getClass
		propertyAt: #versions
]

{ #category : #operations }
CpNodeJSSharp >> affine: anArray [

	"Perform an affine transform on an image. This operation will always occur after resizing, extraction and rotation, if any.

	You must provide an array of length 4 or a 2x2 affine transformation matrix. By default, new pixels are filled with a black background. You can provide a background color with the background option. A particular interpolator may also be specified. Set the interpolator option to an attribute of the sharp.interpolators Object e.g. sharp.interpolators.nohalo.

	In the case of a 2x2 matrix, the transform is:

	X = matrix[0, 0] * (x + idx) + matrix[0, 1] * (y + idy) + odx
	Y = matrix[1, 0] * (x + idx) + matrix[1, 1] * (y + idy) + ody
	where:

	x and y are the coordinates in input image.
	X and Y are the coordinates in output image.
	(0,0) is the upper left corner."

	self apply: #affine withArguments: { anArray }
]

{ #category : #operations }
CpNodeJSSharp >> affine: anArray options: anOperationAffineOptions [

	"Perform an affine transform on an image. This operation will always occur after resizing, extraction and rotation, if any.

	You must provide an array of length 4 or a 2x2 affine transformation matrix. By default, new pixels are filled with a black background. You can provide a background color with the background option. A particular interpolator may also be specified. Set the interpolator option to an attribute of the sharp.interpolators Object e.g. sharp.interpolators.nohalo.

	In the case of a 2x2 matrix, the transform is:

	X = matrix[0, 0] * (x + idx) + matrix[0, 1] * (y + idy) + odx
	Y = matrix[1, 0] * (x + idx) + matrix[1, 1] * (y + idy) + ody
	where:

	x and y are the coordinates in input image.
	X and Y are the coordinates in output image.
	(0,0) is the upper left corner."

	self apply: #affine withArguments: { anArray . anOperationAffineOptions asDictionary }
]

{ #category : #coloring }
CpNodeJSSharp >> bandbool: aString [

	"Perform a bitwise boolean operation on all input image channels (bands) to produce a single channel output image."

	self apply: #bandbool withArguments: { aString }
]

{ #category : #operations }
CpNodeJSSharp >> blur [

	"Blur the image.

	When used without parameters, performs a fast 3x3 box blur (equivalent to a box linear filter).

	When a sigma is provided, performs a slower, more accurate Gaussian blur."

	self apply: #blur
]

{ #category : #operations }
CpNodeJSSharp >> blur: anOperationBlurOptions [

	"Blur the image.

	When used without parameters, performs a fast 3x3 box blur (equivalent to a box linear filter).

	When a sigma is provided, performs a slower, more accurate Gaussian blur."

	self apply: #blur withArguments: { anOperationBlurOptions asDictionary }
]

{ #category : #operations }
CpNodeJSSharp >> boolean: aBuffer operator: aString [

	"Perform a bitwise boolean operation with operand image.

	Argument can be: Buffer | String

	This operation creates an output image where each pixel is the result of the selected bitwise boolean operation between the corresponding pixels of the input images."

	self apply: #boolean withArguments: { aBuffer . aString }
]

{ #category : #operations }
CpNodeJSSharp >> boolean: aBuffer operator: aString options: anInputRawOptions [

	"Perform a bitwise boolean operation with operand image.

	Argument can be: Buffer | String

	This operation creates an output image where each pixel is the result of the selected bitwise boolean operation between the corresponding pixels of the input images."

	self apply: #boolean withArguments: { aBuffer . aString . anInputRawOptions asDictionary }
]

{ #category : #operations }
CpNodeJSSharp >> clahe: anOperationClaheOptions [

	"Perform contrast limiting adaptive histogram equalization CLAHE .

	This will, in general, enhance the clarity of the image by bringing out darker details."

	self apply: #clahe withArguments: { anOperationClaheOptions asDictionary }
]

{ #category : #copying }
CpNodeJSSharp >> clone [

	"Take a ""snapshot"" of the Sharp instance, returning a new instance. Cloned instances inherit the input of their parent instance. This allows multiple output Streams and therefore multiple processing pipelines to share a single input Stream."

	^ self apply: #clone resultAs: self class
]

{ #category : #composing }
CpNodeJSSharp >> composite: anArray [

	"Composite image(s) over the processed (resized, extracted etc.) image.

	The images to composite must be the same size or smaller than the processed image. If both top and left options are provided, they take precedence over gravity.

	Any resize, rotate or extract operations in the same processing pipeline will always be applied to the input image before composition."

	self apply: #composite withArguments: { anArray }
]

{ #category : #operations }
CpNodeJSSharp >> convolve: aKernelOptions [

	"Convolve the image with the specified kernel."

	self apply: #convolve withArguments: { aKernelOptions asDictionary }
]

{ #category : #coloring }
CpNodeJSSharp >> ensureAlpha [

	"Ensure the output image has an alpha transparency channel. If missing, the added alpha channel will have the specified transparency level, defaulting to fully-opaque (1). This is a no-op if the image already has an alpha channel."

	self apply: #ensureAlpha
]

{ #category : #coloring }
CpNodeJSSharp >> ensureAlpha: aFloat [

	"Ensure the output image has an alpha transparency channel. If missing, the added alpha channel will have the specified transparency level, defaulting to fully-opaque (1). This is a no-op if the image already has an alpha channel."

	self apply: #ensureAlpha withArguments: { aFloat }
]

{ #category : #resizing }
CpNodeJSSharp >> extend: anExtendOptions [

	"Extend / pad / extrude one or more edges of the image with either the provided background colour or pixels derived from the image. This operation will always occur after resizing and extraction, if any."

	self apply: #extend withArguments: { anExtendOptions asDictionary }
]

{ #category : #resizing }
CpNodeJSSharp >> extendAll: anInteger [

	"Extend / pad / extrude one or more edges of the image with either the provided background colour or pixels derived from the image. This operation will always occur after resizing and extraction, if any.

	Single pixel count to add to all edges or an Object with per-edge counts."

	self apply: #extend withArguments: { anInteger }
]

{ #category : #resizing }
CpNodeJSSharp >> extract: anExtractOptions [

	"Extract/crop a region of the image.

	Use extract before resize for pre-resize extraction.
	Use extract after resize for post-resize extraction.
	Use extract twice and resize once for extract-then-resize-then-extract in a fixed operation order."

	self apply: #extract withArguments: { anExtractOptions asDictionary }
]

{ #category : #coloring }
CpNodeJSSharp >> extractChannel: anInteger [

	"Extract a single channel from a multi-channel image."

	self apply: #extractChannel withArguments: { anInteger }
]

{ #category : #operations }
CpNodeJSSharp >> flatten [

	"Merge alpha transparency channel, if any, with a background, then remove the alpha channel."

	self apply: #flatten
]

{ #category : #operations }
CpNodeJSSharp >> flatten: anOperationOptions [

	"Merge alpha transparency channel, if any, with a background, then remove the alpha channel."

	self apply: #flatten withArguments: { anOperationOptions asDictionary }
]

{ #category : #operations }
CpNodeJSSharp >> flip [

	"Mirror the image vertically (up-down) about the x-axis. This always occurs before rotation, if any.

	This operation does not work correctly with multi-page images."

	self apply: #flip
]

{ #category : #operations }
CpNodeJSSharp >> flip: aBoolean [

	"Mirror the image vertically (up-down) about the x-axis. This always occurs before rotation, if any.

	This operation does not work correctly with multi-page images."

	self apply: #flip withArguments: { aBoolean }
]

{ #category : #operations }
CpNodeJSSharp >> flop [

	"Mirror the image horizontally (left-right) about the y-axis. This always occurs before rotation, if any."

	self apply: #flip
]

{ #category : #operations }
CpNodeJSSharp >> flop: aBoolean [

	"Mirror the image horizontally (left-right) about the y-axis. This always occurs before rotation, if any."

	self apply: #flip withArguments: { aBoolean }
]

{ #category : #operations }
CpNodeJSSharp >> gamma: aNumber [

	"Apply a gamma correction by reducing the encoding (darken) pre-resize at a factor of 1/gamma then increasing the encoding (brighten) post-resize at a factor of gamma. This can improve the perceived brightness of a resized image in non-linear colour spaces. JPEG and WebP input images will not take advantage of the shrink-on-load performance optimisation when applying a gamma correction.

	Supply a second argument to use a different output gamma value, otherwise the first value is used in both cases."

	self apply: #gamma withArguments: { aNumber }
]

{ #category : #operations }
CpNodeJSSharp >> gamma: gammaInputNumber out: gammaOutputNumber [

	"Apply a gamma correction by reducing the encoding (darken) pre-resize at a factor of 1/gamma then increasing the encoding (brighten) post-resize at a factor of gamma. This can improve the perceived brightness of a resized image in non-linear colour spaces. JPEG and WebP input images will not take advantage of the shrink-on-load performance optimisation when applying a gamma correction.

	Supply a second argument to use a different output gamma value, otherwise the first value is used in both cases."

	self apply: #gamma withArguments: { gammaInputNumber . gammaOutputNumber }
]

{ #category : #coloring }
CpNodeJSSharp >> grayscale [

	"Convert to 8-bit greyscale; 256 shades of grey. This is a linear operation. If the input image is in a non-linear colour space such as sRGB, use gamma() with greyscale() for the best results. By default the output image will be web-friendly sRGB and contain three (identical) color channels. This may be overridden by other sharp operations such as toColourspace('b-w'), which will produce an output image containing one color channel. An alpha channel may be present, and will be unchanged by the operation."

	self apply: #grayscale
]

{ #category : #coloring }
CpNodeJSSharp >> grayscale: aBoolean [

	"Convert to 8-bit greyscale; 256 shades of grey. This is a linear operation. If the input image is in a non-linear colour space such as sRGB, use gamma() with greyscale() for the best results. By default the output image will be web-friendly sRGB and contain three (identical) color channels. This may be overridden by other sharp operations such as toColourspace('b-w'), which will produce an output image containing one color channel. An alpha channel may be present, and will be unchanged by the operation."

	self apply: #grayscale withArguments: { aBoolean }
]

{ #category : #coloring }
CpNodeJSSharp >> joinChannel: aCollection [

	"Join one or more channels to the image. The meaning of the added channels depends on the output colourspace, set with toColourspace(). By default the output image will be web-friendly sRGB, with additional channels interpreted as alpha channels. Channel ordering follows vips convention:

	sRGB: 0: Red, 1: Green, 2: Blue, 3: Alpha.
	CMYK: 0: Magenta, 1: Cyan, 2: Yellow, 3: Black, 4: Alpha.
	Buffers may be any of the image formats supported by sharp. For raw pixel input, the options object should contain a raw attribute, which follows the format of the attribute of the same name in the sharp() constructor."

	^ self apply: #joinChannel withArguments: { aCollection }
]

{ #category : #coloring }
CpNodeJSSharp >> joinChannel: aCollection options: anInputOptions [

	"Join one or more channels to the image. The meaning of the added channels depends on the output colourspace, set with toColourspace(). By default the output image will be web-friendly sRGB, with additional channels interpreted as alpha channels. Channel ordering follows vips convention:

	sRGB: 0: Red, 1: Green, 2: Blue, 3: Alpha.
	CMYK: 0: Magenta, 1: Cyan, 2: Yellow, 3: Black, 4: Alpha.
	Buffers may be any of the image formats supported by sharp. For raw pixel input, the options object should contain a raw attribute, which follows the format of the attribute of the same name in the sharp() constructor."

	^ self apply: #joinChannel withArguments: { aCollection . anInputOptions asDictionary }
]

{ #category : #output }
CpNodeJSSharp >> jpeg [

	"Use these JPEG options for output image."

	self apply: #jpeg
]

{ #category : #output }
CpNodeJSSharp >> jpeg: anOutputJpegOptions [

	"Use these JPEG options for output image."

	^ self apply: #jpeg withArguments: { anOutputJpegOptions asDictionary }
]

{ #category : #accessing }
CpNodeJSSharp >> keepExif [

	"Keep all EXIF metadata from the input image in the output image.

	EXIF metadata is unsupported for TIFF output."

	self apply: #keepExif
]

{ #category : #accessing }
CpNodeJSSharp >> keepIccProfile [

	"Keep ICC profile from the input image in the output image.

	Where necessary, will attempt to convert the output colour space to match the profile."

	^ self apply: #keepIccProfile
]

{ #category : #accessing }
CpNodeJSSharp >> keepMetadata [

	"Keep all metadata (EXIF, ICC, XMP, IPTC) from the input image in the output image.

	The default behaviour, when keepMetadata is not used, is to convert to the device-independent sRGB colour space and strip all metadata, including the removal of any ICC profile."

	^ self apply: #keepMetadata
]

{ #category : #operations }
CpNodeJSSharp >> linear [

	"Apply the linear formula a * input + b to the image to adjust image levels.

	When a single number is provided, it will be used for all image channels. When an array of numbers is provided, the array length must match the number of channels."

	self apply: #linear
]

{ #category : #operations }
CpNodeJSSharp >> linear: aNumber [

	"Apply the linear formula a * input + b to the image to adjust image levels.

	When a single number is provided, it will be used for all image channels. When an array of numbers is provided, the array length must match the number of channels."

	self apply: #linear withArguments: { aNumber }
]

{ #category : #operations }
CpNodeJSSharp >> linear: factorNumber delta: deltaNumber [

	"Apply the linear formula a * input + b to the image to adjust image levels.

	When a single number is provided, it will be used for all image channels. When an array of numbers is provided, the array length must match the number of channels."

	self apply: #linear withArguments: { factorNumber . deltaNumber }
]

{ #category : #operations }
CpNodeJSSharp >> median [

	"Apply median filter. When used without parameters the default window is 3x3."

	self apply: #median
]

{ #category : #operations }
CpNodeJSSharp >> median: anInteger [

	"Apply median filter. When used without parameters the default window is 3x3."

	self apply: #median withArguments: { anInteger }
]

{ #category : #'accessing - metadata' }
CpNodeJSSharp >> metadata [

	"Fast access to (uncached) image metadata without decoding any compressed pixel data.

	This is read from the header of the input image. It does not take into consideration any operations to be applied to the output image, such as resize or rotate.

	Dimensions in the response will respect the page and pages properties of the constructor parameters.

	A Promise is returned when callback is not provided.

	format: Name of decoder used to decompress image data e.g. jpeg, png, webp, gif, svg
	size: Total size of image in bytes, for Stream and Buffer input only
	width: Number of pixels wide (EXIF orientation is not taken into consideration, see example below)
	height: Number of pixels high (EXIF orientation is not taken into consideration, see example below)
	space: Name of colour space interpretation e.g. srgb, rgb, cmyk, lab, b-w ... 
	channels: Number of bands e.g. 3 for sRGB, 4 for CMYK
	depth: Name of pixel depth format e.g. uchar, char, ushort, float ... 
	density: Number of pixels per inch (DPI), if present
	chromaSubsampling: String containing JPEG chroma subsampling, 4:2:0 or 4:4:4 for RGB, 4:2:0:4 or 4:4:4:4 for CMYK
	isProgressive: Boolean indicating whether the image is interlaced using a progressive scan
	pages: Number of pages/frames contained within the image, with support for TIFF, HEIF, PDF, animated GIF and animated WebP
	pageHeight: Number of pixels high each page in a multi-page image will be.
	paletteBitDepth: Bit depth of palette-based image (GIF, PNG).
	loop: Number of times to loop an animated image, zero refers to a continuous loop.
	delay: Delay in ms between each page in an animated image, provided as an array of integers.
	pagePrimary: Number of the primary page in a HEIF image
	levels: Details of each level in a multi-level image provided as an array of objects, requires libvips compiled with support for OpenSlide
	subifds: Number of Sub Image File Directories in an OME-TIFF image
	background: Default background colour, if present, for PNG (bKGD) and GIF images, either an RGB Object or a single greyscale value
	compression: The encoder used to compress an HEIF file, av1 (AVIF) or hevc (HEIC)
	resolutionUnit: The unit of resolution (density), either inch or cm, if present
	hasProfile: Boolean indicating the presence of an embedded ICC profile
	hasAlpha: Boolean indicating the presence of an alpha transparency channel
	orientation: Number value of the EXIF Orientation header, if present
	exif: Buffer containing raw EXIF data, if present
	icc: Buffer containing raw ICC  profile data, if present
	iptc: Buffer containing raw IPTC data, if present
	xmp: Buffer containing raw XMP data, if present
	tifftagPhotoshop: Buffer containing raw TIFFTAG_PHOTOSHOP data, if present
	formatMagick: String containing format for images loaded via *magick
	comments: Array of keyword/text pairs representing PNG text blocks, if present.

	Return: Promise"

	^ self apply: #metadata resultAs: CpJavaScriptPromise
]

{ #category : #'accessing - metadata' }
CpNodeJSSharp >> metadataDo: aBlock [

	"Fast access to (uncached) image metadata without decoding any compressed pixel data.

	aBlock should accept two arguments: err, metadata

	This is read from the header of the input image. It does not take into consideration any operations to be applied to the output image, such as resize or rotate.

	Dimensions in the response will respect the page and pages properties of the constructor parameters.

	A Promise is returned when callback is not provided.

	format: Name of decoder used to decompress image data e.g. jpeg, png, webp, gif, svg
	size: Total size of image in bytes, for Stream and Buffer input only
	width: Number of pixels wide (EXIF orientation is not taken into consideration, see example below)
	height: Number of pixels high (EXIF orientation is not taken into consideration, see example below)
	space: Name of colour space interpretation e.g. srgb, rgb, cmyk, lab, b-w ... 
	channels: Number of bands e.g. 3 for sRGB, 4 for CMYK
	depth: Name of pixel depth format e.g. uchar, char, ushort, float ... 
	density: Number of pixels per inch (DPI), if present
	chromaSubsampling: String containing JPEG chroma subsampling, 4:2:0 or 4:4:4 for RGB, 4:2:0:4 or 4:4:4:4 for CMYK
	isProgressive: Boolean indicating whether the image is interlaced using a progressive scan
	pages: Number of pages/frames contained within the image, with support for TIFF, HEIF, PDF, animated GIF and animated WebP
	pageHeight: Number of pixels high each page in a multi-page image will be.
	paletteBitDepth: Bit depth of palette-based image (GIF, PNG).
	loop: Number of times to loop an animated image, zero refers to a continuous loop.
	delay: Delay in ms between each page in an animated image, provided as an array of integers.
	pagePrimary: Number of the primary page in a HEIF image
	levels: Details of each level in a multi-level image provided as an array of objects, requires libvips compiled with support for OpenSlide
	subifds: Number of Sub Image File Directories in an OME-TIFF image
	background: Default background colour, if present, for PNG (bKGD) and GIF images, either an RGB Object or a single greyscale value
	compression: The encoder used to compress an HEIF file, av1 (AVIF) or hevc (HEIC)
	resolutionUnit: The unit of resolution (density), either inch or cm, if present
	hasProfile: Boolean indicating the presence of an embedded ICC profile
	hasAlpha: Boolean indicating the presence of an alpha transparency channel
	orientation: Number value of the EXIF Orientation header, if present
	exif: Buffer containing raw EXIF data, if present
	icc: Buffer containing raw ICC  profile data, if present
	iptc: Buffer containing raw IPTC data, if present
	xmp: Buffer containing raw XMP data, if present
	tifftagPhotoshop: Buffer containing raw TIFFTAG_PHOTOSHOP data, if present
	formatMagick: String containing format for images loaded via *magick
	comments: Array of keyword/text pairs representing PNG text blocks, if present."

	self apply: #metadata withArguments: { aBlock asJavaScriptFunction }
]

{ #category : #operations }
CpNodeJSSharp >> modulate: anOperationModulateOptions [

	"Transforms the image using brightness, saturation, hue rotation, and lightness. Brightness and lightness both operate on luminance, with the difference being that brightness is multiplicative whereas lightness is additive."

	self apply: #modulate withArguments: { anOperationModulateOptions asDictionary }
]

{ #category : #operations }
CpNodeJSSharp >> negate [

	"Produce the ""negative"" of the image."

	self apply: #negate
]

{ #category : #operations }
CpNodeJSSharp >> negate: anOperationNegateOptions [

	"Produce the ""negative"" of the image."

	self apply: #negate withArguments: { anOperationNegateOptions asDictionary }
]

{ #category : #operations }
CpNodeJSSharp >> normalize [

	"Enhance output image contrast by stretching its luminance to cover a full dynamic range.

	Uses a histogram-based approach, taking a default range of 1% to 99% to reduce sensitivity to noise at the extremes.

	Luminance values below the lower percentile will be underexposed by clipping to zero. Luminance values above the upper percentile will be overexposed by clipping to the max pixel value."

	self apply: #normalize
]

{ #category : #operations }
CpNodeJSSharp >> normalize: anOperationNormalizeOptions [

	"Enhance output image contrast by stretching its luminance to cover a full dynamic range.

	Uses a histogram-based approach, taking a default range of 1% to 99% to reduce sensitivity to noise at the extremes.

	Luminance values below the lower percentile will be underexposed by clipping to zero. Luminance values above the upper percentile will be overexposed by clipping to the max pixel value."

	self apply: #normalize withArguments: { anOperationNormalizeOptions asDictionary }
]

{ #category : #coloring }
CpNodeJSSharp >> pipelineColorspace: aString [

	"Set the pipeline colourspace.

	The input image will be converted to the provided colourspace at the start of the pipeline. All operations will use this colourspace before converting to the output colourspace, as defined by toColourspace.

	Possible values: e.g. rgb16, scrgb, lab, grey16."

	self apply: #pipelineColorspace withArguments: { aString }
]

{ #category : #output }
CpNodeJSSharp >> png [

	"Use these PNG options for output image.

	By default, PNG output is full colour at 8 bits per pixel.

	Indexed PNG input at 1, 2 or 4 bits per pixel is converted to 8 bits per pixel. Set palette to true for slower, indexed PNG output.

	For 16 bits per pixel output, convert to rgb16 via toColourspace."

	self apply: #png
]

{ #category : #output }
CpNodeJSSharp >> png: anOutputPngOptions [

	"Use these PNG options for output image.

	By default, PNG output is full colour at 8 bits per pixel.

	Indexed PNG input at 1, 2 or 4 bits per pixel is converted to 8 bits per pixel. Set palette to true for slower, indexed PNG output.

	For 16 bits per pixel output, convert to rgb16 via toColourspace."

	self apply: #png withArguments: { anOutputPngOptions asDictionary }
]

{ #category : #operations }
CpNodeJSSharp >> recomb: anArray [

	"Recombine the image with the specified matrix.

	Argument either 3x3 or 4x4 matrix."

	self apply: #recomb withArguments: { anArray }
]

{ #category : #coloring }
CpNodeJSSharp >> removeAlpha [

	"Remove alpha channel, if any. This is a no-op if the image does not have an alpha channel."

	self apply: #removeAlpha
]

{ #category : #resizing }
CpNodeJSSharp >> resize: aResizeOptions [

	"Resize image to width, height or width x height.

	See also: CpNodeJSSharpResizeOptions

	Only one resize can occur per pipeline. Previous calls to resize in the same pipeline will be ignored."

	self apply: #resize withArguments: { aResizeOptions asDictionary }
]

{ #category : #resizing }
CpNodeJSSharp >> resizeHeight: anInteger [

	"Resize image to width, height or width x height.

	See also: #resize:"

	self apply: #resize withArguments: { nil . anInteger }
]

{ #category : #resizing }
CpNodeJSSharp >> resizeWidth: anInteger [

	"Resize image to width, height or width x height.

	See also: #resize:"

	self apply: #resize withArguments: { anInteger }
]

{ #category : #operations }
CpNodeJSSharp >> rotate [

	"Rotate the output image by either an explicit angle or auto-orient based on the EXIF Orientation tag.

	If an angle is provided, it is converted to a valid positive degree rotation. For example, -450 will produce a 270 degree rotation.

	When rotating by an angle other than a multiple of 90, the background colour can be provided with the background option.

	If no angle is provided, it is determined from the EXIF data. Mirroring is supported and may infer the use of a flip operation.

	The use of rotate without an angle will remove the EXIF Orientation tag, if any.

	Only one rotation can occur per pipeline. Previous calls to rotate in the same pipeline will be ignored.

	Multi-page images can only be rotated by 180 degrees.

	Method order is important when rotating, resizing and/or extracting regions, for example .rotate(x).extract(y) will produce a different result to .extract(y).rotate(x)."

	self apply: #rotate
]

{ #category : #operations }
CpNodeJSSharp >> rotate: aNumber [

	"Rotate the output image by either an explicit angle or auto-orient based on the EXIF Orientation tag.

	If an angle is provided, it is converted to a valid positive degree rotation. For example, -450 will produce a 270 degree rotation.

	When rotating by an angle other than a multiple of 90, the background colour can be provided with the background option.

	If no angle is provided, it is determined from the EXIF data. Mirroring is supported and may infer the use of a flip operation.

	The use of rotate without an angle will remove the EXIF Orientation tag, if any.

	Only one rotation can occur per pipeline. Previous calls to rotate in the same pipeline will be ignored.

	Multi-page images can only be rotated by 180 degrees.

	Method order is important when rotating, resizing and/or extracting regions, for example .rotate(x).extract(y) will produce a different result to .extract(y).rotate(x)."

	self apply: #rotate withArguments: { aNumber }
]

{ #category : #operations }
CpNodeJSSharp >> rotate: aNumber options: anOperationOptions [

	"Rotate the output image by either an explicit angle or auto-orient based on the EXIF Orientation tag.

	If an angle is provided, it is converted to a valid positive degree rotation. For example, -450 will produce a 270 degree rotation.

	When rotating by an angle other than a multiple of 90, the background colour can be provided with the background option.

	If no angle is provided, it is determined from the EXIF data. Mirroring is supported and may infer the use of a flip operation.

	The use of rotate without an angle will remove the EXIF Orientation tag, if any.

	Only one rotation can occur per pipeline. Previous calls to rotate in the same pipeline will be ignored.

	Multi-page images can only be rotated by 180 degrees.

	Method order is important when rotating, resizing and/or extracting regions, for example .rotate(x).extract(y) will produce a different result to .extract(y).rotate(x)."

	self apply: #rotate withArguments: { aNumber . anOperationOptions asDictionary }
]

{ #category : #operations }
CpNodeJSSharp >> rotateOptions: anOperationOptions [

	"Rotate the output image by either an explicit angle or auto-orient based on the EXIF Orientation tag.

	If an angle is provided, it is converted to a valid positive degree rotation. For example, -450 will produce a 270 degree rotation.

	When rotating by an angle other than a multiple of 90, the background colour can be provided with the background option.

	If no angle is provided, it is determined from the EXIF data. Mirroring is supported and may infer the use of a flip operation.

	The use of rotate without an angle will remove the EXIF Orientation tag, if any.

	Only one rotation can occur per pipeline. Previous calls to rotate in the same pipeline will be ignored.

	Multi-page images can only be rotated by 180 degrees.

	Method order is important when rotating, resizing and/or extracting regions, for example .rotate(x).extract(y) will produce a different result to .extract(y).rotate(x)."

	self apply: #rotate withArguments: { nil . anOperationOptions asDictionary }
]

{ #category : #operations }
CpNodeJSSharp >> sharpen [

	"Sharpen the image.

	When used without parameters, performs a fast, mild sharpen of the output image.

	When a sigma is provided, performs a slower, more accurate sharpen of the L channel in the LAB colour space. Fine-grained control over the level of sharpening in ""flat"" (m1) and ""jagged"" (m2) areas is available.

	See libvips sharpen  operation."

	self apply: #sharpen
]

{ #category : #operations }
CpNodeJSSharp >> sharpen: anOperationSharpenOptions [

	"Sharpen the image.

	When used without parameters, performs a fast, mild sharpen of the output image.

	When a sigma is provided, performs a slower, more accurate sharpen of the L channel in the LAB colour space. Fine-grained control over the level of sharpening in ""flat"" (m1) and ""jagged"" (m2) areas is available.

	See libvips sharpen  operation."

	self apply: #sharpen withArguments: { anOperationSharpenOptions asDictionary }
]

{ #category : #'accessing - metadata' }
CpNodeJSSharp >> stats [

	"Access to pixel-derived image statistics for every channel in the image. A Promise is returned when callback is not provided.

	channels: Array of channel statistics for each channel in the image. Each channel statistic contains
	min (minimum value in the channel)
	max (maximum value in the channel)
	sum (sum of all values in a channel)
	squaresSum (sum of squared values in a channel)
	mean (mean of the values in a channel)
	stdev (standard deviation for the values in a channel)
	minX (x-coordinate of one of the pixel where the minimum lies)
	minY (y-coordinate of one of the pixel where the minimum lies)
	maxX (x-coordinate of one of the pixel where the maximum lies)
	maxY (y-coordinate of one of the pixel where the maximum lies)
	isOpaque: Is the image fully opaque? Will be true if the image has no alpha channel or if every pixel is fully opaque.
	entropy: Histogram-based estimation of greyscale entropy, discarding alpha channel if any.
	sharpness: Estimation of greyscale sharpness based on the standard deviation of a Laplacian convolution, discarding alpha channel if any.
	dominant: Object containing most dominant sRGB colour based on a 4096-bin 3D histogram.

	Note: Statistics are derived from the original input image. Any operations performed on the image must first be written to a buffer in order to run stats on the result (see third example).

	Return: Promise"

	^ self apply: #stats resultAs: CpJavaScriptPromise
]

{ #category : #'accessing - metadata' }
CpNodeJSSharp >> statsDo: aBlock [

	"Access to pixel-derived image statistics for every channel in the image. A Promise is returned when callback is not provided.

	aBlock should accept two arguments: err, stats

	channels: Array of channel statistics for each channel in the image. Each channel statistic contains
	min (minimum value in the channel)
	max (maximum value in the channel)
	sum (sum of all values in a channel)
	squaresSum (sum of squared values in a channel)
	mean (mean of the values in a channel)
	stdev (standard deviation for the values in a channel)
	minX (x-coordinate of one of the pixel where the minimum lies)
	minY (y-coordinate of one of the pixel where the minimum lies)
	maxX (x-coordinate of one of the pixel where the maximum lies)
	maxY (y-coordinate of one of the pixel where the maximum lies)
	isOpaque: Is the image fully opaque? Will be true if the image has no alpha channel or if every pixel is fully opaque.
	entropy: Histogram-based estimation of greyscale entropy, discarding alpha channel if any.
	sharpness: Estimation of greyscale sharpness based on the standard deviation of a Laplacian convolution, discarding alpha channel if any.
	dominant: Object containing most dominant sRGB colour based on a 4096-bin 3D histogram.

	Note: Statistics are derived from the original input image. Any operations performed on the image must first be written to a buffer in order to run stats on the result (see third example)."

	self apply: #stats withArguments: { aBlock asJavaScriptFunction }
]

{ #category : #operations }
CpNodeJSSharp >> threshold [

	"Any pixel value greater than or equal to the threshold value (default 128) will be set to 255, otherwise it will be set to 0."

	self apply: #threshold
]

{ #category : #operations }
CpNodeJSSharp >> threshold: anInteger [

	"Any pixel value greater than or equal to the threshold value (default 128) will be set to 255, otherwise it will be set to 0."

	self apply: #threshold withArguments: { anInteger }
]

{ #category : #operations }
CpNodeJSSharp >> threshold: anInteger options: anOperationThresholdOptions [

	"Any pixel value greater than or equal to the threshold value (default 128) will be set to 255, otherwise it will be set to 0."

	self apply: #threshold withArguments: { anInteger . anOperationThresholdOptions asDictionary }
]

{ #category : #accessing }
CpNodeJSSharp >> timeout: aTimeoutOptions [

	"Set a timeout for processing, in seconds. Use a value of zero to continue processing indefinitely, the default behaviour.

	The clock starts when libvips opens an input image for processing. Time spent waiting for a libuv thread to become available is not included."

	self apply: #timeout withArguments: { aTimeoutOptions asDictionary }
]

{ #category : #coloring }
CpNodeJSSharp >> tint: aString [

	"Tint the image using the provided colour (String | Object). An alpha channel may be present and will be unchanged by the operation."

	self apply: #tint withArguments: { aString }
]

{ #category : #output }
CpNodeJSSharp >> toBuffer [

	"Write output to a Buffer. JPEG, PNG, WebP, AVIF, TIFF, GIF and raw pixel data output are supported.

	Use toFormat or one of the format-specific functions such as jpeg, png etc. to set the output format.

	If no explicit format is set, the output format will match the input image, except SVG input which becomes PNG output.

	By default all metadata will be removed, which includes EXIF-based orientation. See withMetadata for control over this.

	callback, if present, gets three arguments (err, data, info) where:

	err is an error, if any.
	data is the output image data.
	info contains the output image format, size (bytes), width, height, channels and premultiplied (indicating if premultiplication was used). When using a crop strategy also contains cropOffsetLeft and cropOffsetTop. Animated output will also contain pageHeight and pages. May also contain textAutofitDpi (dpi the font was rendered at) if image was created from text.
	A Promise is returned when callback is not provided.

	Return: Promise"

	^ self apply: #toBuffer resultAs: CpJavaScriptPromise
]

{ #category : #output }
CpNodeJSSharp >> toBuffer: aToBufferOptions [

	"Write output to a Buffer. JPEG, PNG, WebP, AVIF, TIFF, GIF and raw pixel data output are supported.

	Use toFormat or one of the format-specific functions such as jpeg, png etc. to set the output format.

	If no explicit format is set, the output format will match the input image, except SVG input which becomes PNG output.

	By default all metadata will be removed, which includes EXIF-based orientation. See withMetadata for control over this.

	callback, if present, gets three arguments (err, data, info) where:

	err is an error, if any.
	data is the output image data.
	info contains the output image format, size (bytes), width, height, channels and premultiplied (indicating if premultiplication was used). When using a crop strategy also contains cropOffsetLeft and cropOffsetTop. Animated output will also contain pageHeight and pages. May also contain textAutofitDpi (dpi the font was rendered at) if image was created from text.
	A Promise is returned when callback is not provided.

	Return: Promise"

	^ self apply: #toBuffer withArguments: { aToBufferOptions asDictionary } resultAs: CpJavaScriptPromise
]

{ #category : #output }
CpNodeJSSharp >> toBuffer: aToBufferOptions do: aBlock [

	"Write output to a Buffer. JPEG, PNG, WebP, AVIF, TIFF, GIF and raw pixel data output are supported.

	aBlock should accept 3 arguments: err, data, info

	Use toFormat or one of the format-specific functions such as jpeg, png etc. to set the output format.

	If no explicit format is set, the output format will match the input image, except SVG input which becomes PNG output.

	By default all metadata will be removed, which includes EXIF-based orientation. See withMetadata for control over this.

	callback, if present, gets three arguments (err, data, info) where:

	err is an error, if any.
	data is the output image data.
	info contains the output image format, size (bytes), width, height, channels and premultiplied (indicating if premultiplication was used). When using a crop strategy also contains cropOffsetLeft and cropOffsetTop. Animated output will also contain pageHeight and pages. May also contain textAutofitDpi (dpi the font was rendered at) if image was created from text.
	A Promise is returned when callback is not provided."

	^ self apply: #toBuffer withArguments: { aToBufferOptions asDictionary . aBlock asJavaScriptFunction }
]

{ #category : #output }
CpNodeJSSharp >> toBufferDo: aBlock [

	"Write output to a Buffer. JPEG, PNG, WebP, AVIF, TIFF, GIF and raw pixel data output are supported.

	aBlock should accept 3 arguments: err, data, info

	Use toFormat or one of the format-specific functions such as jpeg, png etc. to set the output format.

	If no explicit format is set, the output format will match the input image, except SVG input which becomes PNG output.

	By default all metadata will be removed, which includes EXIF-based orientation. See withMetadata for control over this.

	callback, if present, gets three arguments (err, data, info) where:

	err is an error, if any.
	data is the output image data.
	info contains the output image format, size (bytes), width, height, channels and premultiplied (indicating if premultiplication was used). When using a crop strategy also contains cropOffsetLeft and cropOffsetTop. Animated output will also contain pageHeight and pages. May also contain textAutofitDpi (dpi the font was rendered at) if image was created from text.
	A Promise is returned when callback is not provided."

	^ self apply: #toBuffer withArguments: { nil . aBlock asJavaScriptFunction }
]

{ #category : #coloring }
CpNodeJSSharp >> toColorspace: aString [

	"Set the output colourspace. By default output image will be web-friendly sRGB, with additional channels interpreted as alpha channels.

	Possible values: e.g. rgb16, scrgb, lab, grey16."

	self apply: #toColorspace withArguments: { aString }
]

{ #category : #output }
CpNodeJSSharp >> toFile: aString [

	"Write output image data to a file.

	If an explicit output format is not selected, it will be inferred from the extension, with JPEG, PNG, WebP, AVIF, TIFF, GIF, DZI, and libvips' V format supported. Note that raw pixel data is only supported for buffer output.

	By default all metadata will be removed, which includes EXIF-based orientation. See withMetadata for control over this.

	The caller is responsible for ensuring directory structures and permissions exist.

	A Promise is returned when callback is not provided.

	Return: Promise"

	^ self apply: #toFile withArguments: { aString } resultAs: CpJavaScriptPromise
]

{ #category : #output }
CpNodeJSSharp >> toFile: aString do: aBlock [

	"Write output image data to a file.

	aBlock should accept two arguments: err, info

	If an explicit output format is not selected, it will be inferred from the extension, with JPEG, PNG, WebP, AVIF, TIFF, GIF, DZI, and libvips' V format supported. Note that raw pixel data is only supported for buffer output.

	By default all metadata will be removed, which includes EXIF-based orientation. See withMetadata for control over this.

	The caller is responsible for ensuring directory structures and permissions exist.

	A Promise is returned when callback is not provided."

	self apply: #toFile withArguments: { aString . aBlock asJavaScriptFunction }
]

{ #category : #output }
CpNodeJSSharp >> toFormat: aString [

	"Force output to a given format."

	self apply: #toFormat withArguments: { aString }
]

{ #category : #resizing }
CpNodeJSSharp >> trim [

	"Trim pixels from all edges that contain values similar to the given background colour, which defaults to that of the top-left pixel.

	Images with an alpha channel will use the combined bounding box of alpha and non-alpha channels.

	If the result of this operation would trim an image to nothing then no change is made.

	The info response Object will contain trimOffsetLeft and trimOffsetTop properties."

	self apply: #trim
]

{ #category : #resizing }
CpNodeJSSharp >> trim: aTrimOptions [

	"Trim pixels from all edges that contain values similar to the given background colour, which defaults to that of the top-left pixel.

	Images with an alpha channel will use the combined bounding box of alpha and non-alpha channels.

	If the result of this operation would trim an image to nothing then no change is made.

	The info response Object will contain trimOffsetLeft and trimOffsetTop properties."

	self apply: #trim withArguments: { aTrimOptions asDictionary }
]

{ #category : #accessing }
CpNodeJSSharp >> withExif: aDictionary [

	"Set EXIF metadata in the output image, ignoring any EXIF in the input image."

	self apply: #withExif withArguments: { aDictionary }
]

{ #category : #accessing }
CpNodeJSSharp >> withExifMerge: aDictionary [

	"Update EXIF metadata from the input image in the output image."

	self apply: #withExifMerge withArguments: { aDictionary }
]

{ #category : #accessing }
CpNodeJSSharp >> withIccProfile: aString [

	"Transform using an ICC profile and attach to the output image.

	This can either be an absolute filesystem path or built-in profile name (srgb, p3, cmyk)."

	^ self apply: #withIccProfile withArguments: { aString }
]

{ #category : #accessing }
CpNodeJSSharp >> withIccProfile: aString options: aWithIccProfileOptions [

	"Transform using an ICC profile and attach to the output image.

	This can either be an absolute filesystem path or built-in profile name (srgb, p3, cmyk)."

	^ self apply: #withIccProfile withArguments: { aString . aWithIccProfileOptions asDictionary }
]

{ #category : #accessing }
CpNodeJSSharp >> withMetadata: aWithMetadataOptions [

	"Keep most metadata (EXIF, XMP, IPTC) from the input image in the output image.

	This will also convert to and add a web-friendly sRGB ICC profile if appropriate.

	Allows orientation and density to be set or updated."

	^ self apply: #withMetadata withArguments: { aWithMetadataOptions asDictionary }
]
