Class {
	#name : #CpJavaScriptAbortController,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #operations }
CpJavaScriptAbortController >> abort [

	"Aborts an asynchronous operation before it has completed. This is able to abort fetch requests, consumption of any response bodies, and streams."

	self apply: #abort
]

{ #category : #operations }
CpJavaScriptAbortController >> abort: reasonObject [

	"Aborts an asynchronous operation before it has completed. This is able to abort fetch requests, consumption of any response bodies, and streams."

	self apply: #abort withArguments: { reasonObject }
]

{ #category : #accessing }
CpJavaScriptAbortController >> signal [

	"Returns an AbortSignal object instance, which can be used to communicate with, or to abort, an asynchronous operation."

	^ self propertyAt: #signal resultAs: CpJavaScriptAbortSignal
]
