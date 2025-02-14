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

{ #category : #accessing }
CpNodeJSRestHttpServer class >> statusOK [

	^ 200
]

{ #category : #resources }
CpNodeJSRestHttpServer class >> timeStringAt: anInteger [

	"Answer the specified timestamp (seconds since Unix epoch) as a String in ISO8601 format"

	^ ((CpJavaScriptClass forName: #Date) newInstanceWithArguments: { anInteger * 1000 }) apply: #toISOString
]

{ #category : #resources }
CpNodeJSRestHttpServer class >> timestampNow [

	"Answer the current timestamp as seconds since Unix epoch (midnight Jan 1, 1970, UTC)"

	^ ((CpJavaScriptClass forName: #Date) apply: #now) // 1000
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
		CpNodeJSRestRequestProcess runRequest: request response: aServerResponse
	] on: Error do: [ :error | aServerResponse writeError: error]
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

	self traceCr: ('Create REST server on port ', port printString ).
	self createServer listenOnPort: 8181 thenDo: [ self traceCr: 'REST server is listening' ]
]

{ #category : #server }
CpNodeJSRestHttpServer >> stopServer [

	self traceCr: 'Stop REST server'.
	server close.
	server := nil
]
