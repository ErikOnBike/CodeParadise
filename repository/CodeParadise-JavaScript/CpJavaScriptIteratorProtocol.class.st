"
I represent the JavaScript iterator protocol.
My methods #return: and #throw: might not be present and could lead
to an Error if called. Unfortunately JavaScipt does not allow checking
this using reflection.

See https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Iteration_protocols#the_iterator_protocol
"
Class {
	#name : #CpJavaScriptIteratorProtocol,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-JavaScript-Core'
}

{ #category : #convenience }
CpJavaScriptIteratorProtocol >> asArray [

	"Answer the receiver's iterated elements as an Array"

	^ (OrderedCollection streamContents: [ :stream |
		self do: [ :value | stream nextPut: value] ]) asArray
]

{ #category : #convenience }
CpJavaScriptIteratorProtocol >> do: aBlock [

	"Iterate over the receiver using Smalltalks #do:"

	| next |

	[ (next := self next) done ] whileFalse: [ aBlock value: next value]
]

{ #category : #accessing }
CpJavaScriptIteratorProtocol >> next [

	"A function that accepts zero or one argument and returns an object conforming to the IteratorResult interface"

	^ self apply: #next resultAs: CpJavaScriptIteratorResultInterface
]

{ #category : #accessing }
CpJavaScriptIteratorProtocol >> next: anObject [

	"A function that accepts zero or one argument and returns an object conforming to the IteratorResult interface"

	^ self apply: #next withArguments: { anObject } resultAs: CpJavaScriptIteratorResultInterface
]

{ #category : #accessing }
CpJavaScriptIteratorProtocol >> return [

	"A function that accepts zero or one argument and returns an object conforming to the IteratorResult interface,
	typically with value equal to the value passed in and done equal to true. Calling this method tells the iterator
	that the caller does not intend to make any more next() calls and can perform any cleanup actions. When built-in
	language features call return() for cleanup, value is always undefined."

	^ self apply: #return resultAs: CpJavaScriptIteratorResultInterface
]

{ #category : #accessing }
CpJavaScriptIteratorProtocol >> return: anObject [

	"A function that accepts zero or one argument and returns an object conforming to the IteratorResult interface,
	typically with value equal to the value passed in and done equal to true. Calling this method tells the iterator
	that the caller does not intend to make any more next() calls and can perform any cleanup actions. When built-in
	language features call return() for cleanup, value is always undefined."

	^ self apply: #return withArguments: { anObject } resultAs: CpJavaScriptIteratorResultInterface
]

{ #category : #accessing }
CpJavaScriptIteratorProtocol >> throw [

	"A function that accepts zero or one argument and returns an object conforming to the IteratorResult interface,
	typically with done equal to true. Calling this method tells the iterator that the caller detects an error condition,
	and exception is typically an Error instance. No built-in language feature calls throw() for cleanup purposes
	— it's a special feature of generators for the symmetry of return/throw."

	^ self apply: #throw resultAs: CpJavaScriptIteratorResultInterface
]

{ #category : #accessing }
CpJavaScriptIteratorProtocol >> throw: anError [

	"A function that accepts zero or one argument and returns an object conforming to the IteratorResult interface,
	typically with done equal to true. Calling this method tells the iterator that the caller detects an error condition,
	and exception is typically an Error instance. No built-in language feature calls throw() for cleanup purposes
	— it's a special feature of generators for the symmetry of return/throw."

	^ self apply: #throw withArguments: { anError } resultAs: CpJavaScriptIteratorResultInterface
]
