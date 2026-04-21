Class {
	#name : #CpBrowserStreamSourceOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-JavaScript-Support'
}

{ #category : #accessing }
CpBrowserStreamSourceOptions >> autoAllocateChunkSize [

	^ options at: #autoAllocateChunkSize
]

{ #category : #accessing }
CpBrowserStreamSourceOptions >> autoAllocateChunkSize: anInteger [

	"For byte streams, the developer can set the autoAllocateChunkSize with a positive integer value to turn on the stream's auto-allocation feature. With this is set, the stream implementation will automatically allocate a view buffer of the specified size in ReadableByteStreamController.byobRequest when required.

	This must be set to enable zero-copy transfers to be used with a default ReadableStreamDefaultReader. If not set, a default reader will still stream data, but ReadableByteStreamController.byobRequest will always be null and transfers to the consumer must be via the stream's internal queues."

	options at: #autoAllocateChunkSize put: anInteger
]

{ #category : #accessing }
CpBrowserStreamSourceOptions >> cancel [

	^ options at: #cancel
]

{ #category : #accessing }
CpBrowserStreamSourceOptions >> cancel: aBlock [

	"Cancel reading the stream. The reason (a String) is provided as argument to the Block.

	This method, also defined by the developer, will be called if the app signals that the stream is to be cancelled (e.g., if ReadableStream.cancel() is called). The contents should do whatever is necessary to release access to the stream source. If this process is asynchronous, it can return a promise to signal success or failure. The reason parameter contains a string describing why the stream was cancelled."

	options at: #cancel put: aBlock
]

{ #category : #accessing }
CpBrowserStreamSourceOptions >> pull [

	^ options at: #pull
]

{ #category : #accessing }
CpBrowserStreamSourceOptions >> pull: aBlock [

	"Pull data from the stream. The controller is passed as argument to the Block.

	This method, also defined by the developer, will be called repeatedly when the stream's internal queue of chunks is not full, up until it reaches its high water mark. If pull() returns a promise, then it won't be called again until that promise fulfills; if the promise rejects, the stream will become errored. The controller parameter passed to this method is a ReadableStreamDefaultController or a ReadableByteStreamController, depending on the value of the type property. This can be used by the developer to control the stream as more chunks are fetched. This function will not be called until start() successfully completes. Additionally, it will only be called repeatedly if it enqueues at least one chunk or fulfills a BYOB request; a no-op pull() implementation will not be continually called."

	options at: #pull put: aBlock
]

{ #category : #accessing }
CpBrowserStreamSourceOptions >> start [

	^ options at: #start
]

{ #category : #accessing }
CpBrowserStreamSourceOptions >> start: aBlock [

	"Initialize the stream. The controller is passed as argument to the Block.

	This is a method, called immediately when the object is constructed. The contents of this method are defined by the developer, and should aim to get access to the stream source, and do anything else required to set up the stream functionality. If this process is to be done asynchronously, it can return a promise to signal success or failure. The controller parameter passed to this method is a ReadableStreamDefaultController or a ReadableByteStreamController, depending on the value of the type property. This can be used by the developer to control the stream during set up."

	options at: #start put: aBlock
]

{ #category : #accessing }
CpBrowserStreamSourceOptions >> type [

	^ options at: #type
]

{ #category : #accessing }
CpBrowserStreamSourceOptions >> type: aString [

	"This property controls what type of readable stream is being dealt with. If it is included with a value set to 'bytes', the passed controller object will be a ReadableByteStreamController capable of handling a BYOB (bring your own buffer)/byte stream. If it is not included, the passed controller will be a ReadableStreamDefaultController."

	options at: #type put: aString
]
