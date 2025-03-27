"
I represent both the Browser ReadableStream and the Node.js ReadableStream.
These classes are similar enough to have to same proxy implementation.
"
Class {
	#name : #CpBrowserReadableStream,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-JavaScript-Shared'
}

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
