Class {
	#name : #CpCanyonBaseRestApiService,
	#superclass : #Object,
	#instVars : [
		'config',
		'modelDatabase',
		'logDatabase',
		'crypto'
	],
	#classVars : [
		'Server',
		'Service',
		'ServiceClass'
	],
	#category : #'CodeParadise-Canyon-Data-Service'
}

{ #category : #accessing }
CpCanyonBaseRestApiService class >> defaultPort [

	"Answer the default port where the HTTP Server will run"

	^ 8181
]

{ #category : #accessing }
CpCanyonBaseRestApiService class >> installInstanceMethod: aCompiledMethod [

	"If a method is installed, marked as endpoint operation, register it"

	| operation |

	"First unregister (any possible) existing operation"
	(self methodDictionary at: aCompiledMethod selector ifAbsent: [ nil ])
		ifNotNil: [ :prevMethod |
			(self isEndpointOperation: prevMethod)
				ifTrue: [
					"Operation created below is same for old and new method"
					operation := self operationFor: aCompiledMethod.
					CpNodeJSRestEndpointOperation unregisterOperation: operation ] ].

	super installInstanceMethod: aCompiledMethod.

	"If new method is not an endpoint operation, we're done"
	(self isEndpointOperation: aCompiledMethod)
		ifFalse: [ ^ self ].

	"Register operation, use previously created operation or create new one"
	operation ifNil: [ operation := self operationFor: aCompiledMethod ].
	CpNodeJSRestEndpointOperation registerOperation: operation.

	self traceCr: 'Updated endpoint operation: ', operation printString
]

{ #category : #testing }
CpCanyonBaseRestApiService class >> isEndpointOperation: aCompiledMethod [

	"Only get, post put and delete are supported at the moment.

	Patch is not supported, but might be added in the future."

	aCompiledMethod pragmas
		detect: [ :each | #(#get: #post: #put: #delete:) includes: each selector ] ifNone: [ ^ false ].

	^ true
]

{ #category : #'instance creation' }
CpCanyonBaseRestApiService class >> new [

	self errorNewReplacedBy: #startServer
]

{ #category : #accessing }
CpCanyonBaseRestApiService class >> operationFor: aCompiledMethod [

	"Answer a MessageSend (used in CpNodeJSRestEndpointOperation) for the receiver and the specified Compiled Method"

	| serviceImplementation action pragma url operation |

	serviceImplementation := self serviceImplementation.
	action := MessageSend receiver: serviceImplementation selector: aCompiledMethod selector.

	pragma := aCompiledMethod pragmas
		detect: [ :each | #(#get: #post: #put: #delete:) includes: each selector ] ifNone: [ ^ nil ].

	url := CpBrowserURL newUrl: pragma arguments first base: 'http://localhost'.

	pragma selector == #get:
		ifTrue: [ operation := CpNodeJSRestEndpointOperation uri: url getOperation: action ].
	pragma selector == #post:
		ifTrue: [ operation := CpNodeJSRestEndpointOperation uri: url postOperation: action ].
	pragma selector == #put:
		ifTrue: [ operation := CpNodeJSRestEndpointOperation uri: url putOperation: action ].
	pragma selector == #delete:
		ifTrue: [ operation := CpNodeJSRestEndpointOperation uri: url deleteOperation: action ].

	operation
		ifNotNil: [ ^ operation ].

	self error: 'Not implemented yet'
]

{ #category : #'class initialization' }
CpCanyonBaseRestApiService class >> postSnapshotOnce [

	self startServer
]

{ #category : #'class initialization' }
CpCanyonBaseRestApiService class >> preSnapshotOnce [

	self stopServer
]

{ #category : #running }
CpCanyonBaseRestApiService class >> registerService: aBoolean [

	"Register or unregister the endpoint operations based on the specified Boolean"
self traceCr: 'Register in ', self name.
	"First register the superclass"
	self == CpCanyonBaseRestApiService
		ifFalse: [ self superclass registerService: aBoolean ].

	self methodDictionary do: [ :each |
		(self isEndpointOperation: each)
			ifTrue: [
				| operation |

				operation := self operationFor: each.
				aBoolean
					ifTrue: [ CpNodeJSRestEndpointOperation registerOperation: operation ]
					ifFalse: [ CpNodeJSRestEndpointOperation unregisterOperation: operation ].
				self traceCr: 'Handled endpoint operation: ', operation printString ] ]
]

{ #category : #accessing }
CpCanyonBaseRestApiService class >> registerServiceClass: aClass [

	"Register the specified Class as main service and for snapshot"

	ServiceClass := aClass.

	CpNodeJSSnapshot registerSnapshotClass: aClass
]

{ #category : #accessing }
CpCanyonBaseRestApiService class >> removeInstanceMethod: aCompiledMethod [

	"If a method is removed unregister it (might not actually be registered, but just to be sure)"

	| operation |

	(self isEndpointOperation: aCompiledMethod)
		ifTrue: [ CpNodeJSRestEndpointOperation unregisterOperation: (operation := self operationFor: aCompiledMethod) ].

	super removeInstanceMethod: aCompiledMethod.

	operation ifNil: [ ^ self ].

	self traceCr: 'Removed endpoint operation: ', operation printString
]

{ #category : #accessing }
CpCanyonBaseRestApiService class >> serviceImplementation [

	"Answer the service implementation"

	^ Service
]

{ #category : #running }
CpCanyonBaseRestApiService class >> startServer [

	"Start the server and the service"

	| config |

	ServiceClass ifNil: [
		self == CpCanyonBaseRestApiService
			ifTrue: [ self error: 'Called #startServer without setting ServiceClass explicitly' ].
		ServiceClass := self ].

	config := CpJavaScriptJSON parse: (CpNodeJSFS require readFileSync: 'server-config.json' options: 'utf-8').

	"Start the server"
	self startServerOn: (config at: #port ifAbsent: [ self defaultPort ]).

	"Start the service implementation"
	Service := ServiceClass basicNew
		initializeWithConfig: config ;
		yourself.

	"Register the service operations"
	ServiceClass startService
]

{ #category : #running }
CpCanyonBaseRestApiService class >> startServerOn: anInteger [

	"Start the HTTP Server for the REST service on the specified port"

	self stopServer.

	Server := CpNodeJSRestHttpServer newOnPort: anInteger
]

{ #category : #running }
CpCanyonBaseRestApiService class >> startService [

	"Register the endpoint operations"

	self traceCr: 'Registering endpoint operations:'.
	self registerService: true
]

{ #category : #running }
CpCanyonBaseRestApiService class >> stopServer [

	"Stop the previously started HTTP Server and service implementation"

	Service := nil.
	Server ifNil: [ ^ self ].

	Server stopServer.
	Server := nil
]

{ #category : #running }
CpCanyonBaseRestApiService class >> stopService [

	"Unregister the endpoint operations"

	self traceCr: 'Unregistering endpoint operations:'.
	self registerService: false
]

{ #category : #accessing }
CpCanyonBaseRestApiService >> crypto [

	^ crypto ifNil: [ crypto := CpNodeJSCrypto require ]
]

{ #category : #errors }
CpCanyonBaseRestApiService >> errorInconsistentInput [

	CpNodeJSRestBadRequestError signal: 'Inconsistent field values in REST request'
]

{ #category : #errors }
CpCanyonBaseRestApiService >> errorInvalidInput [

	CpNodeJSRestBadRequestError signal: 'Invalid field values in REST request'
]

{ #category : #errors }
CpCanyonBaseRestApiService >> errorMissingHeader: aString [

	CpNodeJSRestBadRequestError signal: 'Missing header in REST request: ', aString
]

{ #category : #errors }
CpCanyonBaseRestApiService >> errorMissingInput: aString [

	CpNodeJSRestBadRequestError signal: 'Missing field in REST request: ', aString
]

{ #category : #errors }
CpCanyonBaseRestApiService >> errorNoBody [

	CpNodeJSRestBadRequestError signal: 'No body present in REST request'
]

{ #category : #errors }
CpCanyonBaseRestApiService >> errorUnexpectedInput: aString [

	CpNodeJSRestBadRequestError signal: 'Unexpected field in REST request: ', aString
]

{ #category : #'API - support' }
CpCanyonBaseRestApiService >> extractNewObject: aClass fromBody: aDictionary [

	| instance |

	instance := self extractObject: aClass fromBody: aDictionary.

	"Validate the object is in fact new"
	instance isNew
		ifFalse: [ self errorUnexpectedInput: #id ].

	^ instance
]

{ #category : #'API - support' }
CpCanyonBaseRestApiService >> extractObject: aClass fromBody: aDictionary [

	| instance |

	"Validate only defined properties are present"
	aDictionary keysDo: [ :each |
		(aClass hasPropertyNamed: each)
			ifFalse: [ self errorUnexpectedInput: each ] ].

	"Create instance"
	instance := aClass fromDictionary: aDictionary.

	"Validate the instance is consistent and valid"
	instance isValid
		ifFalse: [ self errorInvalidInput ].

	^ instance
]

{ #category : #initialization }
CpCanyonBaseRestApiService >> initialize [

	super initialize.

	modelDatabase := CpDatabase on: 'data/database.db'.
	logDatabase := CpDatabase on: 'data/log.db'
]

{ #category : #initialization }
CpCanyonBaseRestApiService >> initializeWithConfig: aDictionary [

	config := aDictionary.

	self initialize
]

{ #category : #'API - resources' }
CpCanyonBaseRestApiService >> newId [

	"Answer a new random ID (for a row)"

	^ self crypto randomUUID
]

{ #category : #'API - resources' }
CpCanyonBaseRestApiService >> newToken [

	"Answer a new random token value"

	^ (self crypto randomBytes: 16) toStringEncoding: 'hex'
]

{ #category : #API }
CpCanyonBaseRestApiService >> ping: aRestRequest response: aServerResponse [

	"Ping to check on liveness"

	<get: '/api/ping/hello'>
	<public>

	"Pong the message back to the requestor"
	self send: 'world' response: aServerResponse
]

{ #category : #sending }
CpCanyonBaseRestApiService >> send: anObject response: aServerResponse [

	"Send the specified Object (typically a Dictionary) as a response"

	aServerResponse
		statusCode: CpNodeJSRestHttpServer statusOK ;
		setHeaderWithName: 'Content-Type' value: 'application/json; charset=utf-8' ;
		writeChunk: (CpJavaScriptJSON stringify: anObject asJsonObjectValue) ;
		end
]

{ #category : #sending }
CpCanyonBaseRestApiService >> sendEmptyResponse: aServerResponse [

	self send: Dictionary new response: aServerResponse
]

{ #category : #'API - private' }
CpCanyonBaseRestApiService >> snapshot: aRestRequest response: aServerResponse [

	<get: '/snapshot'>
	<public>

	self traceCr: 'Here?!!!!'.
		Smalltalk at: #Sealed ifAbsent: [
			Smalltalk at: #Sealed put: true.
			self traceCr: 'About to save..'.
			CpNodeJSSnapshot saveSnapshot.
			self traceCr: 'After save?' ].
	self traceCr: 'Sealed?'
]

{ #category : #'API - resources' }
CpCanyonBaseRestApiService >> timestampNow [

	"Answer the current timestamp as seconds since Unix epoch (midnight Jan 1, 1970, UTC)"

	^ CpNodeJSRestHttpServer timestampNow
]

{ #category : #'API - authorization' }
CpCanyonBaseRestApiService >> validatePublicAuthorizedRequest: aRestRequest [

	"Default authorization handler for public data"
]
