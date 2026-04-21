Class {
	#name : #CpBrowserWritableStream,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-JavaScript-Shared'
}

{ #category : #'instance creation' }
CpBrowserWritableStream class >> underlyingSink: sinkOptions [

	"Create a new instance.

	Either provide a Dictionary or use a CpBrowserStreamSinkOptions instance.

	underlyingSink
	An object containing methods and properties that define how the constructed stream instance will behave. The controller parameter passed to this object's methods is a WritableStreamDefaultController that provides abort and error signaling. underlyingSink can contain the following:

		start(controller) Optional
			This is a method, called immediately when the object is constructed. The contents of this method are defined by the developer, and should aim to get access to the underlying sink. If this process is to be done asynchronously, it can return a promise to signal success or failure.
		write(chunk, controller) Optional
			This method, also defined by the developer, will be called when a new chunk of data (specified in the chunk parameter) is ready to be written to the underlying sink. It can return a promise to signal success or failure of the write operation. This method will be called only after previous writes have succeeded, and never after the stream is closed or aborted (see below).
		close(controller) Optional
			This method, also defined by the developer, will be called if the app signals that it has finished writing chunks to the stream. The contents should do whatever is necessary to finalize writes to the underlying sink, and release access to it. If this process is asynchronous, it can return a promise to signal success or failure. This method will be called only after all queued-up writes have succeeded.
		abort(reason) Optional
			This method, also defined by the developer, will be called if the app signals that it wishes to abruptly close the stream and put it in an errored state. It can clean up any held resources, much like close(), but abort() will be called even if writes are queued up — those chunks will be thrown away. If this process is asynchronous, it can return a promise to signal success or failure. The reason parameter contains a string describing why the stream was aborted."

	^ self newInstanceWithArguments: { sinkOptions asDictionary }
]

{ #category : #'instance creation' }
CpBrowserWritableStream class >> underlyingSink: sinkOptions queuingStrategy: queueStrategie [

	"Create a new instance.

	Either provide a Dictionary or use a CpBrowserStreamSinkOptions instance and/or a CpBrowserStreamQueuingStrategy instance.

	underlyingSink
	An object containing methods and properties that define how the constructed stream instance will behave. The controller parameter passed to this object's methods is a WritableStreamDefaultController that provides abort and error signaling. underlyingSink can contain the following:

		start(controller) Optional
			This is a method, called immediately when the object is constructed. The contents of this method are defined by the developer, and should aim to get access to the underlying sink. If this process is to be done asynchronously, it can return a promise to signal success or failure.
		write(chunk, controller) Optional
			This method, also defined by the developer, will be called when a new chunk of data (specified in the chunk parameter) is ready to be written to the underlying sink. It can return a promise to signal success or failure of the write operation. This method will be called only after previous writes have succeeded, and never after the stream is closed or aborted (see below).
		close(controller) Optional
			This method, also defined by the developer, will be called if the app signals that it has finished writing chunks to the stream. The contents should do whatever is necessary to finalize writes to the underlying sink, and release access to it. If this process is asynchronous, it can return a promise to signal success or failure. This method will be called only after all queued-up writes have succeeded.
		abort(reason) Optional
			This method, also defined by the developer, will be called if the app signals that it wishes to abruptly close the stream and put it in an errored state. It can clean up any held resources, much like close(), but abort() will be called even if writes are queued up — those chunks will be thrown away. If this process is asynchronous, it can return a promise to signal success or failure. The reason parameter contains a string describing why the stream was aborted.

	queuingStrategy Optional
	An object that optionally defines a queuing strategy for the stream. This takes two parameters:

		highWaterMark
			A non-negative integer — this defines the total number of chunks that can be contained in the internal queue before backpressure is applied.
		size(chunk)
			A method containing a parameter chunk — this indicates the size to use for each chunk, in bytes."

	^ self newInstanceWithArguments: { sinkOptions asDictionary . queueStrategie asDictionary }
]

{ #category : #operations }
CpBrowserWritableStream >> abort [

	^ self abortWithReason: nil
]

{ #category : #operations }
CpBrowserWritableStream >> abortWithReason: aString [

	"Aborts the stream, signaling that the producer can no longer successfully write to the stream and it is to be immediately moved to an error state, with any queued writes discarded."

	^ self apply: #abort withArguments: { aString } resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpBrowserWritableStream >> close [

	"Closes the stream."

	^ self apply: #close resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpBrowserWritableStream >> locked [

	"A boolean indicating whether the WritableStream is locked to a writer."

	^ self propertyAt: #locked
]
