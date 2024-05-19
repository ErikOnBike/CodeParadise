"
I am the representation of a JavaScript HTMLCanvasElement.
I can be used to access the CanvasElement behavior more easily than
through the regular DOMElement interface which only supports DOM
manipulation behavior.

"
Class {
	#name : #CpBrowserCanvasElement,
	#superclass : #CpJavaScriptEventTarget,
	#category : #'CodeParadise-Browser-Support-Canvas'
}

{ #category : #'instance creation' }
CpBrowserCanvasElement class >> domElement: aDomElement [

	^ self wrap: aDomElement
]

{ #category : #operations }
CpBrowserCanvasElement >> captureStream [

	"Returns a CanvasCaptureMediaStreamTrack that is a real-time video capture of the surface of the canvas."

	self apply: #captureStream
]

{ #category : #operations }
CpBrowserCanvasElement >> getContext: aString [

	"Returns a drawing context on the canvas, or null if the context ID is not supported. A drawing context lets you draw on the canvas. Calling getContext with ""2d"" returns a CanvasRenderingContext2D object, whereas calling it with ""webgl"" (or ""experimental-webgl"") returns a WebGLRenderingContext object. This context is only available on browsers that implement WebGL."

	^ self apply: #getContext withArguments: { aString }
]

{ #category : #accessing }
CpBrowserCanvasElement >> height [

	"The height HTML attribute of the <canvas> element is a non-negative integer reflecting the number of logical pixels (or RGBA values) going down one column of the canvas. When the attribute is not specified, or if it is set to an invalid value, like a negative, the default value of 150 is used. If no [separate] CSS height is assigned to the <canvas>, then this value will also be used as the height of the canvas in the length-unit CSS Pixel."

	^ self propertyAt: #height
]

{ #category : #accessing }
CpBrowserCanvasElement >> height: anInteger [

	"The height HTML attribute of the <canvas> element is a non-negative integer reflecting the number of logical pixels (or RGBA values) going down one column of the canvas. When the attribute is not specified, or if it is set to an invalid value, like a negative, the default value of 150 is used. If no [separate] CSS height is assigned to the <canvas>, then this value will also be used as the height of the canvas in the length-unit CSS Pixel."

	self propertyAt: #height put: anInteger
]

{ #category : #operations }
CpBrowserCanvasElement >> toBlobThenDo: aBlock [

	"Creates a Blob object representing the image contained in the canvas; this file may be cached on the disk or stored in memory at the discretion of the user agent."

	^ self apply: #toBlob withArguments: { aBlock }
]

{ #category : #operations }
CpBrowserCanvasElement >> toBlobType: aString quality: aFloat thenDo: aBlock [

	"Creates a Blob object representing the image contained in the canvas; this file may be cached on the disk or stored in memory at the discretion of the user agent.
	
	Type should be specified as mime-type, e.g. image/jpeg.
	Quality should be a value between 0 and 1 (inclusive) specifying the requested image quality"

	^ self apply: #toBlob withArguments: { aBlock . aString . aFloat }
]

{ #category : #operations }
CpBrowserCanvasElement >> toBlobType: aString thenDo: aBlock [

	"Creates a Blob object representing the image contained in the canvas; this file may be cached on the disk or stored in memory at the discretion of the user agent.
	
	Type should be specified as mime-type, e.g. image/jpeg."

	^ self apply: #toBlob withArguments: { aBlock . aString }
]

{ #category : #operations }
CpBrowserCanvasElement >> toDataURL [

	"Returns a data-URL containing a representation of the image in the format specified by the type parameter (defaults to png). The returned image is in a resolution of 96dpi."

	^ self apply: #toDataURL
]

{ #category : #operations }
CpBrowserCanvasElement >> toDataURLType: aString [

	"Returns a data-URL containing a representation of the image in the format specified by the type parameter (defaults to png). The returned image is in a resolution of 96dpi.
	
	Type should be specified as mime-type, e.g. image/jpeg."

	^ self apply: #toDataURL withArguments: { aString }
]

{ #category : #operations }
CpBrowserCanvasElement >> toDataURLType: aString quality: aFloat [

	"Returns a data-URL containing a representation of the image in the format specified by the type parameter (defaults to png). The returned image is in a resolution of 96dpi.
	
	Type should be specified as mime-type, e.g. image/jpeg.
	Quality should be a value between 0 and 1 (inclusive) specifying the requested image quality"

	^ self apply: #toDataURL withArguments: { aString . aFloat }
]

{ #category : #operations }
CpBrowserCanvasElement >> transferControlToOffscreen [

	"Transfers control to an OffscreenCanvas object, either on the main thread or on a worker."

	^ self apply: #transferControlToOffscreen
]

{ #category : #accessing }
CpBrowserCanvasElement >> width [

	"The width HTML attribute of the <canvas> element is a non-negative integer reflecting the number of logical pixels (or RGBA values) going across one row of the canvas. When the attribute is not specified, or if it is set to an invalid value, like a negative, the default value of 300 is used. If no [separate] CSS width is assigned to the <canvas>, then this value will also be used as the width of the canvas in the length-unit CSS Pixel.
"

	^ self propertyAt: #width
]

{ #category : #accessing }
CpBrowserCanvasElement >> width: anInteger [

	"The width HTML attribute of the <canvas> element is a non-negative integer reflecting the number of logical pixels (or RGBA values) going across one row of the canvas. When the attribute is not specified, or if it is set to an invalid value, like a negative, the default value of 300 is used. If no [separate] CSS width is assigned to the <canvas>, then this value will also be used as the width of the canvas in the length-unit CSS Pixel.
"

	self propertyAt: #width put: anInteger
]
