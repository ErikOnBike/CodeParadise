Class {
	#name : #CpNodeJSStreamReadable,
	#superclass : #CpJavaScriptEventTarget,
	#category : #'CodeParadise-NodeJS-Support-Stream'
}

{ #category : #accessing }
CpNodeJSStreamReadable class >> module [

	"Answer the module the receiver is part of"

	^ CpNodeJSStream
]

{ #category : #accessing }
CpNodeJSStreamReadable >> closed [

	"Is true after 'close' has been emitted."

	^ self propertyAt: #closed
]

{ #category : #operations }
CpNodeJSStreamReadable >> destroy [

	self destroyWithError: nil
]

{ #category : #operations }
CpNodeJSStreamReadable >> destroyWithError: anError [

	"Destroy the stream. Optionally emit an 'error' event, and emit a 'close' event (unless emitClose
	is set to false). After this call, the readable stream will release any internal resources and
	subsequent calls to push() will be ignored.

	Once destroy() has been called any further calls will be a no-op and no further errors except
	from _destroy() may be emitted as 'error'.

	Implementors should not override this method, but instead implement readable._destroy()."

	self apply: #destroy withArguments: { anError }
]

{ #category : #accessing }
CpNodeJSStreamReadable >> destroyed [

	"Is true after readable.destroy() has been called."

	^ self propertyAt: #destroyed
]

{ #category : #accessing }
CpNodeJSStreamReadable >> isPaused [

	"The readable.isPaused() method returns the current operating state of the Readable. This is used
	primarily by the mechanism that underlies the readable.pipe() method. In most typical cases, there
	will be no reason to use this method directly."

	^ self apply: #isPaused
]

{ #category : #'event handling' }
CpNodeJSStreamReadable >> onCloseDo: aBlock [

	"The 'close' event is emitted when the stream and any of its underlying resources (a file descriptor,
	for example) have been closed. The event indicates that no more events will be emitted, and no further
	computation will occur.

	A Readable stream will always emit the 'close' event if it is created with the emitClose option."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addEventListener: #close handler: aBlock
]

{ #category : #'event handling' }
CpNodeJSStreamReadable >> onDataDo: aBlock [

	"The 'data' event is emitted whenever the stream is relinquishing ownership of a chunk of
	data to a consumer. This may occur whenever the stream is switched in flowing mode by calling
	readable.pipe(), readable.resume(), or by attaching a listener callback to the 'data' event.
	The 'data' event will also be emitted whenever the readable.read() method is called and a
	chunk of data is available to be returned.

	Attaching a 'data' event listener to a stream that has not been explicitly paused will switch
	the stream into flowing mode. Data will then be passed as soon as it is available.

	The listener callback will be passed the chunk of data as a string if a default encoding has
	been specified for the stream using the readable.setEncoding() method; otherwise the data will
	be passed as a Buffer.

	The specified Block will be evaluated with the data chunk.""

	chunk <Buffer> | <string> | <any> The chunk of data. For streams that are not operating in
	object mode, the chunk will be either a string or Buffer. For streams that are in object mode,
	the chunk can be any JavaScript value other than null."

	^ self addEventListener: #data handler: aBlock
]

{ #category : #'event handling' }
CpNodeJSStreamReadable >> onEndDo: aBlock [

	"The 'end' event is emitted when there is no more data to be consumed from the stream.

	The 'end' event will not be emitted unless the data is completely consumed. This can be accomplished
	by switching the stream into flowing mode, or by calling stream.read() repeatedly until all data has
	been consumed."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addEventListener: #end handler: aBlock
]

{ #category : #'event handling' }
CpNodeJSStreamReadable >> onErrorDo: aBlock [

	"The 'error' event may be emitted by a Readable implementation at any time. Typically, this may
	occur if the underlying stream is unable to generate data due to an underlying internal failure,
	or when a stream implementation attempts to push an invalid chunk of data.

	The listener callback will be passed a single Error object."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addEventListener: #error handler: aBlock
]

{ #category : #'event handling' }
CpNodeJSStreamReadable >> onPauseDo: aBlock [

	"The 'pause' event is emitted when stream.pause() is called and readableFlowing is not false."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addEventListener: #pause handler: aBlock
]

{ #category : #'event handling' }
CpNodeJSStreamReadable >> onReadableDo: aBlock [

	"The 'readable' event is emitted when there is data available to be read from the stream or when
	the end of the stream has been reached. Effectively, the 'readable' event indicates that the stream
	has new information. If data is available, stream.read() will return that data."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addEventListener: #readable handler: aBlock
]

{ #category : #'event handling' }
CpNodeJSStreamReadable >> onResumeDo: aBlock [

	"The 'resume' event is emitted when stream.resume() is called and readableFlowing is not true."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addEventListener: #resume handler: aBlock
]

{ #category : #operations }
CpNodeJSStreamReadable >> pause [

	"The readable.pause() method will cause a stream in flowing mode to stop emitting 'data'
	events, switching out of flowing mode. Any data that becomes available will remain in the
	internal buffer."

	self apply: #pause
]

{ #category : #operations }
CpNodeJSStreamReadable >> pipeTo: aWritableStream [

	^ self pipeTo: aWritableStream withOptions: nil
]

{ #category : #operations }
CpNodeJSStreamReadable >> pipeTo: aWritableStream withOptions: aDictionary [

	"The readable.pipe() method attaches a Writable stream to the readable, causing it to switch
	automatically into flowing mode and push all of its data to the attached Writable. The flow of
	data will be automatically managed so that the destination Writable stream is not overwhelmed
	by a faster Readable stream."

	^ self apply: #pipe withArguments: { aWritableStream . aDictionary } resultAs: CpNodeJSStreamWritable
]

{ #category : #operations }
CpNodeJSStreamReadable >> push: anObject [

	self push: anObject withEncoding: nil
]

{ #category : #operations }
CpNodeJSStreamReadable >> push: anObject withEncoding: aString [

	"When chunk is a Buffer, Uint8Array, or string, the chunk of data will be added to the internal queue
	for users of the stream to consume. Passing chunk as null signals the end of the stream (EOF), after
	which no more data can be written.

	When the Readable is operating in paused mode, the data added with readable.push() can be read out by
	calling the readable.read() method when the 'readable' event is emitted.

	When the Readable is operating in flowing mode, the data added with readable.push() will be delivered
	by emitting a 'data' event."

	self apply: #push withArguments: { anObject . aString }
]

{ #category : #operations }
CpNodeJSStreamReadable >> read [

	"Read a chunk"

	^ self read: nil
]

{ #category : #operations }
CpNodeJSStreamReadable >> read: anInteger [

	"The readable.read() method reads data out of the internal buffer and returns it. If no data is
	available to be read, null is returned. By default, the data is returned as a Buffer object unless
	an encoding has been specified using the readable.setEncoding() method or the stream is operating
	in object mode.

	The optional size argument specifies a specific number of bytes to read. If size bytes are not
	available to be read, null will be returned unless the stream has ended, in which case all of the
	data remaining in the internal buffer will be returned.

	If the size argument is not specified, all of the data contained in the internal buffer will be
	returned.

	The size argument must be less than or equal to 1 GiB.

	The readable.read() method should only be called on Readable streams operating in paused mode. In
	flowing mode, readable.read() is called automatically until the internal buffer is fully drained."

	^ self apply: #read withArguments: { anInteger }
]

{ #category : #accessing }
CpNodeJSStreamReadable >> readable [

	"Is true if it is safe to call readable.read(), which means the stream has not been destroyed or emitted 'error' or 'end'."

	^ self propertyAt: #readable
]

{ #category : #accessing }
CpNodeJSStreamReadable >> readableEncoding [

	"Getter for the property encoding of a given Readable stream. The encoding property can be set using the readable.setEncoding() method."

	^ self propertyAt: #readableEncoding
]

{ #category : #accessing }
CpNodeJSStreamReadable >> readableEnded [

	"Becomes true when 'end' event is emitted."

	^ self propertyAt: #readableEnded
]

{ #category : #accessing }
CpNodeJSStreamReadable >> readableErrored [

	"Returns error if the stream has been destroyed with an error."

	^ self propertyAt: #readableErrored
]

{ #category : #accessing }
CpNodeJSStreamReadable >> readableFlowing [

	"This property reflects the current state of a Readable stream as described in the Three states section."

	^ self propertyAt: #readableFlowing
]

{ #category : #accessing }
CpNodeJSStreamReadable >> readableHighWaterMark [

	"Returns the value of highWaterMark passed when creating this Readable."

	^ self propertyAt: #readableHighWaterMark
]

{ #category : #accessing }
CpNodeJSStreamReadable >> readableLength [

	"This property contains the number of bytes (or objects) in the queue ready to be read. The value provides introspection data regarding the status of the highWaterMark."

	^ self propertyAt: #readableLength
]

{ #category : #accessing }
CpNodeJSStreamReadable >> readableObjectMode [

	"Getter for the property objectMode of a given Readable stream."

	^ self propertyAt: #readableObjectMode
]

{ #category : #'event handling' }
CpNodeJSStreamReadable >> removeCloseHandler: aFunction [

	"Remove an earlier installed event listener
	(using the handler which was answered during installation)"

	self removeEventListener: #close handler: aFunction
]

{ #category : #'event handling' }
CpNodeJSStreamReadable >> removeDataHandler: aFunction [

	"Remove an earlier installed event listener
	(using the handler which was answered during installation)"

	self removeEventListener: #data handler: aFunction
]

{ #category : #'event handling' }
CpNodeJSStreamReadable >> removeEndHandler: aFunction [

	"Remove an earlier installed event listener
	(using the handler which was answered during installation)"

	self removeEventListener: #end handler: aFunction
]

{ #category : #'event handling' }
CpNodeJSStreamReadable >> removeErrorHandler: aFunction [

	"Remove an earlier installed event listener
	(using the handler which was answered during installation)"

	self removeEventListener: #error handler: aFunction
]

{ #category : #'event handling' }
CpNodeJSStreamReadable >> removePauseHandler: aFunction [

	"Remove an earlier installed event listener
	(using the handler which was answered during installation)"

	self removeEventListener: #pause handler: aFunction
]

{ #category : #'event handling' }
CpNodeJSStreamReadable >> removeReadableHandler: aFunction [

	"Remove an earlier installed event listener
	(using the handler which was answered during installation)"

	self removeEventListener: #readable handler: aFunction
]

{ #category : #'event handling' }
CpNodeJSStreamReadable >> removeResumeHandler: aFunction [

	"Remove an earlier installed event listener
	(using the handler which was answered during installation)"

	self removeEventListener: #resume handler: aFunction
]

{ #category : #operations }
CpNodeJSStreamReadable >> resume [

	"The readable.resume() method causes an explicitly paused Readable stream to resume emitting 'data' events, switching the stream into flowing mode."

	self apply: #resume
]

{ #category : #operations }
CpNodeJSStreamReadable >> setEncoding: aString [

	"The readable.setEncoding() method sets the character encoding for data read from the Readable stream.

	By default, no encoding is assigned and stream data will be returned as Buffer objects. Setting an
	encoding causes the stream data to be returned as strings of the specified encoding rather than as
	Buffer objects. For instance, calling readable.setEncoding('utf8') will cause the output data to be
	interpreted as UTF-8 data, and passed as strings. Calling readable.setEncoding('hex') will cause the
	data to be encoded in hexadecimal string format.

	The Readable stream will properly handle multi-byte characters delivered through the stream that would
	otherwise become improperly decoded if simply pulled from the stream as Buffer objects."

	self apply: #setEncoding withArguments: { aString }
]

{ #category : #operations }
CpNodeJSStreamReadable >> unpipe [

	"Unpipe from all destinations"

	self unpipeFrom: nil
]

{ #category : #operations }
CpNodeJSStreamReadable >> unpipeFrom: aWriteableStream [

	"The readable.unpipe() method detaches a Writable stream previously attached using the
	stream.pipe() method.

	If the destination is not specified, then all pipes are detached.

	If the destination is specified, but no pipe is set up for it, then the method does nothing."

	self apply: #unpipe withArguments: { aWriteableStream }
]

{ #category : #operations }
CpNodeJSStreamReadable >> unshift: anObject [

	self unshift: anObject withEncoding: nil
]

{ #category : #operations }
CpNodeJSStreamReadable >> unshift: anObject withEncoding: aString [

	"Passing chunk as null signals the end of the stream (EOF) and behaves the same as readable.push(null),
	after which no more data can be written. The EOF signal is put at the end of the buffer and any
	buffered data will still be flushed.

	The readable.unshift() method pushes a chunk of data back into the internal buffer. This is useful in
	certain situations where a stream is being consumed by code that needs to ""un-consume"" some amount
	of data that it has optimistically pulled out of the source, so that the data can be passed on to some
	other party.

	The stream.unshift(chunk) method cannot be called after the 'end' event has been emitted or a runtime
	error will be thrown.

	Developers using stream.unshift() often should consider switching to use of a Transform stream instead.
	See the API for stream implementers section for more information."

	self apply: #unshift withArguments: { anObject . aString }
]
