"
I am a REST HTTP Server and will serve the endpoints provided.
I am snapshot aware, meaning I can be turned into a standalone application
by snapshotting my instances.

"
Class {
	#name : #CpNodeJSRestHttpServer,
	#superclass : #Object,
	#instVars : [
		'server',
		'port'
	],
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #'instance creation' }
CpNodeJSRestHttpServer class >> new [

	self errorNewReplacedBy: #newOnPort:
]

{ #category : #'instance creation' }
CpNodeJSRestHttpServer class >> newOnPort: anInteger [

	"Create a new instance on the specified port"

	^ self basicNew
		initializeOnPort: anInteger ;
		yourself
]

{ #category : #'class initialization' }
CpNodeJSRestHttpServer class >> postInstallOnce [

	"Register class for snapshotting"

	CpNodeJSSnapshot registerSnapshotClass: self
]

{ #category : #'class initialization' }
CpNodeJSRestHttpServer class >> postSnapshotOnce [

	"(Re)start all instances"

	self allInstancesDo: [ :each | each startServer ]
]

{ #category : #'class initialization' }
CpNodeJSRestHttpServer class >> preSnapshotOnce [

	"Stop all instances"

	self allInstancesDo: [ :each | each stopServer ]
]

{ #category : #accessing }
CpNodeJSRestHttpServer class >> responseStringFromError: anError [

	"Answer a response string from the specified error"

	| error indent |

	error := anError.
	indent := ''.

	^ String streamContents: [ :stream |
		[
			"Write error description"
			stream
				nextPutAll: error description ;
				nextPutAll: String lf.

			indent := indent, '    '.

			"Go deeper into the cause until nothing left"
			(error cause
				ifNotNil: [ :cause |
					cause isErrorObject
						ifTrue: [ error := cause ]
						ifFalse: [ nil ] ]) isNotNil
		] whileTrue ]
]

{ #category : #accessing }
CpNodeJSRestHttpServer class >> statusCreated [

	^ 201
]

{ #category : #accessing }
CpNodeJSRestHttpServer class >> statusNoContent [

	^ 204
]

{ #category : #accessing }
CpNodeJSRestHttpServer class >> statusOK [

	^ 200
]

{ #category : #server }
CpNodeJSRestHttpServer >> createServer [

	server ifNotNil: [ ^ server ].

	^ server := CpNodeJSHttp require
		createServerOn: [ :req :res | self handleRequest: req response: res ]
]

{ #category : #'event handling' }
CpNodeJSRestHttpServer >> handleRequest: anIncomingMessage response: aServerResponse [

	"Extract request from incoming message"
	[
		| request |

		"Extract request from incoming message"
		request := CpNodeJSRestRequest fromIncomingMessage: anIncomingMessage.

		"Handle actual request and write appropriate response"
		CpNodeJSRestEndpointOperation handleRequest: request response: aServerResponse
	] on: Error do: [ :error |
		aServerResponse
			statusCode: error restResponseCode ;
			writeChunk: (self class responseStringFromError: error) ;
			writeChunk: String lf ;
			end.
		^ self	
	]
]

{ #category : #initialization }
CpNodeJSRestHttpServer >> initialize [

	super initialize.

	self startServer
]

{ #category : #initialization }
CpNodeJSRestHttpServer >> initializeOnPort: anInteger [

	port := anInteger.

	self initialize
]

{ #category : #snapshot }
CpNodeJSRestHttpServer >> snapshot [

	CpNodeJSSnapshot saveSnapshot
]

{ #category : #server }
CpNodeJSRestHttpServer >> startServer [

	self traceCr: 'Create REST server on port ', port printString.
	self createServer listenOnPort: 8181 thenDo: [ self traceCr: 'REST server is listening' ]
]

{ #category : #server }
CpNodeJSRestHttpServer >> stopServer [

	self traceCr: 'Stop REST server'.
	server close.
	server := nil
]
