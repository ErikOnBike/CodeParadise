Class {
	#name : #CpBrowserReadableStreamDefaultReader,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-Streams'
}

{ #category : #actions }
CpBrowserReadableStreamDefaultReader >> cancel [

	^ self cancelWithReason: nil
]

{ #category : #actions }
CpBrowserReadableStreamDefaultReader >> cancelWithReason: aString [

	"Returns a Promise that resolves when the stream is canceled. Calling this method signals a loss of interest in the stream by a consumer. The supplied reason argument will be given to the underlying source, which may or may not use it."

	^ self apply: #cancel withArguments: { aString } resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpBrowserReadableStreamDefaultReader >> closed [

	"Returns a Promise that fulfills when the stream closes, or rejects if the stream throws an error or the reader's lock is released. This property enables you to write code that responds to an end to the streaming process."

	^ self propertyAt: #closed
]

{ #category : #actions }
CpBrowserReadableStreamDefaultReader >> read [

	"Returns a promise providing access to the next chunk in the stream's internal queue."

	^ self apply: #read resultAs: CpJavaScriptPromise
]

{ #category : #actions }
CpBrowserReadableStreamDefaultReader >> releaseLock [

	"Releases the reader's lock on the stream."

	^ self apply: #releaseLock
]
