Class {
	#name : 'CpNodeJSHttpServerResponse',
	#superclass : 'CpNodeJSHttpOutgoingMessage',
	#category : 'CodeParadise-NodeJS-Support-Http',
	#package : 'CodeParadise-NodeJS-Support',
	#tag : 'Http'
}

{ #category : 'class initialization' }
CpNodeJSHttpServerResponse class >> postInstallOnce [

	"Pre-load the relevant classes"

	CpNodeJSStreamDuplex beLoaded
]

{ #category : 'accessing' }
CpNodeJSHttpServerResponse >> req [

	"A reference to the original HTTP request object."

	^ self propertyAt: #req
]

{ #category : 'accessing' }
CpNodeJSHttpServerResponse >> sendDate [

	"When true, the Date header will be automatically generated and sent in the response if it is not already present in the headers. Defaults to true.

	This should only be disabled for testing; HTTP requires the Date header in responses."

	^ self propertyAt: #sendDate
]

{ #category : 'accessing' }
CpNodeJSHttpServerResponse >> sendDate: aBoolean [

	"When true, the Date header will be automatically generated and sent in the response if it is not already present in the headers. Defaults to true.

	This should only be disabled for testing; HTTP requires the Date header in responses."

	self propertyAt: #sendDate put: aBoolean
]

{ #category : 'accessing' }
CpNodeJSHttpServerResponse >> statusCode [

	"When using implicit headers (not calling response.writeHead() explicitly), this property controls the status code that will be sent to the client when the headers get flushed."

	^ self propertyAt: #statusCode
]

{ #category : 'accessing' }
CpNodeJSHttpServerResponse >> statusCode: anInteger [

	"When using implicit headers (not calling response.writeHead() explicitly), this property controls the status code that will be sent to the client when the headers get flushed."

	self propertyAt: #statusCode put: anInteger
]

{ #category : 'accessing' }
CpNodeJSHttpServerResponse >> statusMessage [

	"When using implicit headers (not calling response.writeHead() explicitly), this property controls the status message that will be sent to the client when the headers get flushed. If this is left as undefined then the standard message for the status code will be used."

	^ self propertyAt: #statusMessage
]

{ #category : 'accessing' }
CpNodeJSHttpServerResponse >> statusMessage: aString [

	"When using implicit headers (not calling response.writeHead() explicitly), this property controls the status message that will be sent to the client when the headers get flushed. If this is left as undefined then the standard message for the status code will be used."

	self propertyAt: #statusMessage put: aString
]

{ #category : 'accessing' }
CpNodeJSHttpServerResponse >> strictContentLength [

	"If set to true, Node.js will check whether the Content-Length header value and the size of the body, in bytes, are equal. Mismatching the Content-Length header value will result in an Error being thrown, identified by code: 'ERR_HTTP_CONTENT_LENGTH_MISMATCH'."

	^ self propertyAt: #strictContentLength
]

{ #category : 'accessing' }
CpNodeJSHttpServerResponse >> strictContentLength: aBoolean [

	"If set to true, Node.js will check whether the Content-Length header value and the size of the body, in bytes, are equal. Mismatching the Content-Length header value will result in an Error being thrown, identified by code: 'ERR_HTTP_CONTENT_LENGTH_MISMATCH'."

	self propertyAt: #strictContentLength put: aBoolean
]

{ #category : 'operations' }
CpNodeJSHttpServerResponse >> writeContinue [

	"Sends an HTTP/1.1 100 Continue message to the client, indicating that the request body should be sent. See the 'checkContinue' event on Server."

	self apply: #writeContinue
]

{ #category : 'operations' }
CpNodeJSHttpServerResponse >> writeEarlyHints: aDictionary [

	self writeEarlyHints: aDictionary thenDo: nil
]

{ #category : 'operations' }
CpNodeJSHttpServerResponse >> writeEarlyHints: aDictionary thenDo: aBlock [

	"Sends an HTTP/1.1 103 Early Hints message to the client with a Link header, indicating that the user agent can preload/preconnect the linked resources. The hints is an object containing the values of headers to be sent with early hints message. The optional callback argument will be called when the response message has been written."

	self apply: #writeEarlyHints withArguments: { aDictionary . aBlock }
]

{ #category : 'operations' }
CpNodeJSHttpServerResponse >> writeHeadCode: anInteger [

	self writeHeadCode: anInteger message: nil headers: nil
]

{ #category : 'operations' }
CpNodeJSHttpServerResponse >> writeHeadCode: anInteger message: aString [

	self writeHeadCode: anInteger message: aString headers: nil
]

{ #category : 'operations' }
CpNodeJSHttpServerResponse >> writeHeadCode: anInteger message: aString headers: aDictionary [

	"Sends a response header to the request. The status code is a 3-digit HTTP status code, like 404.
	The last argument, headers, are the response headers. Optionally one can give a human-readable
	statusMessage as the second argument.

	headers may be an Array where the keys and values are in the same list. It is not a list of tuples.
	So, the even-numbered offsets are key values, and the odd-numbered offsets are the associated values.
	The array is in the same format as request.rawHeaders."

	self apply: #writeHead withArguments: { anInteger . aString . aDictionary }
]

{ #category : 'operations' }
CpNodeJSHttpServerResponse >> writeProcessing [

	"Sends a HTTP/1.1 102 Processing message to the client, indicating that the request body should be sent."

	^ self apply: #writeProcessing
]
