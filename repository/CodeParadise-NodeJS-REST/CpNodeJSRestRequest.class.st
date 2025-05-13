"
I represent a REST Request. I am responsible for giving access to
request header, body and properties.
There is a limitation on the size of the body. The receiver's body will
not be read any further as soon as it becomes larger than the allowed size.

"
Class {
	#name : #CpNodeJSRestRequest,
	#superclass : #Object,
	#instVars : [
		'path',
		'pathParameters',
		'queryParameters',
		'body',
		'maxBodySize',
		'incomingMessage',
		'properties'
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
CpNodeJSRestRequest class >> maxBodySize [

	"Start with 64k as max body size (individual operations can override)"

	^ 65536
]

{ #category : #accessing }
CpNodeJSRestRequest >> body [

	"Answer the receiver's body as a CpNodeJSBuffer.

	Implementation:
	The receivers max body size is checked while reading in chunks of data.
	Create a Promise which we can await for the final result. The result will
	either be a Buffer or an Error will be signaled.

	See https://nodejs.org/en/learn/modules/anatomy-of-an-http-transaction"

	| promise |

	body ifNotNil: [ ^ body ].

	promise := CpJavaScriptPromise on: [ :resolveBlock :rejectBlock |

		| buffer size dataHandler endHandler errorHandler |

		"Start with empty body, just in case reading fails because it can't be read more than once"
		body := CpNodeJSBuffer from: ''.

		buffer := OrderedCollection new.
		size := 0.

		dataHandler := incomingMessage onDataDo: [ :chunk |
			size := size + chunk size.
			size > maxBodySize
				ifTrue: [
					incomingMessage
						removeListener: dataHandler ;
						removeListener: endHandler ;
						removeListener: errorHandler.
					rejectBlock value: CpNodeJSRestPayloadTooLargeError new ].
			buffer add: chunk ].
		endHandler := incomingMessage onEndDo: [
			incomingMessage
				removeListener: dataHandler ;
				removeListener: endHandler ;
				removeListener: errorHandler.
			[
				body := CpNodeJSBuffer concat: buffer asArray.
				resolveBlock value: body
			] on: Error do: [ :error |
				rejectBlock value: error ] ].
		errorHandler := incomingMessage onErrorDo: [ :error |
			incomingMessage
				removeListener: dataHandler ;
				removeListener: endHandler ;
				removeListener: errorHandler.
			rejectBlock value: error ] ].

	^ promise await
]

{ #category : #accessing }
CpNodeJSRestRequest >> contentLength [

	"Answer the Content-Length header of the receiver (as a Number)"

	^ (self headerAt: 'content-length')
		ifNotNil: [ :lengthString | lengthString asNumberOrNil ]
]

{ #category : #accessing }
CpNodeJSRestRequest >> contentType [

	"Answer the Content-Type header of the receiver"

	^ self headerAt: 'content-type'
]

{ #category : #testing }
CpNodeJSRestRequest >> hasHeaderAt: aSymbol [

	"Answer a Boolean stating whether the receiver has the specified header"

	^ (self headerAt: aSymbol) isNotNil
]

{ #category : #accessing }
CpNodeJSRestRequest >> headerAt: aSymbol [

	"Answer the value of the specified header
	or nil if the specified header value does not exist."

	^ incomingMessage headers
		at: aSymbol ifAbsent: [ nil ]
]

{ #category : #initialization }
CpNodeJSRestRequest >> initialize [

	super initialize.

	"Start with the default max body size"
	maxBodySize := self class maxBodySize
]

{ #category : #initialization }
CpNodeJSRestRequest >> initializeWithIncomingMessage: anIncomingMessage [

	| url |

	self initialize.

	url := CpBrowserURL newUrl: anIncomingMessage url base: 'http://localhost'.
	path := CpNodeJSRestPath fromString: url pathname.
	queryParameters := url searchParams asDictionary.
	incomingMessage := anIncomingMessage
]

{ #category : #accessing }
CpNodeJSRestRequest >> jsonBody [

	"Answer the body as JSON object"

	^ [ CpJavaScriptJSON parse: self body toString ] on: Error do: [ :error |
		self error: ('Failed to parse JSON: {1}' format: { error }) ]
]

{ #category : #accessing }
CpNodeJSRestRequest >> maxBodySize [

	^ maxBodySize
]

{ #category : #accessing }
CpNodeJSRestRequest >> maxBodySize: anInteger [

	maxBodySize := anInteger
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

{ #category : #accessing }
CpNodeJSRestRequest >> propertyAt: aSymbol [

	"Answer a custom property from the receiver (or nil if the property does not exist)"

	^ properties ifNotNil: [ properties at: #aSymbol ifAbsent: [ nil ] ]
]

{ #category : #accessing }
CpNodeJSRestRequest >> propertyAt: aSymbol put: anObject [

	"Set a custom property of the receiver"

	^ (properties ifNil: [ properties := Dictionary new ])
		at: #aSymbol put: anObject
]

{ #category : #accessing }
CpNodeJSRestRequest >> queryParameterAt: aSymbol [

	"Answer the query parameter with the specified name
	or nil if such a parameter does not exist"

	^ queryParameters at: aSymbol ifAbsent: [ nil ]
]

{ #category : #accessing }
CpNodeJSRestRequest >> queryParameters [

	^ queryParameters
]

{ #category : #private }
CpNodeJSRestRequest >> setPathParameters: aDictionary [

	"Set the actual path parameters for the receiver.
	This allows the REST service to request path parameter values.

	Implementation:
	Setting these parameter values is a collaboration between the
	EndpointOperation and the receiver.
	See CpNodeJSRestEndpointOperation >> #handleRequest:response:"

	pathParameters := aDictionary
]

{ #category : #accessing }
CpNodeJSRestRequest >> url [

	^ incomingMessage url
]
