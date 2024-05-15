Class {
	#name : 'CpBrowserCanvasRenderingContext2D',
	#superclass : 'CpJavaScriptObject',
	#category : 'CodeParadise-Browser-Support-Canvas',
	#package : 'CodeParadise-Browser-Support',
	#tag : 'Canvas'
}

{ #category : 'operations - drawing images' }
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

{ #category : 'operations - drawing images' }
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
