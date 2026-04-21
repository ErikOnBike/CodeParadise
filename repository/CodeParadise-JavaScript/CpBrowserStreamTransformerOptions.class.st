Class {
	#name : #CpBrowserStreamTransformerOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-JavaScript-Support'
}

{ #category : #accessing }
CpBrowserStreamTransformerOptions >> flush [

	^ options at: #flush
]

{ #category : #accessing }
CpBrowserStreamTransformerOptions >> flush: aBlock [

	"Flush the stream. The controller is passed as argument to the Block.

	Called after all chunks written to the writable side have been successfully transformed, and the writable side is about to be closed."

	options at: #flush put: aBlock
]

{ #category : #accessing }
CpBrowserStreamTransformerOptions >> start [

	^ options at: #start
]

{ #category : #accessing }
CpBrowserStreamTransformerOptions >> start: aBlock [

	"Initialize the stream. The controller is passed as argument to the Block.

	Called when the TransformStream is constructed. It is typically used to enqueue chunks using TransformStreamDefaultController.enqueue()."

	options at: #start put: aBlock
]

{ #category : #accessing }
CpBrowserStreamTransformerOptions >> transform [

	^ options at: #transform
]

{ #category : #accessing }
CpBrowserStreamTransformerOptions >> transform: aBlock [

	"Transform data. A chunk of data and the controller are passed as arguments to the Block.

	Called when a chunk written to the writable side is ready to be transformed, and performs the work of the transformation stream. It can return a promise to signal success or failure of the write operation. If no transform() method is supplied, the identity transform is used, and the chunk will be enqueued with no changes."

	options at: #transform put: aBlock
]
