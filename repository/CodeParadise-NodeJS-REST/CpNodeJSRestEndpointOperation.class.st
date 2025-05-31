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
		'operation',
		'queryParameters'
	],
	#classVars : [
		'Operations'
	],
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #request }
CpNodeJSRestEndpointOperation class >> matchingRequest: aRequest [

	"Handle the REST Request in the specified RequestProcess or notify it is unhandled.

	Implementation:
	The most accurate matching operation is selected to handle the request. The operation's path is
	checked to decide which is most accurate. Fixed path segments are more accurate than parameters,
	therefore sort on number of parameters while matching.

	Some examples:
		'/account/current' is more accurate than '/account:id'
		'/products/:id/photos/latest' is more accurate than '/products/:productId/photos/:photoId'
		but '/products/current/photos/:id' equals '/products/:id/photos/latest' (i.e. undefined which will be selected)"

	| matches |

	Operations ifNil: [ ^ nil ].

	"Find matching operations"
	matches := SortedCollection sortBlock: [ :a :b | a isMoreSpecificThan: b ].
	Operations valuesDo: [ :operation |
		(operation canHandleRequest: aRequest)
			ifTrue: [ matches add: operation ] ].

	"Select most specific operation (first one because of sorting)"
	^ matches
		ifNotEmpty: [ matches first ]
		ifEmpty: [ nil ]
]

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> method: aSymbol path: aString queryParams: aSearchParams operation: aMessageSend [

	^ self basicNew
		initializeWithMethod: aSymbol path: aString queryParams: aSearchParams operation: aMessageSend ;
		yourself
]

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> new [

	self errorNewReplacedBy: #method:path:queryParams:operation:
]

{ #category : #'class initialization' }
CpNodeJSRestEndpointOperation class >> postInstallOnce [

	CpNodeJSSnapshot registerSnapshotClass: self
]

{ #category : #'class initialization' }
CpNodeJSRestEndpointOperation class >> preSnapshotOnce [

	Operations := nil
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

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> uri: aUrl deleteOperation: aMessageSend [

	^ self
		method: #DELETE
		path: aUrl pathname
		queryParams: aUrl searchParams
		operation: aMessageSend
]

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> uri: aUrl getOperation: aMessageSend [

	^ self
		method: #GET
		path: aUrl pathname
		queryParams: aUrl searchParams
		operation: aMessageSend
]

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> uri: aUrl patchOperation: aMessageSend [

	^ self
		method: #PATCH
		path: aUrl pathname
		queryParams: aUrl searchParams
		operation: aMessageSend
]

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> uri: aUrl postOperation: aMessageSend [

	^ self
		method: #POST
		path: aUrl pathname
		queryParams: aUrl searchParams
		operation: aMessageSend
]

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> uri: aUrl putOperation: aMessageSend [

	^ self
		method: #PUT
		path: aUrl pathname
		queryParams: aUrl searchParams
		operation: aMessageSend
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
		and: [ (pathPattern matchesPath: aRestRequest path)
			and: [ self queryParametersMatch: aRestRequest queryParameters ] ]
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
CpNodeJSRestEndpointOperation >> initializeWithMethod: aSymbol path: aString queryParams: aSearchParams operation: aMessageSend [

	self initialize.

	method := aSymbol.
	pathPattern := CpNodeJSRestPathPattern fromString: aString.
	queryParameters := aSearchParams asDictionary.	"Store as Dictionary for familiar access"
	operation := aMessageSend
]

{ #category : #testing }
CpNodeJSRestEndpointOperation >> isMoreSpecificThan: anEndpointOperation [

	"Answer whether the receiver is more specific than the specified EndpointOperation.
	It is assumed both are already matched against a path and query parameters.
	If the number of path parameters (i.e. non-fixed path segments) differs, the operation
	with the lowest path parameters is more specific and wins.
	If the number of query parameters are equal, the higher number of query parameters
	is more specific and wins."

	| receiverPathParameterCount comparePathParameterCount |

	receiverPathParameterCount := self pathParameterCount.
	comparePathParameterCount := anEndpointOperation pathParameterCount.

	"Less dynamic path parameters (i.e. more fixed path parameters) wins"
	receiverPathParameterCount < comparePathParameterCount
		ifTrue: [ ^ true ].

	"More query parameters wins (when parameter counts are equal)"
	(receiverPathParameterCount = comparePathParameterCount and: [ self queryParameterCount > anEndpointOperation queryParameterCount ])
		ifTrue: [ ^ true ].

	^ false
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

	^ operation receiver class lookupSelector: operation selector
]

{ #category : #accessing }
CpNodeJSRestEndpointOperation >> path [

	^ pathPattern asString
]

{ #category : #accessing }
CpNodeJSRestEndpointOperation >> pathParameterCount [

	"Answer the number of parameters in the receiver's path"

	^ pathPattern parameterCount
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

{ #category : #accessing }
CpNodeJSRestEndpointOperation >> queryParameterCount [

	^ queryParameters size
]

{ #category : #testing }
CpNodeJSRestEndpointOperation >> queryParametersMatch: aDictionary [

	"Validate all required query parameters are present"

	queryParameters keysAndValuesDo: [ :key :value |
		| actualValue |

		"Check if parameter is present"
		actualValue := aDictionary at: key ifAbsent: [ ^ false ].

		"Check if parameter value is equal in case of non-dynamic parameter
		(dynamic parameters start with a colon)"
		((value beginsWith: ':') or: [ value = actualValue ])
			ifFalse: [ ^ false ] ].

	^ true
]

{ #category : #accessing }
CpNodeJSRestEndpointOperation >> timeout [

	"Answer the timeout defined in the operation (as milliseconds)"

	^ (self operationMethod pragmaAt: #timeout:)
		ifNotNil: [ :pragma | pragma argumentAt: 1 ]
]

{ #category : #testing }
CpNodeJSRestEndpointOperation >> validateAuthorizedRequest: aRestRequest [

	"Validate the specified REST Request is authorized to perform the operation"

	self authorizationOperation
		value: aRestRequest
]
