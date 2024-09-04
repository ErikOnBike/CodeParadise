Class {
	#name : #CpBrowserCanvasRenderingContext2D,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-Canvas'
}

{ #category : #'operations - paths' }
CpBrowserCanvasRenderingContext2D >> beginPath [

	"Starts a new path by emptying the list of sub-paths. Call this method when you want to create a new path."

	self apply: #beginPath
]

{ #category : #'operations - drawing rectangles' }
CpBrowserCanvasRenderingContext2D >> clearRect: fromPoint size: sizePoint [

	"Sets all pixels in the rectangle defined by starting point (x, y) and size (width, height) to transparent black, erasing any previously drawn content."

	self
		apply: #clearRect
		withArguments: {
			fromPoint x .
			fromPoint y .
			sizePoint x .
			sizePoint y
		}
]

{ #category : #'operations - paths' }
CpBrowserCanvasRenderingContext2D >> closePath [

	"Causes the point of the pen to move back to the start of the current sub-path. It tries to draw a straight line from the current point to the start. If the shape has already been closed or has only one point, this function does nothing."

	self apply: #closePath
]

{ #category : #'operations - drawing images' }
CpBrowserCanvasRenderingContext2D >> drawImage: anObject at: positionPoint size: sizePoint [

	"Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.

	anObject
		An element to draw into the context. The specification permits any canvas image source, specifically, an HTMLImageElement, an SVGImageElement, an HTMLVideoElement, an HTMLCanvasElement, an ImageBitmap, an OffscreenCanvas, or a VideoFrame.
	positionPoint x
		The x-axis coordinate in the destination canvas at which to place the top-left corner of the source image.
	positionPoint y
		The y-axis coordinate in the destination canvas at which to place the top-left corner of the source image.
	sizePoint x
		The width to draw the image in the destination canvas. This allows scaling of the drawn image. If not specified, the image is not scaled in width when drawn. Note that this argument is not included in the 3-argument syntax.
	sizePoint y
		The height to draw the image in the destination canvas. This allows scaling of the drawn image. If not specified, the image is not scaled in height when drawn. Note that this argument is not included in the 3-argument syntax."

	self apply: #drawImage withArguments: {
		anObject .
		positionPoint x .
		positionPoint y .
		sizePoint x .
		sizePoint y
	}
]

{ #category : #'operations - drawing images' }
CpBrowserCanvasRenderingContext2D >> drawImage: anObject from: sourcePositionPoint size: sourceSizePoint at: positionPoint size: sizePoint [

	"Draws the specified image. This method is available in multiple formats, providing a great deal of flexibility in its use.

	anObject
		An element to draw into the context. The specification permits any canvas image source, specifically, an HTMLImageElement, an SVGImageElement, an HTMLVideoElement, an HTMLCanvasElement, an ImageBitmap, an OffscreenCanvas, or a VideoFrame.
	sourcePositionPoint x
		The x-axis coordinate of the top left corner of the sub-rectangle of the source image to draw into the destination context. Use the 3- or 5-argument syntax to omit this argument.
	sourcePositionPoint y
		The y-axis coordinate of the top left corner of the sub-rectangle of the source image to draw into the destination context. Use the 3- or 5-argument syntax to omit this argument.
	sourceSizePoint x
		The width of the sub-rectangle of the source image to draw into the destination context. If not specified, the entire rectangle from the coordinates specified by sx and sy to the bottom-right corner of the image is used. Use the 3- or 5-argument syntax to omit this argument. A negative value will flip the image.
	sourceSizePoint y
		The height of the sub-rectangle of the source image to draw into the destination context. Use the 3- or 5-argument syntax to omit this argument. A negative value will flip the image.
	positionPoint x
		The x-axis coordinate in the destination canvas at which to place the top-left corner of the source image.
	positionPoint y
		The y-axis coordinate in the destination canvas at which to place the top-left corner of the source image.
	sizePoint x
		The width to draw the image in the destination canvas. This allows scaling of the drawn image. If not specified, the image is not scaled in width when drawn. Note that this argument is not included in the 3-argument syntax.
	sizePoint y
		The height to draw the image in the destination canvas. This allows scaling of the drawn image. If not specified, the image is not scaled in height when drawn. Note that this argument is not included in the 3-argument syntax."

	self apply: #drawImage withArguments: {
		anObject .
		sourcePositionPoint x .
		sourcePositionPoint y .
		sourceSizePoint x .
		sourceSizePoint y .
		positionPoint x .
		positionPoint y .
		sizePoint x .
		sizePoint y
	}
]

{ #category : #'operations - paths' }
CpBrowserCanvasRenderingContext2D >> fill [

	"Fills the current sub-paths with the current fill style."

	self apply: #fill
]

{ #category : #'accessing - fill and stroke styles' }
CpBrowserCanvasRenderingContext2D >> fillStyle [

	"Color or style to use inside shapes. Default #000 (black)."

	^ self propertyAt: #fillStyle
]

{ #category : #'accessing - fill and stroke styles' }
CpBrowserCanvasRenderingContext2D >> fillStyle: aString [

	"Color or style to use inside shapes. Default #000 (black)."

	self propertyAt: #fillStyle put: aString
]

{ #category : #'accessing - line styles' }
CpBrowserCanvasRenderingContext2D >> lineCap [

	"Type of endings on the end of lines. Possible values: butt (default), round, square."

	^ self propertyAt: #lineCap
]

{ #category : #'accessing - line styles' }
CpBrowserCanvasRenderingContext2D >> lineCap: aString [

	"Type of endings on the end of lines. Possible values: butt (default), round, square."

	self propertyAt: #lineCap put: aString
]

{ #category : #'operations - paths' }
CpBrowserCanvasRenderingContext2D >> lineTo: aPoint [

	"Connects the last point in the current sub-path to the specified (x, y) coordinates with a straight line."

	self apply: #lineTo withArguments: { aPoint x . aPoint y }
]

{ #category : #'accessing - line styles' }
CpBrowserCanvasRenderingContext2D >> lineWidth [

	"Width of lines. Default 1.0."

	^ self propertyAt: #lineWidth
]

{ #category : #'accessing - line styles' }
CpBrowserCanvasRenderingContext2D >> lineWidth: aFloat [

	"Width of lines. Default 1.0."

	self propertyAt: #lineWidth put: aFloat
]

{ #category : #'operations - paths' }
CpBrowserCanvasRenderingContext2D >> moveTo: aPoint [

	"Moves the starting point of a new sub-path to the (x, y) coordinates."

	self apply: #moveTo withArguments: { aPoint x . aPoint y }
]

{ #category : #'operations - paths' }
CpBrowserCanvasRenderingContext2D >> stroke [

	"Strokes the current sub-paths with the current stroke style."

	self apply: #stroke
]

{ #category : #'accessing - fill and stroke styles' }
CpBrowserCanvasRenderingContext2D >> strokeStyle [

	"Color or style to use for the lines around shapes. Default #000 (black)."

	^ self propertyAt: #strokeStyle
]

{ #category : #'accessing - fill and stroke styles' }
CpBrowserCanvasRenderingContext2D >> strokeStyle: aString [

	"Color or style to use for the lines around shapes. Default #000 (black)."

	self propertyAt: #strokeStyle put: aString
]
