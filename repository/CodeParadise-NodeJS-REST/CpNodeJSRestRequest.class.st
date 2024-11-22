Class {
	#name : #CpNodeJSRestRequest,
	#superclass : #Object,
	#instVars : [
		'path',
		'pathParameters',
		'body',
		'incomingMessage'
	],
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #'instance creation' }
CpNodeJSRestRequest class >> fromIncomingMessage: anIncomingMessage [

	^ self basicNew
		initializeWithIncomingMessage: anIncomingMessage ;
		yourself
]

{ #category : #accessing }
CpNodeJSRestRequest >> body [

	"Answer the raw body (a Node.js Buffer) of the request.

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

	^ [ CpJavaScriptJSON parse: body toString ] on: Error do: [ :error |
		self error: ('Failed to parse JSON: {1}' format: { error }) ]
]

{ #category : #accessing }
CpNodeJSRestRequest >> method [

	^ incomingMessage method
]

{ #category : #accessing }
CpNodeJSRestRequest >> path [

	^ path
]

{ #category : #accessing }
CpNodeJSRestRequest >> pathParameterAt: aSymbol [

	"Answer the path parameter with the specified name
	or nil if such a parameter does not exist"

	^ pathParameters at: aSymbol ifAbsent: [ nil ]
]

{ #category : #accessing }
CpNodeJSRestRequest >> pathParameters [

	^ pathParameters
]

{ #category : #printing }
CpNodeJSRestRequest >> printOn: aStream [

	aStream
		nextPutAll: self class name ;
		nextPutAll:  ' HTTP' ;
		nextPutAll: incomingMessage httpVersion ;
		space ; 
		nextPutAll: self method ;
		space ;
		nextPutAll: incomingMessage url.

	incomingMessage headers keysAndValuesDo: [ :key :value |
		aStream
			nextPutAll: ' (' ;
			print: key ;
			nextPutAll: ' -> ' ;
			print: ((#(#Authorization #password) includes: key)
				ifTrue: [ '***' ]
				ifFalse: [ value ]) ;
			nextPut: $) ]
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
			removeListener: dataHandler ;
			removeListener: endHandler ;
			removeListener: errorHandler.
		[
			body := CpNodeJSBuffer concat: buffer asArray.
			aBlock value
		] on: Error do: [ :error |
			exceptionBlock cull: error ] ].
	errorHandler := incomingMessage onErrorDo: [ :error |
		incomingMessage
			removeListener: dataHandler ;
			removeListener: endHandler ;
			removeListener: errorHandler.
		exceptionBlock cull: error ]
]

{ #category : #private }
CpNodeJSRestRequest >> setPathParameters: aDictionary [

	pathParameters := aDictionary
]
