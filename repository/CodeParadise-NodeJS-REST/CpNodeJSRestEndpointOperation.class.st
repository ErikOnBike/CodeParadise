"
I represent the endpoint for a REST service.
I am responsible for validating whether I can handle a REST Request
and for handling such a Request.

EndPoints need to be registered using my class side method #registerOperation:
An EndPoint is created using one of the instance creation methods:
	path:getOperation:
	path:postOperation:
	path:putOperation:
	path:patchOperation:
	path:deleteOperation:

The operation provided during instantiation should be a MessageSend.
From this MessageSend the CompiledMethod performing the actual request operation
can be extracted. In the CompiledMethod a number of pragma's is used to define
the operation's behavior. The following pragma's are supported:

For authorization:
	<public>
	<authorization: #selector:>

If <authorization:> is present, its argument needs to be a selector accepting
a single argument (the CpNodeJSRestRequest instance). This selector should be
available on the same object as the endpoint operation itself. If no <public>
(nor <authorization:> is present, the default selector #isAuthorizedRequest:
will be used. And finally if only <public> is specified, #isPublicAuthorizedRequest:
is used.

When using the Request body a maximum body size can be specified (that is, per
endpoint). This is done using the following pragma:
	<maxBodySize: 100000>

The default max body size is defined in:
	CpNodeRestJSRestRequest class >> #maxBodySize
"
Class {
	#name : #CpNodeJSRestEndpointOperation,
	#superclass : #Object,
	#instVars : [
		'method',
		'pathPattern',
		'operation'
	],
	#classVars : [
		'Operations'
	],
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #request }
CpNodeJSRestEndpointOperation class >> handleRequestIn: aRequestProcess [

	"Handle the REST Request in the specified RequestProcess or notify it is unhandled"

	| request response |

	Operations ifNil: [
		aRequestProcess unhandled.
		^ self ].

	"Log the call in development"
	CpJavaScriptObject isDevelopmentEnvironment
		ifTrue: [ self traceCr: aRequestProcess printString ].

	request := aRequestProcess request.
	response := aRequestProcess response.

	Operations
		detect: [ :each | each canHandleRequest: request ]
		ifFound: [ :endpointOperation | endpointOperation handleRequest: request response: response ]
		ifNone: [ aRequestProcess unhandled ].

	"Log the call in development"
	CpJavaScriptObject isDevelopmentEnvironment
		ifTrue: [ self traceCr: aRequestProcess printString ]
]

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> new [

	self errorNewReplacedBy: #path:method:operation:
]

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> path: aString deleteOperation: aMessageSend [

	^ self
		path: aString
		method: #DELETE
		operation: aMessageSend
]

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> path: aString getOperation: aMessageSend [

	^ self
		path: aString
		method: #GET
		operation: aMessageSend
]

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> path: aString method: aSymbol operation: aMessageSend [

	^ self basicNew
		initializeWithPath: aString method: aSymbol operation: aMessageSend ;
		yourself
]

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> path: aString patchOperation: aMessageSend [

	^ self
		path: aString
		method: #PATCH
		operation: aMessageSend
]

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> path: aString postOperation: aMessageSend [

	^ self
		path: aString
		method: #POST
		operation: aMessageSend
]

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> path: aString putOperation: aMessageSend [

	^ self
		path: aString
		method: #PUT
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

{ #category : #accessing }
CpNodeJSRestEndpointOperation >> authorizationOperation [

	"Answer a MessageSend which performs the authorization for a given REST Request
	(i.e. a single argument MessageSend accepting the CpNodeJSRestRequest instance).
	The operation's receiver is also the receiver for the authorization operation."

	| operationMethod selector|

	operationMethod := self operationMethod.

	"Check for a custom authorization handler (assumed to take single argument):
		<authorization: #customAuthChecker:>
	Use a default authorization handler for the other public and non-public endpoints."
	selector := (operationMethod pragmaAt: #authorization:)
		ifNotNil: [ :authorizationPragma | authorizationPragma argumentAt: 1 ]
		ifNil: [
			(operationMethod pragmaAt: #public)
				ifNotNil: [ #validatePublicAuthorizedRequest: ]
				ifNil: [ #validateAuthorizedRequest: ] ].

	^ MessageSend receiver: operation receiver selector: selector
]

{ #category : #testing }
CpNodeJSRestEndpointOperation >> canHandleRequest: aRestRequest [

	"Answer whether the receiver can handle the specified REST request.
	An EndpointOperation can handle a Request if the method and path are
	matching."

	^ method = aRestRequest method
		and: [ pathPattern matchesPath: aRestRequest path ]
]

{ #category : #performing }
CpNodeJSRestEndpointOperation >> handleRequest: aRestRequest response: aServerResponse [

	"Handle the specified REST request"

	"Store the path parameters in the request"
	aRestRequest setPathParameters: (pathPattern parametersFromPath: aRestRequest path).

	"Store the max body size (if a specific value is specified in the operation)"
	self maxBodySize ifNotNil: [ :maxBodySize |
		aRestRequest maxBodySize: maxBodySize ].

	"Check authorization"
	self validateAuthorizedRequest: aRestRequest.

	"Perform the operation"
	self performOperationRequest: aRestRequest response: aServerResponse
]

{ #category : #private }
CpNodeJSRestEndpointOperation >> identifier [

	"Answer an (internal) identifier for the receiver.

	Implementation:
	An identifier consisting of '<class><hash><selector>' is created."

	^ String streamContents: [ :stream |
		stream
			print: operation receiver class ;
			print: operation receiver identityHash ;
			print: operation selector ]
]

{ #category : #initialization }
CpNodeJSRestEndpointOperation >> initializeWithPath: aString method: aSymbol operation: aMessageSend [

	self initialize.

	pathPattern := CpNodeJSRestPathPattern fromString: aString.
	method := aSymbol.
	operation := aMessageSend
]

{ #category : #accessing }
CpNodeJSRestEndpointOperation >> maxBodySize [

	"Answer the max body size defined in the operation"

	^ (self operationMethod pragmaAt: #maxBodySize:)
		ifNotNil: [ :pragma | pragma argumentAt: 1 ]
]

{ #category : #accessing }
CpNodeJSRestEndpointOperation >> method [

	^ method
]

{ #category : #private }
CpNodeJSRestEndpointOperation >> operationMethod [

	"Answer the CompiledMethod of the operation"

	^ operation receiver class >> operation selector
]

{ #category : #accessing }
CpNodeJSRestEndpointOperation >> path [

	^ pathPattern asString
]

{ #category : #performing }
CpNodeJSRestEndpointOperation >> performOperationRequest: aRestRequest response: aServerResponse [

	"Perform the receiver's operation using the specified REST Request and Server Response"

	[ operation valueWithArguments: { aRestRequest . aServerResponse } ]
		on: Error
		do: [ :error | aServerResponse writeError: error]
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

{ #category : #testing }
CpNodeJSRestEndpointOperation >> validateAuthorizedRequest: aRestRequest [

	"Validate the specified REST Request is authorized to perform the operation"

	self authorizationOperation
		value: aRestRequest
]
