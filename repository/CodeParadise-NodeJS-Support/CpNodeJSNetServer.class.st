Class {
	#name : #CpNodeJSNetServer,
	#superclass : #CpNodeJSEventEmitter,
	#category : #'CodeParadise-NodeJS-Support-Net'
}

{ #category : #accessing }
CpNodeJSNetServer class >> module [

	"Answer the module the receiver is part of"

	^ CpNodeJSNet
]

{ #category : #accessing }
CpNodeJSNetServer >> address [

	"Returns the bound address, the address family name, and port of the server as reported
	by the operating system if listening on an IP socket (useful to find which port was
	assigned when getting an OS-assigned address):
	{ port: 12346, family: 'IPv4', address: '127.0.0.1' }.

	For a server listening on a pipe or Unix domain socket, the name is returned as a string."

	^ self apply: #address
]

{ #category : #operations }
CpNodeJSNetServer >> close [

	self closeThenDo: nil
]

{ #category : #operations }
CpNodeJSNetServer >> closeThenDo: aBlock [

	"Stops the server from accepting new connections and keeps existing connections. This function is
	asynchronous, the server is finally closed when all connections are ended and the server emits a
	'close' event. The optional callback will be called once the 'close' event occurs. Unlike that event,
	it will be called with an Error as its only argument if the server was not open when it was closed."

	self apply: #close withArguments: { aBlock }
]

{ #category : #accessing }
CpNodeJSNetServer >> getConnectionsThenDo: aBlock [

	"Asynchronously get the number of concurrent connections on the server. Works when sockets were sent to forks.

	Callback should take two arguments err and count."

	self apply: #getConnections withArguments: { aBlock }
]

{ #category : #operations }
CpNodeJSNetServer >> listenOnPort: anInteger [

	^ self listenOnPort: anInteger thenDo: nil
]

{ #category : #operations }
CpNodeJSNetServer >> listenOnPort: anInteger thenDo: aBlock [

	^ self
		listenWithOptions: { #port -> anInteger } asDictionary
		thenDo: aBlock
]

{ #category : #operations }
CpNodeJSNetServer >> listenWithOptions: aDictionary thenDo: aBlock [

	"Start a server listening for connections. A net.Server can be a TCP or an IPC server depending on what it listens to.

	When the receiver is bound and starts listening the specified Block is evaluated.

	The following options can be specified:
	
	port <Integer>
	host <String>
	path <String>
		Will be ignored if port is specified. See Identifying paths for IPC connections.
	backlog <Integer>
		Specify the maximum length of the queue of pending connections. The actual length will be
		determined by the OS through sysctl settings such as tcp_max_syn_backlog and somaxconn on Linux.
		The default value of this parameter is 511 (not 512).
	exclusive <Boolean>
		Default: false
	readableAll <Boolean>
		For IPC servers makes the pipe readable for all users. Default: false.
	writableAll <Boolean>
		For IPC servers makes the pipe writable for all users. Default: false.
	ipv6Only <Boolean>
		For TCP servers, setting ipv6Only to true will disable dual-stack support, i.e., binding to
		host :: won't make 0.0.0.0 be bound. Default: false.
	signal <AbortSignal>
		An AbortSignal that may be used to close a listening server."

	self apply: #listen withArguments: { aDictionary . aBlock }
]

{ #category : #accessing }
CpNodeJSNetServer >> listening [

	"Indicates whether or not the server is listening for connections."

	^ self propertyAt: #listening
]

{ #category : #accessing }
CpNodeJSNetServer >> maxConnections [

	"Set this property to reject connections when the server's connection count gets high.

	It is not recommended to use this option once a socket has been sent to a child with child_process.fork()."

	^ self propertyAt: #maxConnections
]

{ #category : #accessing }
CpNodeJSNetServer >> maxConnections: anInteger [

	"Set this property to reject connections when the server's connection count gets high.

	It is not recommended to use this option once a socket has been sent to a child with child_process.fork()."

	self propertyAt: #maxConnections put: anInteger
]

{ #category : #'event handling' }
CpNodeJSNetServer >> onCloseDo: aBlock [

	"Emitted when the server closes. If connections exist, this event is not emitted until all connections are ended."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addListener: #close handler: aBlock
]

{ #category : #'event handling' }
CpNodeJSNetServer >> onConnectionDo: aBlock [

	"Emitted when a new connection is made. socket is an instance of net.Socket.
	
	The specified Block will be evaluated with the Socket."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addListener: #connection handler: aBlock
]

{ #category : #'event handling' }
CpNodeJSNetServer >> onDropDo: aBlock [

	"When the number of connections reaches the threshold of server.maxConnections, the server will
	drop new connections and emit 'drop' event instead. If it is a TCP server, the argument is as
	follows, otherwise the argument is undefined.
	
	The specified Block will be evaluated with a Object/Dictionary.

	The following fields are present:

	localAddress <String>
		Local address.
	localPort <Integer>
		Local port.
	localFamily <String>
		Local family.
	remoteAddress <String>
		Remote address.
	remotePort <Integer>
		Remote port.
	remoteFamily <String>
		Remote IP family. 'IPv4' or 'IPv6'."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addListener: #drop handler: aBlock
]

{ #category : #'event handling' }
CpNodeJSNetServer >> onErrorDo: aBlock [

	"Emitted when an error occurs. Unlike net.Socket, the 'close' event will not be emitted directly following this event unless server.close() is manually called. See the example in discussion of server.listen().
	
	The specified Block will be evaluated with the Error that occurred."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addListener: #error handler: aBlock
]

{ #category : #'event handling' }
CpNodeJSNetServer >> onListeningDo: aBlock [

	"Emitted when the server has been bound after calling server.listen()."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addListener: #listening handler: aBlock
]
