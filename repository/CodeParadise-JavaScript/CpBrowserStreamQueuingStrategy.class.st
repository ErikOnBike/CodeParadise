Class {
	#name : #CpBrowserStreamQueuingStrategy,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-JavaScript-Support'
}

{ #category : #accessing }
CpBrowserStreamQueuingStrategy >> highWaterMark [

	^ options at: #highWaterMark
]

{ #category : #accessing }
CpBrowserStreamQueuingStrategy >> highWaterMark: anInteger [

	"A non-negative integer — this defines the total number of chunks that can be contained in the internal queue before backpressure is applied."

	options at: #highWaterMark put: anInteger
]

{ #category : #accessing }
CpBrowserStreamQueuingStrategy >> size [

	options at: #size
]

{ #category : #accessing }
CpBrowserStreamQueuingStrategy >> size: aBlock [

	"Answer the size of the supplied chunk (given as first argument to the Block).

	A method containing a parameter chunk — this indicates the size to use for each chunk, in bytes."

	options at: #size put: aBlock
]
