Class {
	#name : #CpBrowserStreamSinkOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-JavaScript-Support'
}

{ #category : #accessing }
CpBrowserStreamSinkOptions >> abort [

	^ options at: #abort
]

{ #category : #accessing }
CpBrowserStreamSinkOptions >> abort: aBlock [

	"Abort the stream. A reason (a String) is passed as argument to the Block.

	This method, also defined by the developer, will be called if the app signals that it wishes to abruptly close the stream and put it in an errored state. It can clean up any held resources, much like close(), but abort() will be called even if writes are queued up — those chunks will be thrown away. If this process is asynchronous, it can return a promise to signal success or failure. The reason parameter contains a string describing why the stream was aborted."

	options at: #abort put: aBlock
]

{ #category : #accessing }
CpBrowserStreamSinkOptions >> close [

	^ options at: #close
]

{ #category : #accessing }
CpBrowserStreamSinkOptions >> close: aBlock [

	"Close the stream. The controller is passed as argument to the Block.

	This method, also defined by the developer, will be called if the app signals that it has finished writing chunks to the stream. The contents should do whatever is necessary to finalize writes to the underlying sink, and release access to it. If this process is asynchronous, it can return a promise to signal success or failure. This method will be called only after all queued-up writes have succeeded."

	options at: #close put: aBlock
]

{ #category : #accessing }
CpBrowserStreamSinkOptions >> start [

	^ options at: #start
]

{ #category : #accessing }
CpBrowserStreamSinkOptions >> start: aBlock [

	"Initialize the stream. The controller is passed as argument to the Block.

	This is a method, called immediately when the object is constructed. The contents of this method are defined by the developer, and should aim to get access to the underlying sink. If this process is to be done asynchronously, it can return a promise to signal success or failure."

	options at: #start put: aBlock
]

{ #category : #accessing }
CpBrowserStreamSinkOptions >> write [

	^ options at: #write
]

{ #category : #accessing }
CpBrowserStreamSinkOptions >> write: aBlock [

	"Write data to the stream. A chunk of data and the controller are passed as arguments to the Block.

	This method, also defined by the developer, will be called when a new chunk of data (specified in the chunk parameter) is ready to be written to the underlying sink. It can return a promise to signal success or failure of the write operation. This method will be called only after previous writes have succeeded, and never after the stream is closed or aborted (see below)."

	options at: #write put: aBlock
]
