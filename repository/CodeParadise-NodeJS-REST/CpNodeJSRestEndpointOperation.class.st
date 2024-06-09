Class {
	#name : #CpNodeJSRestEndpointOperation,
	#superclass : #Object,
	#instVars : [
		'method',
		'pathPattern',
		'requiredParams',
		'operation'
	],
	#classVars : [
		'Operations'
	],
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> fromCompiledMethod: aCompiledMethod [

	"Answer an instance of the receiver based on the specified CompiledMethod.
	The instance is validated for being a correct EndpointOperation."

	^ self basicNew
		initializeWithCompiledMethod: aCompiledMethod ;
		validate ;
		yourself
]

{ #category : #'event handling' }
CpNodeJSRestEndpointOperation class >> handleRequest: aRestRequest response: aServerResponse [

	"Handle the specified message and answer true if handled"

	Operations ifNil: [ ^ false ].

	"Try each EndPointOperation until one succeeds in handling request"
	Operations valuesDo: [ :each |
		(each handleRequest: aRestRequest response: aServerResponse)
			ifTrue: [ ^ true ] ].

	"Not handled, means it was a bad request or resource not found"
	aRestRequest method = 'GET'
		ifTrue: [
			aServerResponse
				writeChunk: 'Resource not found' ;
				statusCode: CpNodeJSRestNotFoundError ;
				end ]
		ifFalse: [
			aServerResponse
				writeChunk: 'Request did not match any of the known API endpoint operations' ;
				statusCode: CpNodeJSRestBadRequestError ;
				end ].

	^ false
]

{ #category : #adding }
CpNodeJSRestEndpointOperation class >> registerOperation: anEndPointOperation [

	Operations ifNil: [ Operations := Dictionary new ].

	Operations at: anEndPointOperation identifier put: anEndPointOperation.

	^ anEndPointOperation
]

{ #category : #adding }
CpNodeJSRestEndpointOperation class >> unregisterOperation: anEndPointOperation [

	Operations ifNil: [ ^ anEndPointOperation ].

	Operations removeKey: anEndPointOperation identifier.

	^ anEndPointOperation
]

{ #category : #'instance creation' }
CpNodeJSRestEndpointOperation class >> unsafeFromCompiledMethod: aCompiledMethod [

	"Answer an instance of the receiver based on the specified CompiledMethod.
	The instance might not be a valid EndpointOperation."

	^ self basicNew
		initializeWithCompiledMethod: aCompiledMethod ;
		yourself
]

{ #category : #performing }
CpNodeJSRestEndpointOperation >> handleRequest: aRestRequest response: aServerResponse [

	"Handle the specified REST request and answer true if handled"

	| parameters |

	method = aRestRequest method
		ifFalse: [ ^ false ].

	(pathPattern matchesPath: aRestRequest path)
		ifFalse: [ ^ false ].

	"Collect parameters"
	parameters := Array new: requiredParams size.
	requiredParams keysAndValuesDo: [ :index :parameter |
		parameters at: index put: (parameter valueFromRequest: aRestRequest forEndpointOperation: self) ].

	"Perform the operation (which is a class method)"
	self performOperationWithParameters: parameters response: aServerResponse.

	^ true
]

{ #category : #accessing }
CpNodeJSRestEndpointOperation >> identifier [

	"Answer an (internal) identifier for the receiver.

	Implementation:
	The operation (i.e. CompiledMethod)'s printString is used,
	because it delivers a unique representation."

	^ operation printString
]

{ #category : #initialization }
CpNodeJSRestEndpointOperation >> initialize [

	super initialize.

	requiredParams := IdentityDictionary new
]

{ #category : #initialization }
CpNodeJSRestEndpointOperation >> initializeWithCompiledMethod: aCompiledMethod [

	| pragmaHandlers |

	self initialize.

	pragmaHandlers := Dictionary new
		at: #restMethod:path: put: [ :pragma |
			method := pragma arguments first.
			pathPattern := CpNodeJSRestPathPattern fromString: pragma arguments second ] ;
		at: #restParam:from: put: [ :pragma |
			requiredParams
				at: pragma arguments first
				ifPresent: [ self error: 'REST endpoint param ', pragma arguments first printString, ' defined multiple times' ]
				ifAbsentPut: [ CpNodeJSRestParameter fromLocation: pragma arguments second ] ] ;
		at: #restParam:from:at: put: [ :pragma |
			requiredParams
				at: pragma arguments first
				ifPresent: [ self error: 'REST endpoint param ', pragma arguments first printString, ' defined multiple times' ]
				ifAbsentPut: [ CpNodeJSRestParameter fromLocation: pragma arguments second at: pragma arguments third ] ] ;
		yourself.

	"Handle all pragmas to fill my instance variables"
	aCompiledMethod pragmas do: [ :each |
		pragmaHandlers at: each keyword ifPresent: [ :handler |
			handler value: each ] ].

	"The operation is our CompiledMethod (which is a class side method, don't need explicit receiver)"
	operation := aCompiledMethod
]

{ #category : #testing }
CpNodeJSRestEndpointOperation >> isValid [

	"Answer whether the receiver is a valid endpoint.

	Implementation:
	Assume the receiver is initialized on a CompiledMethod.
	In this case the validate method has been executed.
	IF method is nil it means the receiver is completely
	'empty' and therefore is not valid."

	^ method isNotNil
]

{ #category : #accessing }
CpNodeJSRestEndpointOperation >> pathParameterFrom: aPath at: aSymbol [

	^ pathPattern parameterNamed: aSymbol fromPath: aPath
]

{ #category : #performing }
CpNodeJSRestEndpointOperation >> performOperationWithParameters: anArray response: aServerResponse [

	"Perform the receiver's operation with the specified parameters
	and write the response.

	Implementation:
	Since parameters can reference the request body which is retrieved
	using event mechanism, first retrieve this information.
	Invoke the operation once all parameters are ready."

	| operationClass operationSelector |

	operationClass := operation methodClass instanceSide.
	operationSelector := operation selector.

	self resolveParametersIn: anArray thenDo: [
		| arguments response |
		arguments := anArray collect: [ :each | each value ].
		response := [
			operationClass perform: operationSelector withArguments: arguments
		] on: Error do: [ :error | error ].
		self writeResponse: response to: aServerResponse ]
]

{ #category : #performing }
CpNodeJSRestEndpointOperation >> resolveParametersIn: anArray thenDo: aBlock [

	"Resolve all parameters in the specified parameter collection
	and perform the specified block when done"

	self resolveParametersStartingAt: 1 in: anArray thenDo: aBlock
]

{ #category : #performing }
CpNodeJSRestEndpointOperation >> resolveParametersStartingAt: anInteger in: anArray thenDo: aBlock [

	"Resolve the specified parameter in the specified parameter collection
	and continu to next, perform the specified block when fully done"

	anInteger <= anArray size
		ifTrue: [
			(anArray at: anInteger)
				resolveThenDo: [ self resolveParametersStartingAt: anInteger + 1 in: anArray thenDo: aBlock ] ]
		ifFalse: [ aBlock value ]
]

{ #category : #validating }
CpNodeJSRestEndpointOperation >> validate [

	"Validate the receiver is a complete and correct instance OR completely 'empty'"

	"Check for the 'empty' case"
	method ifNil: [
		self validateEmpty.
		^ self ].

	(pathPattern isNil or: [ pathPattern isEmpty ])
		ifNil: [ self error: 'REST endpoint definition is missing a path pattern' ].
	CpNodeJSRestPathPattern validatePath: pathPattern asString.

	"Check for presence of all required parameters"
	requiredParams size = operation numArgs
		ifFalse: [ self error: 'REST endpoint definition does not have the correct number of parameters defined, expected ', operation numArgs printString, ' received ', requiredParams size printString ].
	1 to: requiredParams size do: [ :parameterIndex |
		requiredParams at: parameterIndex ifAbsent: [ self error: 'REST endpoint definition is missing a definition for parameter ', parameterIndex printString ] ].

	"Check if path parameters exist (only one we know right now, others are in message)"
	requiredParams valuesDo: [ :each |
		(each isPathParameter and: [ (pathPattern hasParameterNamed: each key) not ])
			ifTrue: [ self error: 'REST endpoint definition refers to path parameter ', each key, ' which does not exist' ] ]
]

{ #category : #validating }
CpNodeJSRestEndpointOperation >> validateEmpty [

	"Validate the receiver is completely 'empty'"

	(method isNil and: [ pathPattern isNil and: [ requiredParams isEmpty ] ])
		ifFalse: [ self error: 'REST endpoint definition is partly given, elements are missing' ]
]

{ #category : #performing }
CpNodeJSRestEndpointOperation >> writeResponse: anObject to: aServerResponse [

	aServerResponse
		writeChunk: anObject printString ;
		statusCode: CpNodeJSRestHttpServer statusOK ;
		end
]
