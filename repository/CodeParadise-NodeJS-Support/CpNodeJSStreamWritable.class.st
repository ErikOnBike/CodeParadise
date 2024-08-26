Class {
	#name : #CpNodeJSStreamWritable,
	#superclass : #CpNodeJSEventEmitter,
	#category : #'CodeParadise-NodeJS-Support-Stream'
}

{ #category : #accessing }
CpNodeJSStreamWritable class >> module [

	"Answer the module the receiver is part of"

	^ CpNodeJSStream
]

{ #category : #accessing }
CpNodeJSStreamWritable >> closed [

	"Is true after 'close' has been emitted."

	^ self propertyAt: #closed
]

{ #category : #operations }
CpNodeJSStreamWritable >> cork [

	"The writable.cork() method forces all written data to be buffered in memory. The buffered
	data will be flushed when either the stream.uncork() or stream.end() methods are called.

	The primary intent of writable.cork() is to accommodate a situation in which several small
	chunks are written to the stream in rapid succession. Instead of immediately forwarding them
	to the underlying destination, writable.cork() buffers all the chunks until writable.uncork()
	is called, which will pass them all to writable._writev(), if present. This prevents a
	head-of-line blocking situation where data is being buffered while waiting for the first small
	chunk to be processed. However, use of writable.cork() without implementing writable._writev()
	may have an adverse effect on throughput."

	self apply: #cork
]

{ #category : #operations }
CpNodeJSStreamWritable >> destroy [

	self destroyWithError: nil
]

{ #category : #operations }
CpNodeJSStreamWritable >> destroyWithError: anError [

	"Destroy the stream. Optionally emit an 'error' event, and emit a 'close' event (unless emitClose
	is set to false). After this call, the writable stream has ended and subsequent calls to write() or
	end() will result in an ERR_STREAM_DESTROYED error. This is a destructive and immediate way to
	destroy a stream. Previous calls to write() may not have drained, and may trigger an
	ERR_STREAM_DESTROYED error. Use end() instead of destroy if data should flush before close, or wait
	for the 'drain' event before destroying the stream."

	self apply: #destroy withArguments: { anError }
]

{ #category : #accessing }
CpNodeJSStreamWritable >> destroyed [

	"Is true after writable.destroy() has been called."

	^ self propertyAt: #destroyed
]

{ #category : #operations }
CpNodeJSStreamWritable >> end [

	"Calling the writable.end() method signals that no more data will be written to the Writable.
	The optional chunk and encoding arguments allow one final additional chunk of data to be written
	immediately before closing the stream.

	Calling the stream.write() method after calling stream.end() will raise an error."

	self apply: #end
]

{ #category : #operations }
CpNodeJSStreamWritable >> endWithChunk: anObject [

	self endWithChunk: anObject encoding: nil thenDo: nil
]

{ #category : #operations }
CpNodeJSStreamWritable >> endWithChunk: anObject encoding: aString [

	self endWithChunk: anObject encoding: aString thenDo: nil
]

{ #category : #operations }
CpNodeJSStreamWritable >> endWithChunk: anObject encoding: aString thenDo: aBlock [

	"Calling the writable.end() method signals that no more data will be written to the Writable.
	The optional chunk and encoding arguments allow one final additional chunk of data to be written
	immediately before closing the stream.

	Calling the stream.write() method after calling stream.end() will raise an error."

	self apply: #end withArguments: { anObject . aString . aBlock }
]

{ #category : #operations }
CpNodeJSStreamWritable >> endWithChunk: anObject thenDo: aBlock [

	self endWithChunk: anObject encoding: nil thenDo: aBlock
]

{ #category : #accessing }
CpNodeJSStreamWritable >> errored [

	"Returns error if the stream has been destroyed with an error."

	^ self propertyAt: #errored
]

{ #category : #'event handling' }
CpNodeJSStreamWritable >> onCloseDo: aBlock [

	"The 'close' event is emitted when the stream and any of its underlying resources (a file descriptor,
	for example) have been closed. The event indicates that no more events will be emitted, and no further
	computation will occur.

	A Writable stream will always emit the 'close' event if it is created with the emitClose option."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addListener: #close handler: aBlock
]

{ #category : #'event handling' }
CpNodeJSStreamWritable >> onDrainDo: aBlock [

	"If a call to stream.write(chunk) returns false, the 'drain' event will be emitted when it is appropriate to resume writing data to the stream."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addListener: #drain handler: aBlock
]

{ #category : #'event handling' }
CpNodeJSStreamWritable >> onErrorDo: aBlock [

	"The 'error' event is emitted if an error occurred while writing or piping data. The listener
	callback is passed a single Error argument when called.

	The stream is closed when the 'error' event is emitted unless the autoDestroy option was set to
	false when creating the stream.

	After 'error', no further events other than 'close' should be emitted (including 'error' events).

	The specified Block will be evaluated with the Error that occurred."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addListener: #error handler: aBlock
]

{ #category : #'event handling' }
CpNodeJSStreamWritable >> onFinishDo: aBlock [

	"The 'finish' event is emitted after the stream.end() method has been called, and all data has been flushed to the underlying system."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addListener: #finish handler: aBlock
]

{ #category : #'event handling' }
CpNodeJSStreamWritable >> onPipeDo: aBlock [

	"The 'pipe' event is emitted when the stream.pipe() method is called on a readable stream, adding this writable to its set of destinations.

	The specified Block will be evaluated with the Readable src stream."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addListener: #pipe handler: aBlock
]

{ #category : #'event handling' }
CpNodeJSStreamWritable >> onUnpipeDo: aBlock [

	"The 'unpipe' event is emitted when the stream.unpipe() method is called on a Readable stream, removing this Writable from its set of destinations.

	This is also emitted in case this Writable stream emits an error when a Readable stream pipes into it.

	The specified Block will be evaluated with the Readable src stream."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addListener: #unpipe handler: aBlock
]

{ #category : #accessing }
CpNodeJSStreamWritable >> setDefaultEncoding: aString [

	"The writable.setDefaultEncoding() method sets the default encoding for a Writable stream."

	self apply: #setDefaultEncoding withArguments: { aString }
]

{ #category : #operations }
CpNodeJSStreamWritable >> uncork [

	"The writable.uncork() method flushes all data buffered since stream.cork() was called.

	When using writable.cork() and writable.uncork() to manage the buffering of writes to a
	stream, defer calls to writable.uncork() using process.nextTick(). Doing so allows batching
	of all writable.write() calls that occur within a given Node.js event loop phase."

	self apply: #uncork
]

{ #category : #accessing }
CpNodeJSStreamWritable >> writable [

	"Is true if it is safe to call writable.write(), which means the stream has not been destroyed, errored, or ended."

	^ self propertyAt: #writable
]

{ #category : #accessing }
CpNodeJSStreamWritable >> writableCorked [

	"Number of times writable.uncork() needs to be called in order to fully uncork the stream."

	^ self propertyAt: #writableCorked
]

{ #category : #accessing }
CpNodeJSStreamWritable >> writableEnded [

	"Is true after writable.end() has been called. This property does not indicate whether the data has been flushed, for this use writable.writableFinished instead."

	^ self propertyAt: #writableEnded
]

{ #category : #accessing }
CpNodeJSStreamWritable >> writableFinised [

	"Is set to true immediately before the 'finish' event is emitted."

	^ self propertyAt: #writableFinished
]

{ #category : #accessing }
CpNodeJSStreamWritable >> writableHighWaterMark [

	"Return the value of highWaterMark passed when creating this Writable."

	^ self propertyAt: #writableHighWaterMark
]

{ #category : #accessing }
CpNodeJSStreamWritable >> writableLength [

	"This property contains the number of bytes (or objects) in the queue ready to be written. The value provides introspection data regarding the status of the highWaterMark."

	^ self propertyAt: #writableLength
]

{ #category : #accessing }
CpNodeJSStreamWritable >> writableNeedDrain [

	"Is true if the stream's buffer has been full and stream will emit 'drain'."

	^ self propertyAt: #writableNeedDrain
]

{ #category : #accessing }
CpNodeJSStreamWritable >> writableObjectMode [

	"Getter for the property objectMode of a given Writable stream."

	^ self propertyAt: #writableObjectMode
]

{ #category : #operations }
CpNodeJSStreamWritable >> writeChunk: anObject [

	self writeChunk: anObject withEncoding: nil thenDo: nil
]

{ #category : #operations }
CpNodeJSStreamWritable >> writeChunk: anObject thenDo: aBlock [

	self writeChunk: anObject withEncoding: nil thenDo: aBlock
]

{ #category : #operations }
CpNodeJSStreamWritable >> writeChunk: anObject withEncoding: aString [

	self writeChunk: anObject withEncoding: aString thenDo: nil
]

{ #category : #operations }
CpNodeJSStreamWritable >> writeChunk: anObject withEncoding: aString thenDo: aBlock [

	"The writable.write() method writes some data to the stream, and calls the supplied callback
	once the data has been fully handled. If an error occurs, the callback will be called with
	the error as its first argument. The callback is called asynchronously and before 'error' is
	emitted.

	The return value is true if the internal buffer is less than the highWaterMark configured when 
	he stream was created after admitting chunk. If false is returned, further attempts to write
	data to the stream should stop until the 'drain' event is emitted.

	While a stream is not draining, calls to write() will buffer chunk, and return false. Once all
	currently buffered chunks are drained (accepted for delivery by the operating system), the
	'drain' event will be emitted. Once write() returns false, do not write more chunks until the
	'drain' event is emitted. While calling write() on a stream that is not draining is allowed,
	Node.js will buffer all written chunks until maximum memory usage occurs, at which point it
	will abort unconditionally. Even before it aborts, high memory usage will cause poor garbage
	collector performance and high RSS (which is not typically released back to the system, even
	after the memory is no longer required). Since TCP sockets may never drain if the remote peer
	does not read the data, writing a socket that is not draining may lead to a remotely
	exploitable vulnerability.

	Writing data while the stream is not draining is particularly problematic for a Transform,
	because the Transform streams are paused by default until they are piped or a 'data' or
	'readable' event handler is added.

	If the data to be written can be generated or fetched on demand, it is recommended to
	encapsulate the logic into a Readable and use stream.pipe(). However, if calling write() is
	preferred, it is possible to respect backpressure and avoid memory issues using the 'drain'
	event."

	self apply: #write withArguments: { anObject . aString . aBlock }
]
