Class {
	#name : #CpNodeJSRestEndpointOperation,
	#superclass : #Object,
	#instVars : [
		'method',
		'pathPattern',
		'operation',
		'isBodyRequired',
		'authorizationBlock'
	],
	#classVars : [
		'Operations'
	],
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #'event handling' }
CpNodeJSRestEndpointOperation class >> handleRequest: aRestRequest response: aServerResponse [

	"Handle the specified message and answer true if handled"

	Operations ifNil: [ ^ false ].

	"Log the call in development"
	CpJavaScriptObject isDevelopmentEnvironment
		ifTrue: [ self traceCr: aRestRequest printString ].

	"Try each EndPointOperation until one succeeds in handling request"
	Operations valuesDo: [ :each |
		(each handleRequest: aRestRequest response: aServerResponse)
			ifTrue: [ ^ true ] ].

	"Not handled, means it was a bad request or resource not found"
	aServerResponse writeError: (aRestRequest method = 'GET'
		ifTrue: [ CpNodeJSRestNotFoundError ]
		ifFalse: [ CpNodeJSRestBadRequestError ]).

	^ false
]

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> new [

	self errorNewReplacedBy: #path:method:bodyRequired:operation:
]

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> path: aString deleteOperation: aMessageSend [

	^ self
		path: aString
		method: #DELETE
		bodyRequired: false
		operation: aMessageSend
]

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> path: aString getOperation: aMessageSend [

	^ self
		path: aString
		method: #GET
		bodyRequired: false
		operation: aMessageSend
]

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> path: aString method: aSymbol bodyRequired: aBoolean operation: aMessageSend [

	^ self basicNew
		initializeWithPath: aString method: aSymbol bodyRequired: aBoolean operation: aMessageSend ;
		yourself
]

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> path: aString patchOperation: aMessageSend [

	^ self
		path: aString
		method: #PATCH
		bodyRequired: true
		operation: aMessageSend
]

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> path: aString postOperation: aMessageSend [

	^ self
		path: aString
		method: #POST
		bodyRequired: true
		operation: aMessageSend
]

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> path: aString putOperation: aMessageSend [

	^ self
		path: aString
		method: #PUT
		bodyRequired: true
		operation: aMessageSend
]

{ #category : #registration }
CpNodeJSRestEndpointOperation class >> registerOperation: anEndPointOperation [

	Operations ifNil: [ Operations := Dictionary new ].

	Operations at: anEndPointOperation identifier put: anEndPointOperation.

	^ anEndPointOperation
]

{ #category : #registration }
CpNodeJSRestEndpointOperation class >> unregisterOperation: anEndPointOperation [

	Operations ifNil: [ ^ anEndPointOperation ].

	Operations removeKey: anEndPointOperation identifier ifAbsent: [ "ignore" ].

	^ anEndPointOperation
]

{ #category : #performing }
CpNodeJSRestEndpointOperation >> handleRequest: aRestRequest response: aServerResponse [

	"Handle the specified REST request and answer true if handled"

	method = aRestRequest method
		ifFalse: [ ^ false ].

	(pathPattern isNotNil and: [ pathPattern matchesPath: aRestRequest path ])
		ifTrue: [ aRestRequest setPathParameters: (pathPattern parametersFromPath: aRestRequest path) ]
		ifFalse: [ ^ false ].

	"Check authorization (authorization can not rely on body content atm)"
	(self isAuthorizedRequest: aRestRequest)
		ifFalse: [ CpNodeJSRestUnauthorizedError signal ].

	"Resolve the body (if required) and perform the operation"
	isBodyRequired
		ifTrue: [
			aRestRequest
				resolveBodyThenDo: [ self performOperationRequest: aRestRequest response: aServerResponse ]
				ifFail: [ :error | aServerResponse writeError: error ] ]
		ifFalse: [ self performOperationRequest: aRestRequest response: aServerResponse ].

	^ true
]

{ #category : #accessing }
CpNodeJSRestEndpointOperation >> identifier [

	"Answer an (internal) identifier for the receiver.

	Implementation:
	An identifier consisting off '<class><hash><selector>' is created."

	^ String streamContents: [ :stream |
		stream
			print: operation receiver class ;
			print: operation receiver identityHash ;
			print: operation selector ]
]

{ #category : #initialization }
CpNodeJSRestEndpointOperation >> initializeWithPath: aString method: aSymbol bodyRequired: aBoolean operation: aMessageSend [

	self initialize.

	pathPattern := CpNodeJSRestPathPattern fromString: aString.
	method := aSymbol.
	isBodyRequired := aBoolean.
	operation := aMessageSend
]

{ #category : #testing }
CpNodeJSRestEndpointOperation >> isAuthorizedRequest: aRestRequest [

	"Answer whether the specified REST Request is authorized to perform the operation.
	If no authorization Block is set, it is assumed this is a public endpoint and
	authorization is therefore okay.
	
	Implementation:
	Currently (see #handleRequest:response:) authorization is assumed to use information
	in either the request header or path. Information in the request body is not available
	when this method is performed. For now, use a custom authorization handler if authorization
	using body content is required."

	^ authorizationBlock
		ifNotNil: [ authorizationBlock value: aRestRequest ]
		ifNil: [ true ]
]

{ #category : #accessing }
CpNodeJSRestEndpointOperation >> method [

	^ method
]

{ #category : #accessing }
CpNodeJSRestEndpointOperation >> path [

	^ pathPattern asString
]

{ #category : #performing }
CpNodeJSRestEndpointOperation >> performOperationRequest: aRestRequest response: aServerResponse [

	"Perform the receiver's operation using the specified REST Request and Server Response"

	[ operation valueWithArguments: { aRestRequest . aServerResponse } ] on: Error do: [ :error |
		aServerResponse writableEnded
			ifFalse: [ aServerResponse writeError: error] ]
]

{ #category : #printing }
CpNodeJSRestEndpointOperation >> printOn: aStream [

	aStream
		nextPutAll: operation receiver class name ;
		nextPutAll: ' >> ' ;
		print: operation selector ;
		nextPutAll: ' at path "' ;
		nextPutAll: self path ;
		nextPutAll: '" for method ' ;
		nextPutAll: self method
]

{ #category : #accessing }
CpNodeJSRestEndpointOperation >> setAuthorizationBlock: aBlock [

	authorizationBlock := aBlock
]
