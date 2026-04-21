"
I represent both the Browser ReadableStream and the Node.js ReadableStream.
These classes are similar enough to have to same proxy implementation.
"
Class {
	#name : #CpBrowserReadableStream,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-JavaScript-Shared'
}

{ #category : #'instance creation' }
CpBrowserReadableStream class >> underlyingSource: sourceOptions [

	"Create a new instance.

	Either provide a Dictionary or use a CpBrowserStreamSourceOptions instance.

	underlyingSource Optional
	An object containing methods and properties that define how the constructed stream instance will behave. underlyingSource can contain the following:

		start (controller) Optional
			This is a method, called immediately when the object is constructed. The contents of this method are defined by the developer, and should aim to get access to the stream source, and do anything else required to set up the stream functionality. If this process is to be done asynchronously, it can return a promise to signal success or failure. The controller parameter passed to this method is a ReadableStreamDefaultController or a ReadableByteStreamController, depending on the value of the type property. This can be used by the developer to control the stream during set up.

		pull (controller) Optional
			This method, also defined by the developer, will be called repeatedly when the stream's internal queue of chunks is not full, up until it reaches its high water mark. If pull() returns a promise, then it won't be called again until that promise fulfills; if the promise rejects, the stream will become errored. The controller parameter passed to this method is a ReadableStreamDefaultController or a ReadableByteStreamController, depending on the value of the type property. This can be used by the developer to control the stream as more chunks are fetched. This function will not be called until start() successfully completes. Additionally, it will only be called repeatedly if it enqueues at least one chunk or fulfills a BYOB request; a no-op pull() implementation will not be continually called.

		cancel (reason) Optional
			This method, also defined by the developer, will be called if the app signals that the stream is to be cancelled (e.g., if ReadableStream.cancel() is called). The contents should do whatever is necessary to release access to the stream source. If this process is asynchronous, it can return a promise to signal success or failure. The reason parameter contains a string describing why the stream was cancelled.

		type Optional
			This property controls what type of readable stream is being dealt with. If it is included with a value set to ""bytes"", the passed controller object will be a ReadableByteStreamController capable of handling a BYOB (bring your own buffer)/byte stream. If it is not included, the passed controller will be a ReadableStreamDefaultController.

		autoAllocateChunkSize Optional
			For byte streams, the developer can set the autoAllocateChunkSize with a positive integer value to turn on the stream's auto-allocation feature. With this is set, the stream implementation will automatically allocate a view buffer of the specified size in ReadableByteStreamController.byobRequest when required.

			This must be set to enable zero-copy transfers to be used with a default ReadableStreamDefaultReader. If not set, a default reader will still stream data, but ReadableByteStreamController.byobRequest will always be null and transfers to the consumer must be via the stream's internal queues."

	^ self newInstanceWithArguments: { sourceOptions asDictionary }
]

{ #category : #'instance creation' }
CpBrowserReadableStream class >> underlyingSource: sourceOptions queuingStrategy: queueStrategy [

	"Create a new instance.

	Either provide a Dictionary or use a CpBrowserStreamSourceOptions instance and/or a CpBrowserStreamQueuingStrategy instance.

	underlyingSource Optional
	An object containing methods and properties that define how the constructed stream instance will behave. underlyingSource can contain the following:

		start (controller) Optional
			This is a method, called immediately when the object is constructed. The contents of this method are defined by the developer, and should aim to get access to the stream source, and do anything else required to set up the stream functionality. If this process is to be done asynchronously, it can return a promise to signal success or failure. The controller parameter passed to this method is a ReadableStreamDefaultController or a ReadableByteStreamController, depending on the value of the type property. This can be used by the developer to control the stream during set up.

		pull (controller) Optional
			This method, also defined by the developer, will be called repeatedly when the stream's internal queue of chunks is not full, up until it reaches its high water mark. If pull() returns a promise, then it won't be called again until that promise fulfills; if the promise rejects, the stream will become errored. The controller parameter passed to this method is a ReadableStreamDefaultController or a ReadableByteStreamController, depending on the value of the type property. This can be used by the developer to control the stream as more chunks are fetched. This function will not be called until start() successfully completes. Additionally, it will only be called repeatedly if it enqueues at least one chunk or fulfills a BYOB request; a no-op pull() implementation will not be continually called.

		cancel (reason) Optional
			This method, also defined by the developer, will be called if the app signals that the stream is to be cancelled (e.g., if ReadableStream.cancel() is called). The contents should do whatever is necessary to release access to the stream source. If this process is asynchronous, it can return a promise to signal success or failure. The reason parameter contains a string describing why the stream was cancelled.

		type Optional
			This property controls what type of readable stream is being dealt with. If it is included with a value set to ""bytes"", the passed controller object will be a ReadableByteStreamController capable of handling a BYOB (bring your own buffer)/byte stream. If it is not included, the passed controller will be a ReadableStreamDefaultController.

		autoAllocateChunkSize Optional
			For byte streams, the developer can set the autoAllocateChunkSize with a positive integer value to turn on the stream's auto-allocation feature. With this is set, the stream implementation will automatically allocate a view buffer of the specified size in ReadableByteStreamController.byobRequest when required.

			This must be set to enable zero-copy transfers to be used with a default ReadableStreamDefaultReader. If not set, a default reader will still stream data, but ReadableByteStreamController.byobRequest will always be null and transfers to the consumer must be via the stream's internal queues.


	queuingStrategy Optional
	An object that optionally defines a queuing strategy for the stream. This takes two parameters:

		highWaterMark
			A non-negative integer — this defines the total number of chunks that can be contained in the internal queue before backpressure is applied.

		size(chunk)
			A method containing a parameter chunk — this indicates the size to use for each chunk, in bytes."

	^ self newInstanceWithArguments: { sourceOptions asDictionary . queueStrategy asDictionary }
]

{ #category : #operations }
CpBrowserReadableStream >> cancel [

	^ self cancelWithReason: nil
]

{ #category : #operations }
CpBrowserReadableStream >> cancelWithReason: aString [

	"Returns a Promise that resolves when the stream is canceled. Calling this method signals a loss of interest in the stream by a consumer. The supplied reason argument will be given to the underlying source, which may or may not use it."

	^ self apply: #cancel withArguments: { aString } resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpBrowserReadableStream >> getReader [

	"Creates a reader and locks the stream to it. While the stream is locked, no other reader can be acquired until this one is released."

	^ self apply: #getReader resultAs: CpBrowserReadableStreamDefaultReader
]

{ #category : #accessing }
CpBrowserReadableStream >> locked [

	"Returns a boolean indicating whether or not the readable stream is locked to a reader."

	^ self propertyAt: #locked
]

{ #category : #operations }
CpBrowserReadableStream >> pipeThrough: aTransformStream [

	^ self pipeThrough: aTransformStream options: nil
]

{ #category : #operations }
CpBrowserReadableStream >> pipeThrough: aTransformStream options: aDictionary [

	"Provides a chainable way of piping the current stream through a transform stream or any other writable/readable pair.

	options Optional
	The options that should be used when piping to the writable stream. Available options are:

		preventClose
			If this is set to true, closing the source ReadableStream will no longer cause the destination WritableStream to be closed.
		preventAbort
			If this is set to true, errors in the source ReadableStream will no longer abort the destination WritableStream.
		preventCancel
			If this is set to true, errors in the destination WritableStream will no longer cancel the source ReadableStream.
		signal
			If set to an AbortSignal object, ongoing pipe operations can then be aborted via the corresponding AbortController."

	^ self apply: #pipeThrough withArguments: { aTransformStream . aDictionary } resultAs: CpBrowserReadableStream
]

{ #category : #operations }
CpBrowserReadableStream >> pipeTo: aWritableStream [

	^ self pipeTo: aWritableStream options: nil
]

{ #category : #operations }
CpBrowserReadableStream >> pipeTo: aWritableStream options: aDictionary [

	"Pipes the current ReadableStream to a given WritableStream and returns a Promise that fulfills when the piping process completes successfully, or rejects if any errors were encountered.

	options Optional
	The options that should be used when piping to the writable stream. Available options are:

		preventClose
			If this is set to true, closing the source ReadableStream will no longer cause the destination WritableStream to be closed.
		preventAbort
			If this is set to true, errors in the source ReadableStream will no longer abort the destination WritableStream.
		preventCancel
			If this is set to true, errors in the destination WritableStream will no longer cancel the source ReadableStream.
		signal
			If set to an AbortSignal object, ongoing pipe operations can then be aborted via the corresponding AbortController."

	^ self apply: #pipeTo withArguments: { aWritableStream . aDictionary } resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpBrowserReadableStream >> tee [

	"The tee method tees this readable stream, returning a two-element array containing the two resulting branches as new ReadableStream instances. Each of those streams receives the same incoming data."

	^ self apply: #tee
]
