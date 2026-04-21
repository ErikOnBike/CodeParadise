Class {
	#name : #CpBrowserTransformStream,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-JavaScript-Shared'
}

{ #category : #'instance creation' }
CpBrowserTransformStream class >> transformer: transformerOptions [

	"Create a new instance.

	Either provide a Dictionary or use a CpBrowserStreamTransformerOptions instance.

	An object representing the transformer. If not supplied the resulting stream will be an identity transform stream which forwards all chunks written to its writable side to its readable side, without any changes.

	The transformer object can contain any of the following methods. In each method controller is an instance of TransformStreamDefaultController.

	transformer <Object>
		start <Function> A user-defined function that is invoked immediately when the TransformStream is created.
			controller <TransformStreamDefaultController>
			Returns: undefined or a promise fulfilled with undefined
		transform <Function> A user-defined function that receives, and potentially modifies, a chunk of data written to transformStream.writable, before forwarding that on to transformStream.readable.
			chunk <any>
			controller <TransformStreamDefaultController>
			Returns: A promise fulfilled with undefined.
		flush <Function> A user-defined function that is called immediately before the writable side of the TransformStream is closed, signaling the end of the transformation process.
			controller <TransformStreamDefaultController>
			Returns: A promise fulfilled with undefined.
		readableType <any> the readableType option is reserved for future use and must be undefined.
		writableType <any> the writableType option is reserved for future use and must be undefined."

	^ self newInstanceWithArguments: { transformerOptions asDictionary }
]

{ #category : #'instance creation' }
CpBrowserTransformStream class >> transformer: transformerOptions writableStrategy: writeStrategy [

	"Create a new instance.

	Either provide a Dictionary or use a CpBrowserStreamTransformerOptions instance and/or a CpBrowserStreamQueuingStrategy instance.

	An object representing the transformer. If not supplied the resulting stream will be an identity transform stream which forwards all chunks written to its writable side to its readable side, without any changes.

	The transformer object can contain any of the following methods. In each method controller is an instance of TransformStreamDefaultController.

	transformer <Object>
		start <Function> A user-defined function that is invoked immediately when the TransformStream is created.
			controller <TransformStreamDefaultController>
			Returns: undefined or a promise fulfilled with undefined
		transform <Function> A user-defined function that receives, and potentially modifies, a chunk of data written to transformStream.writable, before forwarding that on to transformStream.readable.
			chunk <any>
			controller <TransformStreamDefaultController>
			Returns: A promise fulfilled with undefined.
		flush <Function> A user-defined function that is called immediately before the writable side of the TransformStream is closed, signaling the end of the transformation process.
			controller <TransformStreamDefaultController>
			Returns: A promise fulfilled with undefined.
		readableType <any> the readableType option is reserved for future use and must be undefined.
		writableType <any> the writableType option is reserved for future use and must be undefined.

	writableStrategy
		An object that optionally defines a queuing strategy for the stream. This takes two parameters:

		highWaterMark
			A non-negative integer. This defines the total number of chunks that can be contained in the internal queue before backpressure is applied.
		size(chunk)
			A method containing a parameter chunk. This indicates the size to use for each chunk, in bytes."

	^ self newInstanceWithArguments: { transformerOptions asDictionary . writeStrategy asDictionary }
]

{ #category : #'instance creation' }
CpBrowserTransformStream class >> transformer: transformerOptions writableStrategy: writeStrategy readableStrategy: readStrategy [

	"Create a new instance.

	Either provide a Dictionary or use a CpBrowserStreamTransformerOptions instance and/or one or two CpBrowserStreamQueuingStrategy instances.

	An object representing the transformer. If not supplied the resulting stream will be an identity transform stream which forwards all chunks written to its writable side to its readable side, without any changes.

	The transformer object can contain any of the following methods. In each method controller is an instance of TransformStreamDefaultController.

	transformer <Object>
		start <Function> A user-defined function that is invoked immediately when the TransformStream is created.
			controller <TransformStreamDefaultController>
			Returns: undefined or a promise fulfilled with undefined
		transform <Function> A user-defined function that receives, and potentially modifies, a chunk of data written to transformStream.writable, before forwarding that on to transformStream.readable.
			chunk <any>
			controller <TransformStreamDefaultController>
			Returns: A promise fulfilled with undefined.
		flush <Function> A user-defined function that is called immediately before the writable side of the TransformStream is closed, signaling the end of the transformation process.
			controller <TransformStreamDefaultController>
			Returns: A promise fulfilled with undefined.
		readableType <any> the readableType option is reserved for future use and must be undefined.
		writableType <any> the writableType option is reserved for future use and must be undefined.

	writableStrategy
		An object that optionally defines a queuing strategy for the stream. This takes two parameters:

		highWaterMark
			A non-negative integer. This defines the total number of chunks that can be contained in the internal queue before backpressure is applied.
		size(chunk)
			A method containing a parameter chunk. This indicates the size to use for each chunk, in bytes.

	readableStrategy
		An object that optionally defines a queuing strategy for the stream. This takes two parameters:

		highWaterMark
			A non-negative integer. This defines the total number of chunks that can be contained in the internal queue before backpressure is applied.
		size(chunk)
			A method containing a parameter chunk. This indicates the size to use for each chunk, in bytes."

	^ self newInstanceWithArguments: { transformerOptions asDictionary . writeStrategy asDictionary . readStrategy asDictionary }
]

{ #category : #accessing }
CpBrowserTransformStream >> readable [

	"The readable end of a TransformStream."

	^ self propertyAt: #readable resultAs: CpBrowserReadableStream
]

{ #category : #accessing }
CpBrowserTransformStream >> writable [

	"The writable end of a TransformStream."

	^ self propertyAt: #writable resultAs: CpBrowserWritableStream
]
