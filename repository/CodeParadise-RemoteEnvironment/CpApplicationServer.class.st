"
I am a RemoteEnvironmentServer. I am responsible for creating and maintaining remote environments. Remote environments are a combination of ClientEnvironment and ServerEnvironment instances. The RemoteEnvironment allows Smalltalk code to be executed in a remote image. I provide a webserver port on which ClientEnvironments can start communication with a ServerEnvironment (to become the remote environment together). I am responsible for providing RemoteEnvironments with a unique identifier to allow communication between the ClientEnvironment and ServerEnvironment even when communication needs to be restarted (on a new connection). I provide the ServerEnvironments with the new connection in such situations.

Implementation:
Whenever a new connection is made for an id-less ClientEnvironment I create a new ServerEnvironment and provide it with a new identifier. The ServerEnvironment sends this identifier back to the ClientEnvironment. I keep track of all ServerEnvironments which are instantiated. Whenever an Announcement arrives from the ClientEnvironment for a ServerEnvironment, the specific instance is retrieved from this collection based on the provided ClientEnvironment identifier. In this way RemoteEnvironments are not tightly bound to a connection. The ClientEnvironment can setup a new connection (for example when a bad Internet-connection has dropped) and will continu communicating through that new connection.
"
Class {
	#name : #CpApplicationServer,
	#superclass : #Object,
	#instVars : [
		'serverEnvironments',
		'serverEnvironmentsMutex',
		'identifierGenerator',
		'server',
		'clientErrorHandler'
	],
	#category : #'CodeParadise-RemoteEnvironment-Core'
}

{ #category : #'instance creation' }
CpApplicationServer class >> newOnPort: anInteger path: aString [

	"Create a new instance of the receiver listening on the specified port and path"

	^ self new
		startOnPort: anInteger path: aString ;
		yourself
]

{ #category : #accessing }
CpApplicationServer >> clientErrorHandler [

	^ clientErrorHandler
]

{ #category : #accessing }
CpApplicationServer >> clientErrorHandler: anObject [

	"Set the ClientError handler (an Object responding to: #handleClientError:for:)"

	clientErrorHandler := anObject
]

{ #category : #'adding/removing' }
CpApplicationServer >> createServerEnvironment [

	"Create new ServerEnvironment with an unique id"

	serverEnvironmentsMutex critical: [
		| id serverEnvironment |

		id := identifierGenerator generateSatisfying: [ :identifier |
			(self serverEnvironments includesKey: identifier) not ].

		serverEnvironment := CpServerEnvironment newWithId: id.

		"Add subscriptions to environment being started"
		serverEnvironment
			when: CpClientStopped do: [ self removeServerEnvironment: serverEnvironment ] for: self ;
			when: CpClientError send: #handleClientError:announcedBy: to: self.

		"Store new environment"
		^ self serverEnvironments at: id put: serverEnvironment ]
]

{ #category : #'message handling' }
CpApplicationServer >> handleClientError: aClientError announcedBy: anAnnouncer [

	"Handle the ClientError which was announced by the specified Announcer.

	Implementation:
	Find the ServerEnvironment matching the given announcer"

	serverEnvironments ifNotNil: [
		serverEnvironments
			detect: [ :each | each hasAnnouncer: anAnnouncer ]
			ifFound: [ :each | self handleClientError: aClientError for: each ] ]
]

{ #category : #'message handling' }
CpApplicationServer >> handleClientError: aClientError for: aServerEnvironment [

	"Handle the ClientError"

	self clientErrorHandler ifNotNil: [ :handler |
		handler handleClientError: aClientError for: aServerEnvironment ]
]

{ #category : #'message handling' }
CpApplicationServer >> handleMessageReceived: aByteArray on: aMessageChannel [

	"Handle the message received from the specified MessageChannel.
	Impementation:
	A message from the client should start with the client's id. This id is extracted
	from the message. The remaining message is passed to the appropriate ServerEnvironment."

	| decoder id message serverEnvironment |

	"Ignore if MessageChannel is closed"
	aMessageChannel ifNil: [ ^ self ].

	"Decode message, extracting the id and keeping the remainder"
	decoder := CpObjectDecoder on: aByteArray.
	id := decoder decodeNext.
	message := decoder remainingBytes.

	"Create new environment or select existing environment"
	serverEnvironment := id
		ifNotNil: [
			self
				serverEnvironmentForId: id 
				ifAbsent: [
					aMessageChannel sendMessage: CpServerEnvironment invalidSessionMessage.
					^ self ] ]
		ifNil: [ self createServerEnvironment ].

	"Update the Communicator of the ServerEnvironment with the (possibly new) MessageChannel"
	serverEnvironment updateCommunicatorWith: aMessageChannel.

	"Let the ServerEnvironment handle the message"
	serverEnvironment handleMessageReceived: message
]

{ #category : #initialization }
CpApplicationServer >> initialize [

	"Initialize the receiver"

	super initialize.

	serverEnvironments := Dictionary new.
	serverEnvironmentsMutex := Mutex new.

	identifierGenerator := CpWebIdentifierGenerator new
]

{ #category : #initialization }
CpApplicationServer >> release [

	"Release the receiver's instance variables"

	self releaseServer.

	clientErrorHandler := nil.

	identifierGenerator := nil.

	serverEnvironments := nil.
	serverEnvironmentsMutex := nil.

	super release
]

{ #category : #initialization }
CpApplicationServer >> releaseServer [

	"Release the receiver's server"

	server ifNil: [ ^ self ].

	server stop.
	server := nil
]

{ #category : #'adding/removing' }
CpApplicationServer >> removeServerEnvironment: aServerEnvironment [

	"Remove the specified ServerEnvironment from the receiver"

	serverEnvironmentsMutex critical: [
		^ self serverEnvironments
			removeKey: aServerEnvironment id
			ifAbsent: [ nil "ignore the fact that the ServerEnvironment is unknown" ] ]
]

{ #category : #accessing }
CpApplicationServer >> server [ 

	^ server
]

{ #category : #accessing }
CpApplicationServer >> serverEnvironmentForId: id ifAbsent: aBlock [

	"Answer the ServerEnvironment with the specified id or evaluate the specified Block if such
	a ServerEnvironment does not exist or is not running (anymore)"

	serverEnvironmentsMutex critical: [
		^ self serverEnvironments
			at: id
			ifPresent: [ :serverEnvironment |
				serverEnvironment isRunning
					ifTrue: [ serverEnvironment ]
					ifFalse: [ aBlock value ] ]
			ifAbsent: aBlock ]
]

{ #category : #accessing }
CpApplicationServer >> serverEnvironments [

	"Answer the receiver's ServerEnvironments"

	^ serverEnvironments
]

{ #category : #'starting/stopping' }
CpApplicationServer >> startOnPort: anInteger path: aString [

	"Start listening on the specified port and path"

	self stop.

	server := CpMessageChannel startServerForOwner: self onPort: anInteger path: aString
]

{ #category : #'starting/stopping' }
CpApplicationServer >> stop [

	"Stop the receiver"

	self
		stopServerEnvironments ;
		releaseServer
]

{ #category : #'starting/stopping' }
CpApplicationServer >> stopServerEnvironments [

	"Stop all the ServerEnvironments registered with the receiver"

	serverEnvironmentsMutex critical: [
		serverEnvironments valuesDo: [ :each | each stop ].
		serverEnvironments removeAll ]
]
