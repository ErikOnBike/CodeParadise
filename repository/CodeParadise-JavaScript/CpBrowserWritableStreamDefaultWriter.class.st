Class {
	#name : #CpBrowserWritableStreamDefaultWriter,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-JavaScript-Shared'
}

{ #category : #'instance creation' }
CpBrowserWritableStreamDefaultWriter class >> stream: aWritableStream [

	"Creates a new WritableStreamDefaultWriter object instance."

	^ self newInstanceWithArguments: { aWritableStream }
]

{ #category : #operations }
CpBrowserWritableStreamDefaultWriter >> abort [

	^ self abortWithReason: nil
]

{ #category : #operations }
CpBrowserWritableStreamDefaultWriter >> abortWithReason: aString [

	"Aborts the stream, signaling that the producer can no longer successfully write to the stream and it is to be immediately moved to an error state, with any queued writes discarded."

	^ self apply: #abort withArguments: { aString } resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpBrowserWritableStreamDefaultWriter >> close [

	"Closes the associated writable stream."

	^ self apply: #close resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpBrowserWritableStreamDefaultWriter >> closed [

	"Allows you to write code that responds to an end to the streaming process. Returns a promise that fulfills if the stream becomes closed, or rejects if the stream errors or the writer's lock is released."

	^ self propertyAt: #closed
]

{ #category : #accessing }
CpBrowserWritableStreamDefaultWriter >> desiredSize [

	"Returns the desired size required to fill the stream's internal queue."

	^ self propertyAt: #desiredSize
]

{ #category : #accessing }
CpBrowserWritableStreamDefaultWriter >> ready [

	"Returns a Promise that resolves when the desired size of the stream's internal queue transitions from non-positive to positive, signaling that it is no longer applying backpressure."

	^ self propertyAt: #ready resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpBrowserWritableStreamDefaultWriter >> releaseLock [

	"Releases the writer's lock on the corresponding stream. After the lock is released, the writer is no longer active. If the associated stream is errored when the lock is released, the writer will appear errored in the same way from now on; otherwise, the writer will appear closed."

	self apply: #releaseLock
]

{ #category : #operations }
CpBrowserWritableStreamDefaultWriter >> write: anObject [

	"Writes a passed chunk of data to a WritableStream and its underlying sink, then returns a Promise that resolves to indicate the success or failure of the write operation."

	^ self apply: #write withArguments: { anObject } resultAs: CpJavaScriptPromise
]
