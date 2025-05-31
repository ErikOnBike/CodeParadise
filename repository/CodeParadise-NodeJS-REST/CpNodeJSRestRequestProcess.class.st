"
I represent a Process in which a REST Request is handled.
I am responsible for letting an EndpointOperation handle the Request
and send a Response. The EndpointOperation will notify me when the
Request can't be handled because of a mismatch in available endpoints.
I am responsible for keeping track of time and signal a timeout if
the Process takes too long.
"
Class {
	#name : #CpNodeJSRestRequestProcess,
	#superclass : #Object,
	#instVars : [
		'request',
		'response',
		'process',
		'startedAt',
		'endedAt',
		'isUnhandled',
		'timer'
	],
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #'instance creation' }
CpNodeJSRestRequestProcess class >> new [

	self errorNewReplacedBy: #request:response:
]

{ #category : #'instance creation' }
CpNodeJSRestRequestProcess class >> request: aRequest response: aServerResponse [

	^ self basicNew
		initializeWithRequest: aRequest response: aServerResponse ;
		yourself
]

{ #category : #running }
CpNodeJSRestRequestProcess class >> runRequest: aRequest response: aServerResponse [

	"Create an instance of the receiver for the specified Request and Response and start running it"

	^ (self request: aRequest response: aServerResponse)
		run ;
		yourself
]

{ #category : #running }
CpNodeJSRestRequestProcess >> abort [

	"Abort the request process.

	Implementation:
	Allow multiple invocations by guarding the clean-up code. The #writeError: message
	has its own safe guard and prevents multiple writes on the same response.
	This method will be called from a separate Process (the timeout handler set in the
	method #run) and can therefore terminate the Process without terminating itself."

	"Already ended, ignore abort"
	endedAt ifNotNil: [ ^ self ].

	"Mark end"
	endedAt := CpNodeJSRestHttpServer timestampNow.

	"Kill the process (will not kill the active Process of this context)"
	process ifNotNil: [
		process terminate.
		process := nil ].

	"Clean up"
	timer ifNotNil: [
		CpGlobalThis clearTimeout: timer.
		timer := nil ].

	"Answer the failure"
	self respondTimedout
]

{ #category : #accessing }
CpNodeJSRestRequestProcess >> defaultTimeoutPeriod [

	"Answer the default timeout period in ms before a request is aborted.
	
	This value should be low by default and set explicitly on endpoints which
	require a longer processing time. Use pragma #timeout: on an endpoint
	operation (method)."

	^ 2000
]

{ #category : #initialization }
CpNodeJSRestRequestProcess >> initializeWithRequest: aRequest response: aServerResponse [

	self initialize.

	request := aRequest.
	response := aServerResponse.

	"See method #unhandled"
	isUnhandled := false
]

{ #category : #performing }
CpNodeJSRestRequestProcess >> performEndpointOperation: anEndpointOperation [

	"Perform the specified endpoint operation"

	| timeoutPeriod |

	timeoutPeriod := (anEndpointOperation timeout)
		ifNil: [ self defaultTimeoutPeriod ].

	timer := CpGlobalThis setTimeout: timeoutPeriod thenDo: [ self abort ].

	anEndpointOperation handleRequest: request response: response
]

{ #category : #printing }
CpNodeJSRestRequestProcess >> printOn: aStream [

	aStream
		nextPutAll: 'Request for ' ;
		nextPutAll: request method asString ;
		nextPutAll: ' on ' ;
		nextPutAll: request url asString.

	startedAt
		ifNotNil: [
			aStream
				nextPutAll: ' started at: ' ;
				nextPutAll: (CpNodeJSRestHttpServer timeStringAt: startedAt) ]
		ifNil: [ aStream nextPutAll: ' not started yet' ].

	response writableEnded
		ifTrue: [
			aStream
				nextPutAll: ' ended with status ' ;
				print: response statusCode ;
				nextPutAll: ' at ' ;
				nextPutAll: (CpNodeJSRestHttpServer timeStringAt: (endedAt ifNil: [ CpNodeJSRestHttpServer timestampNow ])) ]
		ifFalse: [ aStream nextPutAll: ' not ended yet' ]
]

{ #category : #responding }
CpNodeJSRestRequestProcess >> respondError: anError [

	"Write an error response"

	response writeError: anError
]

{ #category : #responding }
CpNodeJSRestRequestProcess >> respondTimedout [

	"Write a response to indicate the request is timed out (this is an Error).

	Implementation:
	There is no generic timeout error in the standard HTTP status codes.
	Use the generic 500 - Internal Server Error, but provide a specific error message."

	self respondError: (CpNodeJSRestError new
		messageText: 'Timeout processing request ', request path ;
		yourself)
]

{ #category : #responding }
CpNodeJSRestRequestProcess >> respondUnhandled [

	"Write a response to indicate the request is unhandled (this is an Error).

	Implementation:
	An unhandled GET aka read Request is considered a 404 - Not found.
	An unhandled write Request is considered a 400 - Bad Request."

	self respondError: (request method = 'GET'
		ifTrue: [ CpNodeJSRestNotFoundError ]
		ifFalse: [ CpNodeJSRestBadRequestError ])
]

{ #category : #running }
CpNodeJSRestRequestProcess >> run [

	"Try to handle the request and produce a matching response"

	CpGlobalThis defer: [ self runInternal ]
]

{ #category : #running }
CpNodeJSRestRequestProcess >> runInternal [

	"Run the receiver with Error checking"

	| errorInstance endpointOperation |

	errorInstance := [

		"Keep track of Process"
		process := Processor activeProcess.

		"Mark start"
		startedAt := CpNodeJSRestHttpServer timestampNow.

		"Log the call in development"
		CpJavaScriptObject isDevelopmentEnvironment
			ifTrue: [ self traceCr: self printString ].

		"Try to handle the request (unhandled requests are 'business as usual')"
		endpointOperation := CpNodeJSRestEndpointOperation matchingRequest: request.
		endpointOperation
			ifNotNil: [ self performEndpointOperation: endpointOperation ]
			ifNil: [ self unhandled ].
	
		"No error"
		nil
	] on: Error do: [ :error | error ].

	"Mark end"
	endedAt := CpNodeJSRestHttpServer timestampNow.

	"Clean up"
	timer ifNotNil: [
		CpGlobalThis clearTimeout: timer.
		timer := nil ].
	process := nil.

	"Log the call in development"
	CpJavaScriptObject isDevelopmentEnvironment
		ifTrue: [ self traceCr: self printString ].

	"Respond with error if present"
	errorInstance ifNil: [ ^ self ].

	self respondError: errorInstance
]

{ #category : #running }
CpNodeJSRestRequestProcess >> unhandled [

	"The receiver is unhandled"

	isUnhandled := true.

	self respondUnhandled
]
