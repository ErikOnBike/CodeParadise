Class {
	#name : #CpJavaScriptIteratorResultInterface,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-JavaScript-Core'
}

{ #category : #accessing }
CpJavaScriptIteratorResultInterface >> done [

	"A boolean that's false if the iterator was able to produce the next value in the sequence.
	(This is equivalent to not specifying the done property altogether.)

	Has the value true if the iterator has completed its sequence. In this case, value optionally specifies the return value of the iterator.

	Implementation:
	Convert result to a Boolean in all cases. Use #rawDone to receive the property without conversion."

	^ self rawDone == true
]

{ #category : #accessing }
CpJavaScriptIteratorResultInterface >> rawDone [

	"A boolean that's false if the iterator was able to produce the next value in the sequence.
	(This is equivalent to not specifying the done property altogether.)

	Has the value true if the iterator has completed its sequence. In this case, value optionally specifies the return value of the iterator."

	^ self propertyAt: #done
]

{ #category : #accessing }
CpJavaScriptIteratorResultInterface >> value [

	"Any JavaScript value returned by the iterator. Can be omitted when done is true"

	^ self propertyAt: #value
]
