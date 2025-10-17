Class {
	#name : #CynBaseRestApiService,
	#superclass : #Object,
	#instVars : [
		'config',
		'modelDatabase',
		'logDatabase',
		'crypto',
		'mailer',
		'configWatcher',
		'configUpdater',
		'version'
	],
	#classVars : [
		'Server',
		'Service',
		'ServiceClass'
	],
	#category : #'CodeParadise-Canyon-Data-Service'
}

{ #category : #accessing }
CynBaseRestApiService class >> configFile [

	^ 'server-config.json'
]

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
			(self serviceImplementation isEndpointOperation: prevMethod)
				ifTrue: [
					"Operation created below is same for old and new method"
					operation := self serviceImplementation operationFor: aCompiledMethod.
					CpNodeJSRestEndpointOperation unregisterOperation: operation ] ].

	super installInstanceMethod: aCompiledMethod.

	"If new method is not an endpoint operation, we're done"
	(self serviceImplementation isEndpointOperation: aCompiledMethod)
		ifFalse: [ ^ self ].

	"Register operation, use previously created operation or create new one"
	operation ifNil: [ operation := self serviceImplementation operationFor: aCompiledMethod ].
	CpNodeJSRestEndpointOperation registerOperation: operation.

	self traceCr: 'Updated endpoint operation: ', operation printString
]

{ #category : #testing }
CynBaseRestApiService class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #'instance creation' }
CynBaseRestApiService class >> new [

	self errorNewReplacedBy: #startServer
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

	"First register the superclass"
	self == CynBaseRestApiService
		ifFalse: [ self superclass registerService: aBoolean ].

	self methodDictionary do: [ :each |
		(self serviceImplementation isEndpointOperation: each)
			ifTrue: [
				| operation |

				operation := self serviceImplementation operationFor: each.
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

	(self serviceImplementation isEndpointOperation: aCompiledMethod)
		ifTrue: [ CpNodeJSRestEndpointOperation unregisterOperation: (operation := self serviceImplementation operationFor: aCompiledMethod) ].

	super removeInstanceMethod: aCompiledMethod.

	operation ifNil: [ ^ self ].

	self traceCr: 'Removed endpoint operation: ', operation printString
]

{ #category : #accessing }
CynBaseRestApiService class >> restEndpointOperationClass [

	^ CynRestEndpointOperation
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

	config := CpJavaScriptJSON parse: (CpNodeJSFS require readFileSync: self configFile options: 'utf-8').

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

	Service ifNotNil: [
		Service release.
		Service := nil ].

	Server ifNotNil: [
		Server stopServer.
		Server := nil ]
]

{ #category : #running }
CynBaseRestApiService class >> stopService [

	"Unregister the endpoint operations"

	self traceCr: 'Unregistering endpoint operations:'.
	self registerService: false
]

{ #category : #logging }
CynBaseRestApiService >> bodyFromRequest: aRestRequest [

	"Convenience method to retrieve the body from the specified request.
	It tries to read the JSON and remove protected fields.
	This method should under no circumstance fail."

	^ [
		| body content |
		body := aRestRequest body.
		content := [
			| object |
			"Remove the password field content if present"
			object := CpJavaScriptJSON parse: body toString.
			object at: #password ifPresent: [ object at: #password put: '***' ].
			CpJavaScriptJSON stringify: object
		] on: Error do: [
			body length < 4000
				ifTrue: [ body toString ]
				ifFalse: [ '<large binary object>' ] ]
	] on: Error do: [ :error | '<unable to retrieve body content>' ]
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
	logDatabase := CynDatabase on: 'data/log.db'.

	self initializeMailer
]

{ #category : #initialization }
CynBaseRestApiService >> initializeMailer [

	mailer ifNotNil: [
		mailer close.
		mailer := nil ].

	"Configure the mailer"
	config at: #mailer ifPresent: [ :mailerConfig |

		"If mailer is preent, 'mailer-default' and 'mailer-dsn' are assumed to be present too"
		mailer := CpNodeJSNodemailerTransporter createTransport: mailerConfig withDefaults: (config at: #'mailer-defaults').
		mailer verify: [ :error :success |
			error ifNotNil: [ self errorCr: ('Startup error mailer: {1}' format: { error }) ].
			success ifNotNil: [ self traceCr: ('Startup mailer successful: {1}' format: { success }) ] ] ]
]

{ #category : #initialization }
CynBaseRestApiService >> initializeWithConfig: aDictionary [

	config := aDictionary.

	self initialize.

	(config at: #watch ifAbsent: [ false ])
		ifTrue: [ self watchConfig ]
		ifFalse: [ self stopWatchConfig ]
]

{ #category : #logging }
CynBaseRestApiService >> insertErrorLogStatement [

	"Answer the insert statement.
	This statement should match the record created in #logRecordFromError:request:
	(except for timestamp, level and message which are always added)."

	^ 'INSERT INTO logs (timestamp, level, message, statusCode, stack, request, body) VALUES (:timestamp, :level, :message, :statusCode, :stack, :request, :body)'
]

{ #category : #logging }
CynBaseRestApiService >> insertLogStatement [

	"Answer the insert statement.
	This statement should match the record created in #logRecordFromRequest:
	(except for timestamp, level and message which are always added)."

	^ 'INSERT INTO logs (timestamp, level, message, statusCode) VALUES (:timestamp, :level, :message, 0)'
]

{ #category : #'API - support' }
CynBaseRestApiService >> isEndpointOperation: aCompiledMethod [

	"Only get, post put, patch and delete are supported at the moment"

	aCompiledMethod pragmas
		detect: [ :each | #(#get: #post: #put: #patch: #delete:) includes: each selector ] ifNone: [ ^ false ].

	^ true
]

{ #category : #logging }
CynBaseRestApiService >> log: aSymbol message: aString request: aRestRequest [

	"Log the specified message with the given log level.
	Answer the rowId of the added log row."

	| logRecord |

	[
		logRecord := self logRecordFromRequest: aRestRequest.

		"Add fixed/required log record entries"
		logRecord
			at: #timestamp put: CpJavaScriptDate timestampNow ;
			at: #level put: aSymbol ;
			at: #message put: aString.

		^ logDatabase
			performOne: #insertLogRecord
			statement: self insertLogStatement
			bind: logRecord
	] on: Error do: [ :error |
		self warnCr: 'Failed to write log record: ', error printString.
		^ nil ]
]

{ #category : #logging }
CynBaseRestApiService >> logError: anError [

	^ self logError: anError request: nil
]

{ #category : #logging }
CynBaseRestApiService >> logError: anError request: aRestRequest [

	"Log the specified Error for the specified REST request.
	Answer the rowId of the added log row."

	| logRecord |

	[
		logRecord := self logRecordFromError: anError request: aRestRequest.

		"Add fixed/required log record entries"
		logRecord
			at: #timestamp put: CpJavaScriptDate timestampNow ;
			at: #level put: #error ;
			at: #message put: anError description.

		^ logDatabase
			performOne: #insertErrorLogRecord
			statement: self insertErrorLogStatement
			bind: logRecord
	] on: Error do: [ :error |
		self warnCr: 'Failed to write error log record: ', error printString.
		^ nil ]
]

{ #category : #logging }
CynBaseRestApiService >> logErrorMessage: aString [

	^ self logErrorMessage: aString request: nil
]

{ #category : #logging }
CynBaseRestApiService >> logErrorMessage: aString request: aRestRequest [

	"Log the specified message for the specified REST request.
	Answer the rowId of the added log row."

	^ self log: #error message: aString request: aRestRequest
]

{ #category : #logging }
CynBaseRestApiService >> logInfoMessage: aString [

	^ self logInfoMessage: aString request: nil
]

{ #category : #logging }
CynBaseRestApiService >> logInfoMessage: aString request: aRestRequest [

	"Log the specified message for the specified REST request.
	Answer the rowId of the added log row."

	^ self log: #info message: aString request: aRestRequest
]

{ #category : #logging }
CynBaseRestApiService >> logRecordFromError: anError request: aRestRequest [

	"Subclasses should add/overwrite any relevant data.
	This should match the insert statment in #insertErrorLogStatement.
	The specified REST request might be nil."

	^ Dictionary new
		at: #statusCode put: anError restResponseCode ;
		at: #stack put: (anError signalerContext ifNotNil: [ :stackContext | stackContext printString ]) ;
		at: #request put: (aRestRequest ifNotNil: [ aRestRequest printString ]);
		at: #body put: (aRestRequest ifNotNil: [ self bodyFromRequest: aRestRequest ]) ;
		yourself
]

{ #category : #logging }
CynBaseRestApiService >> logRecordFromRequest: aRestRequest [

	"Subclasses should add/overwrite any relevant data.
	This should match the insert statment in #insertLogStatement.
	The specified REST request might be nil."

	^ Dictionary new
]

{ #category : #logging }
CynBaseRestApiService >> logWarnMessage: aString [

	^ self logWarnMessage: aString request: nil
]

{ #category : #logging }
CynBaseRestApiService >> logWarnMessage: aString request: aRestRequest [

	"Log the specified message for the specified REST request.
	Answer the rowId of the added log row."

	^ self log: #warn message: aString request: aRestRequest
]

{ #category : #'API - support' }
CynBaseRestApiService >> mail: aMessage to: aString [

	"Send the specified Message to the specified recipient"

	"Update message with to fields"
	aMessage to: aString.

	mailer sendMail: aMessage thenDo: [ :error :info |
		error ifNotNil: [ self logError: error ].
		info ifNotNil: [ self logInfoMessage: 'Send mail: ', aMessage restApiLogInfo ] ]
]

{ #category : #'API - resources' }
CynBaseRestApiService >> newId [

	"Answer a new random ID (for a row)"

	^ self crypto randomUUID
]

{ #category : #'API - support' }
CynBaseRestApiService >> newMailMessage [

	"Answer a new mail message"

	| message |

	message := CpNodeJSNodemailerMessage new.

	"Add Delivery Status Notification (if requested)"
	config at: #'mailer-dsn' ifPresent: [ :dsn |
		message dsn: (CpNodeJSNodemailerSmtpDSN fromDictionary: dsn) ].

	^ message
]

{ #category : #'API - resources' }
CynBaseRestApiService >> newToken [

	"Answer a new random token value"

	^ (self crypto randomBytes: 16) toStringEncoding: 'hex'
]

{ #category : #'API - support' }
CynBaseRestApiService >> operationFor: aCompiledMethod [

	"Answer a MessageSend (used in CpNodeJSRestEndpointOperation) for the receiver and the specified Compiled Method"

	| action pragma url operation |

	action := MessageSend receiver: self selector: aCompiledMethod selector.

	pragma := aCompiledMethod pragmas
		detect: [ :each | #(#get: #post: #put: #patch: #delete:) includes: each selector ] ifNone: [ ^ nil ].

	url := CpBrowserURL newUrl: pragma arguments first base: 'http://localhost'.

	pragma selector == #get:
		ifTrue: [ operation := self class restEndpointOperationClass uri: url getOperation: action ].
	pragma selector == #post:
		ifTrue: [ operation := self class restEndpointOperationClass uri: url postOperation: action ].
	pragma selector == #put:
		ifTrue: [ operation := self class restEndpointOperationClass uri: url putOperation: action ].
	pragma selector == #patch:
		ifTrue: [ operation := self class restEndpointOperationClass uri: url patchOperation: action ].
	pragma selector == #delete:
		ifTrue: [ operation := self class restEndpointOperationClass uri: url deleteOperation: action ].

	operation
		ifNotNil: [ ^ operation ].

	self error: 'Not implemented yet'
]

{ #category : #API }
CynBaseRestApiService >> ping: aRestRequest response: aServerResponse [

	"Ping to check on liveness"

	<get: '/api/ping/hello'>
	<public>

	"Pong the message back to the requestor"
	self send: 'world' response: aServerResponse
]

{ #category : #support }
CynBaseRestApiService >> reReadConfig [

	| oldConfig oldVersion |

	oldConfig := config.
	oldVersion := self version.

	[
		version := nil.
		config := CpJavaScriptJSON parse: (CpNodeJSFS require readFileSync: self class configFile options: 'utf-8').
		(config at: #mailer) = (oldConfig at: #mailer)
			ifFalse: [ self initializeMailer ].
		self traceCr: 'Re-read config'
	] on: Error do: [ :error |
		self errorCr: 'Failed to re-read the config: ', error printString.
		config := oldConfig.
		self initializeMailer ].

	self updateVersion: oldVersion to: self version
]

{ #category : #dependencies }
CynBaseRestApiService >> release [

	config := nil.
	modelDatabase ifNotNil: [
		modelDatabase close.
		modelDatabase := nil ].
	logDatabase ifNotNil: [
		logDatabase close.
		logDatabase := nil].
	crypto := nil.
	mailer ifNotNil: [
		mailer close.
		mailer := nil ].
	configUpdater ifNotNil: [
		CpGlobalThis clearTimeout: configUpdater ].
	configWatcher ifNotNil: [
		configWatcher close.
		configWatcher := nil ].
	version := nil.

	super release
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

{ #category : #support }
CynBaseRestApiService >> stopWatchConfig [

	configWatcher ifNotNil: [
		configWatcher close.
		configWatcher := nil ]
]

{ #category : #logging }
CynBaseRestApiService >> updateLogError: anError response: aRestResponse [

	"Update the log entry with error result.
	This should only update the error specific fields.
	The statusCode and duration will be updated regularly using the
	#updateLogRequest:statusCode: method which is always called.
	Answer the id of the log record (or nil if none is updated/added)."

	| request rowId |

	request := aRestResponse request.
	rowId := request propertyAt: #rowId.

	"In case the writing of the initial log entry failed, try the simple error log anyway"
	rowId ifNil: [
		^ self log: #error message: anError description request: request ].

	"Update the existing entry"
	[
		logDatabase
			performOne: #updateLogRecord
			statement: 'UPDATE logs SET stack=:stack, request=:request, body=:body WHERE rowid=:rowId'
			bind: {
				#stack -> (anError signalerContext ifNotNil: [ :stackContext | stackContext printString ]).
				#request -> request printString.
				#body -> (self bodyFromRequest: request).
				#rowId -> rowId } asDictionary.
		^ rowId
	] on: Error do: [ :error |
		self warnCr: 'Failed to write error log: ', error printString.
		^ nil ]
]

{ #category : #logging }
CynBaseRestApiService >> updateLogResponse: aRestResponse [

	"Update the log with additional info.
	Answer the id of the log record (or nil if none is updated/added)."

	| request rowId stop duration |

	request := aRestResponse request.
	rowId := (request propertyAt: #rowId)
		ifNil: [ ^ nil ].
	stop := CpNodeJSRestHttpServer timerNow.
	duration := (stop - (request propertyAt: #start)) floor.

	[
		logDatabase
			performOne: #updateLogRecord
			statement: 'UPDATE logs SET statusCode=:statusCode, duration=:duration WHERE rowid=:rowId'
			bind: {
				#statusCode -> aRestResponse statusCode.
				#duration -> duration.
				#rowId -> rowId } asDictionary.
		^ rowId
	] on: Error do: [ :error |
		self warnCr: 'Failed to update log record: ', error printString.
		^ nil ]
]

{ #category : #support }
CynBaseRestApiService >> updateVersion: oldVersionString to: newVersionString [

	"Subclasses might handle this specifically"
]

{ #category : #'API - authorization' }
CynBaseRestApiService >> validatePublicAuthorizedRequest: aRestRequest [

	"Default authorization handler for public data"
]

{ #category : #accessing }
CynBaseRestApiService >> version [

	^ version ifNil: [ version := config at: #version ifAbsent: [ '' ] ]
]

{ #category : #support }
CynBaseRestApiService >> watchConfig [

	self stopWatchConfig.

	configWatcher := CpNodeJSFS namespace
		watch: self class configFile listener: [ :event :fileName |

			"Ensure FS is stable again and update is performed only once!"
			configUpdater ifNotNil: [ CpGlobalThis clearTimeout: configUpdater ].
			configUpdater:= CpGlobalThis setTimeout: 1000 thenDo: [
				self reReadConfig.

				"Reset the watcher (needed on some OSses)"
				self watchConfig.

				"Reset the updater"
				configUpdater := nil ] ]
]
