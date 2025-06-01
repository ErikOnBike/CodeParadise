Class {
	#name : #CynBaseRestApiService,
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
CynBaseRestApiService class >> defaultPort [

	"Answer the default port where the HTTP Server will run"

	^ 8181
]

{ #category : #testing }
CynBaseRestApiService class >> hasAbstractTag [

	"Answer whether the receiver has the 'isAbstract' tag set"

	^ self classSide includesSelector: #isAbstractTag
]

{ #category : #accessing }
CynBaseRestApiService class >> installInstanceMethod: aCompiledMethod [

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
CynBaseRestApiService class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #testing }
CynBaseRestApiService class >> isEndpointOperation: aCompiledMethod [

	"Only get, post put, patch and delete are supported at the moment"

	aCompiledMethod pragmas
		detect: [ :each | #(#get: #post: #put: #patch: #delete:) includes: each selector ] ifNone: [ ^ false ].

	^ true
]

{ #category : #'instance creation' }
CynBaseRestApiService class >> new [

	self errorNewReplacedBy: #startServer
]

{ #category : #accessing }
CynBaseRestApiService class >> operationFor: aCompiledMethod [

	"Answer a MessageSend (used in CpNodeJSRestEndpointOperation) for the receiver and the specified Compiled Method"

	| serviceImplementation action pragma url operation |

	serviceImplementation := self serviceImplementation.
	action := MessageSend receiver: serviceImplementation selector: aCompiledMethod selector.

	pragma := aCompiledMethod pragmas
		detect: [ :each | #(#get: #post: #put: #patch: #delete:) includes: each selector ] ifNone: [ ^ nil ].

	url := CpBrowserURL newUrl: pragma arguments first base: 'http://localhost'.

	pragma selector == #get:
		ifTrue: [ operation := CpNodeJSRestEndpointOperation uri: url getOperation: action ].
	pragma selector == #post:
		ifTrue: [ operation := CpNodeJSRestEndpointOperation uri: url postOperation: action ].
	pragma selector == #put:
		ifTrue: [ operation := CpNodeJSRestEndpointOperation uri: url putOperation: action ].
	pragma selector == #patch:
		ifTrue: [ operation := CpNodeJSRestEndpointOperation uri: url patchOperation: action ].
	pragma selector == #delete:
		ifTrue: [ operation := CpNodeJSRestEndpointOperation uri: url deleteOperation: action ].

	operation
		ifNotNil: [ ^ operation ].

	self error: 'Not implemented yet'
]

{ #category : #'class initialization' }
CynBaseRestApiService class >> postInstall [

	"Start the server once installed"

	super postInstall.

	self hasAbstractTag
		ifFalse: [ CpGlobalThis defer: [ self startServer ] ]
]

{ #category : #'class initialization' }
CynBaseRestApiService class >> postInstallOnce [

	CpNodeJSSnapshot registerSnapshotClass: self
]

{ #category : #'class initialization' }
CynBaseRestApiService class >> postSnapshotOnce [

	self traceCr: 'Starting server after snapshot'.

	self startServer
]

{ #category : #'class initialization' }
CynBaseRestApiService class >> preSnapshotOnce [

	self traceCr: 'Stopping server before snapshot'.

	self stopServer
]

{ #category : #running }
CynBaseRestApiService class >> registerService: aBoolean [

	"Register or unregister the endpoint operations based on the specified Boolean"
self traceCr: 'Register in ', self name.
	"First register the superclass"
	self == CynBaseRestApiService
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
CynBaseRestApiService class >> registerServiceClass: aClass [

	"Register the specified Class as main service"

	ServiceClass := aClass
]

{ #category : #accessing }
CynBaseRestApiService class >> removeInstanceMethod: aCompiledMethod [

	"If a method is removed unregister it (might not actually be registered, but just to be sure)"

	| operation |

	(self isEndpointOperation: aCompiledMethod)
		ifTrue: [ CpNodeJSRestEndpointOperation unregisterOperation: (operation := self operationFor: aCompiledMethod) ].

	super removeInstanceMethod: aCompiledMethod.

	operation ifNil: [ ^ self ].

	self traceCr: 'Removed endpoint operation: ', operation printString
]

{ #category : #accessing }
CynBaseRestApiService class >> serviceImplementation [

	"Answer the service implementation"

	^ Service
]

{ #category : #running }
CynBaseRestApiService class >> startServer [

	"Start the server and the service"

	| config |

	ServiceClass ifNil: [
		self == CynBaseRestApiService
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
CynBaseRestApiService class >> startServerOn: anInteger [

	"Start the HTTP Server for the REST service on the specified port"

	self stopServer.

	Server := CpNodeJSRestHttpServer newOnPort: anInteger
]

{ #category : #running }
CynBaseRestApiService class >> startService [

	"Register the endpoint operations"

	self traceCr: 'Registering endpoint operations:'.
	self registerService: true
]

{ #category : #running }
CynBaseRestApiService class >> stopServer [

	"Stop the previously started HTTP Server and service implementation"

	Service := nil.
	Server ifNil: [ ^ self ].

	Server stopServer.
	Server := nil
]

{ #category : #running }
CynBaseRestApiService class >> stopService [

	"Unregister the endpoint operations"

	self traceCr: 'Unregistering endpoint operations:'.
	self registerService: false
]

{ #category : #accessing }
CynBaseRestApiService >> crypto [

	^ crypto ifNil: [ crypto := CpNodeJSCrypto require ]
]

{ #category : #errors }
CynBaseRestApiService >> errorInconsistentInput [

	CpNodeJSRestBadRequestError signal: 'Inconsistent field values in REST request'
]

{ #category : #errors }
CynBaseRestApiService >> errorInvalidCollection [

	CpNodeJSRestBadRequestError signal: 'Invalid format of collection in REST request'
]

{ #category : #errors }
CynBaseRestApiService >> errorInvalidIdCollection [

	CpNodeJSRestBadRequestError signal: 'Invalid format of id in collection in REST request'
]

{ #category : #errors }
CynBaseRestApiService >> errorInvalidInput [

	CpNodeJSRestBadRequestError signal: 'Invalid field values in REST request'
]

{ #category : #errors }
CynBaseRestApiService >> errorInvalidObject [

	CpNodeJSRestBadRequestError signal: 'Invalid format of object in REST request'
]

{ #category : #errors }
CynBaseRestApiService >> errorMissingHeader: aString [

	CpNodeJSRestBadRequestError signal: 'Missing header in REST request: ', aString
]

{ #category : #errors }
CynBaseRestApiService >> errorMissingInput: aString [

	CpNodeJSRestBadRequestError signal: 'Missing field in REST request: ', aString
]

{ #category : #errors }
CynBaseRestApiService >> errorNoBody [

	CpNodeJSRestBadRequestError signal: 'No body present in REST request'
]

{ #category : #errors }
CynBaseRestApiService >> errorUnauthorized [

	CpNodeJSRestForbiddenError signal: 'Unauthorized operation in REST request'
]

{ #category : #errors }
CynBaseRestApiService >> errorUnexpectedInput: aString [

	CpNodeJSRestBadRequestError signal: 'Unexpected field in REST request: ', aString
]

{ #category : #'API - support' }
CynBaseRestApiService >> extractIdsFromBody: aCollection [

	| idConstraint |

	"Validate we received a Collection"
	aCollection isCollection
		ifFalse: [ self errorInvalidCollection ].

	"Validate only ids are present"
	idConstraint := CynIdPropertyConstraint default.
	(aCollection allSatisfy: [ : each | idConstraint isValidValue: each ])
		ifFalse: [ self errorInvalidIdCollection ].

	^ aCollection
]

{ #category : #'API - support' }
CynBaseRestApiService >> extractNewObject: aClass fromBody: aDictionary [

	| instance |

	instance := self extractObject: aClass fromBody: aDictionary.

	"Validate the object is in fact new"
	instance isNew
		ifFalse: [ self errorUnexpectedInput: #id ].

	^ instance
]

{ #category : #'API - support' }
CynBaseRestApiService >> extractObject: aClass fromBody: aDictionary [

	| instance |

	"Validate we received a Dictionary"
	aDictionary isDictionary
		ifFalse: [ self errorInvalidObject ].

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
CynBaseRestApiService >> initialize [

	super initialize.

	modelDatabase := CynDatabase on: 'data/database.db'.
	logDatabase := CynDatabase on: 'data/log.db'
]

{ #category : #initialization }
CynBaseRestApiService >> initializeWithConfig: aDictionary [

	config := aDictionary.

	self initialize
]

{ #category : #'API - resources' }
CynBaseRestApiService >> newId [

	"Answer a new random ID (for a row)"

	^ self crypto randomUUID
]

{ #category : #'API - resources' }
CynBaseRestApiService >> newToken [

	"Answer a new random token value"

	^ (self crypto randomBytes: 16) toStringEncoding: 'hex'
]

{ #category : #API }
CynBaseRestApiService >> ping: aRestRequest response: aServerResponse [

	"Ping to check on liveness"

	<get: '/api/ping/hello'>
	<public>

	"Pong the message back to the requestor"
	self send: 'world' response: aServerResponse
]

{ #category : #sending }
CynBaseRestApiService >> send: anObject response: aServerResponse [

	"Send the specified Object (typically a Dictionary) as a response"

	aServerResponse
		statusCode: CpNodeJSRestHttpServer statusOK ;
		setHeaderWithName: 'Content-Type' value: 'application/json; charset=utf-8' ;
		writeChunk: (CpJavaScriptJSON stringify: anObject asJsonObjectValue) ;
		end
]

{ #category : #sending }
CynBaseRestApiService >> sendEmptyResponse: aServerResponse [

	self send: Dictionary new response: aServerResponse
]

{ #category : #'API - private' }
CynBaseRestApiService >> snapshot: aRestRequest response: aServerResponse [

	<get: '/snapshot'>
	<public>

	self sendEmptyResponse: aServerResponse.

	Smalltalk at: #Sealed ifAbsent: [
		Smalltalk at: #Sealed put: true.

		CpGlobalThis setTimeout: 1000 thenDo: [
			self traceCr: 'About to save..'.
			CpNodeJSSnapshot saveSnapshot.
			
			self traceCr: 'After save' ] ]
]

{ #category : #'API - resources' }
CynBaseRestApiService >> timestampNow [

	"Answer the current timestamp as seconds since Unix epoch (midnight Jan 1, 1970, UTC)"

	^ CpNodeJSRestHttpServer timestampNow
]

{ #category : #'API - authorization' }
CynBaseRestApiService >> validatePublicAuthorizedRequest: aRestRequest [

	"Default authorization handler for public data"
]
