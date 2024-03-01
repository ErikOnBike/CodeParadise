Class {
	#name : #CpNodeJSExampleHttpServer,
	#superclass : #Object,
	#instVars : [
		'calculator',
		'server'
	],
	#classVars : [
		'Current'
	],
	#category : #'CodeParadise-NodeJS-Support-Examples'
}

{ #category : #accessing }
CpNodeJSExampleHttpServer class >> current [

	^ Current ifNil: [ Current := self basicNew initialize ; yourself ]
]

{ #category : #'instance creation' }
CpNodeJSExampleHttpServer class >> new [

	self error: 'Please use ', #current
]

{ #category : #'class initialization' }
CpNodeJSExampleHttpServer class >> postInstallOnce [

	"Start current"

	CpNodeJSSnapshot registerSnapshotClass: self.

	self current
]

{ #category : #'class initialization' }
CpNodeJSExampleHttpServer class >> postSnapshotOnce [

	"(Re)start current"

	self current startServer
]

{ #category : #'class initialization' }
CpNodeJSExampleHttpServer class >> preSnapshotOnce [

	"Stop current"

	self current stopServer
]

{ #category : #server }
CpNodeJSExampleHttpServer >> createServer [

	server ifNotNil: [ ^ server ].

	^ server := CpNodeJSHttp require
		createServerOn: [ :req :res | self handleRequest: req response: res ]
]

{ #category : #evaluating }
CpNodeJSExampleHttpServer >> evaluate: aString [

	"Evaluate the given command"

	| colonIndex |

	"Special case"
	aString = 'snapshot'
		ifTrue: [ ^ self snapshot ].

	"Make distinction between message with and without an argument"
	(colonIndex := aString indexOf: $:) > 0
		ifTrue: [
			calculator
				perform: (aString first: colonIndex) asSymbol
				withArguments: { (aString allButFirst: colonIndex) asNumber } ]
		ifFalse: [
			calculator perform: aString asSymbol ]
]

{ #category : #evaluating }
CpNodeJSExampleHttpServer >> evaluateCommands: commandsStream [

	"Evaluate the specified commands (which is a Stream on a URL path) on the receiver's current object"

	| nextCommand |

	[ commandsStream atEnd ] whileFalse: [

		"Read next command and prepare stream for the following"
		(nextCommand := commandsStream upTo: $/) ifNotEmpty: [
			self evaluate: nextCommand ] ]
]

{ #category : #'event handling' }
CpNodeJSExampleHttpServer >> handleRequest: anIncomingMessage response: aServerResponse [

	| showUsage |

	showUsage := false.

	[
		| commandsStream |
		commandsStream := anIncomingMessage url readStream.
		commandsStream peekFor: $/.	"Skip first slash"
		commandsStream atEnd
			ifTrue: [ showUsage := true ]
			ifFalse: [
				self evaluateCommands: commandsStream.
				aServerResponse
					writeChunk: calculator value, String lf ;
					statusCode: 200 ]
	] on: Error do: [ :anError |
		aServerResponse
			writeChunk: 'Failure: ', anError printString, String lf, String lf ;
			statusCode: 500.
		showUsage := true
	].

	showUsage ifTrue: [
		aServerResponse
			writeChunk: 'I am a calculating HTTP Server.', String lf ;
			writeChunk: 'Try sending me as URL "/add:42" to add a number. You can also use "/subtract:7", "/multiply:3" or "/divide:2.5".', String lf ;
			writeChunk: 'Or combine calculations "/add:3/subtract:7/multiply:3.1/subtract:2.78".', String lf ;
			writeChunk: 'You can repeatedly perform calculations. To see the current value use "/value".', String lf ;
			writeChunk: 'To remove the last calculation use "/undo", to remove all calculations use "/reset".', String lf ;
			writeChunk: 'You can snapshot the image using "/snapshot". From that point, the image is "sealed" and no', String lf ;
			writeChunk: 'updates can be made to the image using the CodeParadise server. The image can be snapshotted', String lf ;
			writeChunk: 'again later to store the current calculation once more. Every snapshot will overwrite the image.', String lf ;
			writeChunk: '(I do not support LargeIntegers on input, but do support such outcomes)', String lf ;
			writeChunk: 'Have fun!', String lf ].

	aServerResponse end
]

{ #category : #initialization }
CpNodeJSExampleHttpServer >> initialize [

	super initialize.

	calculator := CpNodeJSExampleCalculator current.

	self startServer
]

{ #category : #snapshot }
CpNodeJSExampleHttpServer >> snapshot [

	CpNodeJSSnapshot saveSnapshot
]

{ #category : #server }
CpNodeJSExampleHttpServer >> startServer [

	self crTrace: 'Create server and start listening on port 8181'.
	self createServer listenOnPort: 8181 thenDo: [ self crTrace: 'I am listening!' ]
]

{ #category : #server }
CpNodeJSExampleHttpServer >> stopServer [

	self crTrace: 'Stop server'.
	server close.
	server := nil
]
