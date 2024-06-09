Class {
	#name : #CpNodeJSRestRequest,
	#superclass : #Object,
	#instVars : [
		'path',
		'body',
		'incomingMessage'
	],
	#category : #'CodeParadise-NodeJS-REST-Request'
}

{ #category : #'instance creation' }
CpNodeJSRestRequest class >> fromIncomingMessage: anIncomingMessage [

	^ self basicNew
		initializeWithIncomingMessage: anIncomingMessage ;
		yourself
]

{ #category : #accessing }
CpNodeJSRestRequest >> body [

	"Answer the body of the request.

	Implementation:
	This method should only be called after #resolveBodyThenDo:ifFail:
	Otherwise no value is present."

	^ body
]

{ #category : #accessing }
CpNodeJSRestRequest >> headerAt: aSymbol [

	"Answer the value of the specified header
	or nil if the specified header value does not exist."

	^ incomingMessage headers
		at: aSymbol ifAbsent: [ nil ]
]

{ #category : #initialization }
CpNodeJSRestRequest >> initializeWithIncomingMessage: anIncomingMessage [

	| url |

	self initialize.

	url := CpJavaScriptURL newUrl: anIncomingMessage url base: 'http://localhost'.
	path := CpNodeJSRestPath fromString: url pathname.
	incomingMessage := anIncomingMessage
]

{ #category : #accessing }
CpNodeJSRestRequest >> jsonBody [

	"Answer the body as JSON object"

	body ifNil: [ ^ nil ].

	^ CpJsonObject fromString: body
]

{ #category : #accessing }
CpNodeJSRestRequest >> method [

	^ incomingMessage method
]

{ #category : #accessing }
CpNodeJSRestRequest >> path [

	^ path
]

{ #category : #resolving }
CpNodeJSRestRequest >> resolveBodyThenDo: aBlock ifFail: exceptionBlock [

	"Resolve the receiver's body value then evaluate the specified Block.
	If an Error occurred perform the exception Block with the error culled.
	It is assumed this method is called once on an incoming message.

	Implementation:
	See https://nodejs.org/en/learn/modules/anatomy-of-an-http-transaction"

	| buffer dataHandler endHandler errorHandler |

	buffer := OrderedCollection new.

	dataHandler := incomingMessage onDataDo: [ :chunk | buffer add: chunk ].
	endHandler := incomingMessage onEndDo: [
		incomingMessage
			removeDataHandler: dataHandler ;
			removeEndHandler: endHandler ;
			removeErrorHandler: errorHandler.
		body := CpJavaScriptJSON parse: (CpNodeJSBuffer concat: buffer asArray) toString.
		aBlock value ].
	errorHandler := incomingMessage onErrorDo: [ :error |
		incomingMessage
			removeDataHandler: dataHandler ;
			removeEndHandler: endHandler ;
			removeErrorHandler: errorHandler.
		exceptionBlock cull: error ]
]
