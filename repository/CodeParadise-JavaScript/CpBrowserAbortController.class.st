"
I represent both the Browser AbortController and the Node.js AbortController.
These classes are similar enough to have to same proxy implementation.
"
Class {
	#name : #CpBrowserAbortController,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-JavaScript-Shared'
}

{ #category : #operations }
CpBrowserAbortController >> abort [

	"Aborts an asynchronous operation before it has completed. This is able to abort fetch requests, consumption of any response bodies, and streams."

	self apply: #abort
]

{ #category : #operations }
CpBrowserAbortController >> abort: reasonObject [

	"Aborts an asynchronous operation before it has completed. This is able to abort fetch requests, consumption of any response bodies, and streams."

	self apply: #abort withArguments: { reasonObject }
]

{ #category : #accessing }
CpBrowserAbortController >> signal [

	"Returns an AbortSignal object instance, which can be used to communicate with, or to abort, an asynchronous operation."

	^ self propertyAt: #signal resultAs: CpBrowserAbortSignal
]
