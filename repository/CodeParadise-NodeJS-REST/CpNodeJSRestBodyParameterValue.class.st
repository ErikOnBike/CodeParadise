Class {
	#name : #CpNodeJSRestBodyParameterValue,
	#superclass : #CpNodeJSRestParameterValue,
	#category : #'CodeParadise-NodeJS-REST-Request'
}

{ #category : #testing }
CpNodeJSRestBodyParameterValue >> isResolved [

	^ value class ~= CpNodeJSHttpIncomingMessage
]

{ #category : #resolving }
CpNodeJSRestBodyParameterValue >> privateResolveThenDo: aBlock [

	"Resolve the receiver's value then evaluate the specified Block.
	It is assumed value is not resolved yet (and therefore still
	contains the IncomingMessage value).
	If an Error occurred the Error is kept as value.

	Implementation:
	See https://nodejs.org/en/learn/modules/anatomy-of-an-http-transaction"

	| buffer dataHandler endHandler errorHandler |

	buffer := OrderedCollection new.

	dataHandler := value onDataDo: [ :chunk | buffer add: chunk ].
	endHandler := value onEndDo: [
		value
			removeDataHandler: dataHandler ;
			removeEndHandler: endHandler ;
			removeErrorHandler: errorHandler.
		value := CpJavaScriptJSON parse: (CpNodeJSBuffer concat: buffer asArray) toString.
		aBlock value ].
	errorHandler := value onErrorDo: [ :error |
		value
			removeDataHandler: dataHandler ;
			removeEndHandler: endHandler ;
			removeErrorHandler: errorHandler.
		value := error.
		aBlock value ]
]

{ #category : #resolving }
CpNodeJSRestBodyParameterValue >> resolveThenDo: aBlock [

	"Resolve the receiver's value then evaluate the specified Block.
	If an Error occurred the error is used as value."

	self isResolved
		ifTrue: [ aBlock value ]
		ifFalse: [ self privateResolveThenDo: aBlock ]
]

{ #category : #accessing }
CpNodeJSRestBodyParameterValue >> value [

	"Answer the receiver's value.
	If the receiver is not resolved yet, raise an error."

	self isResolved
		ifFalse: [ self error: 'Body parameter needs to be resolved before asking its value' ].

	^ super value
]
