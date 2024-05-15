Class {
	#name : 'CpNodeJSHttpServer',
	#superclass : 'CpNodeJSNetServer',
	#category : 'CodeParadise-NodeJS-Support-Http',
	#package : 'CodeParadise-NodeJS-Support',
	#tag : 'Http'
}

{ #category : 'accessing' }
CpNodeJSHttpServer class >> module [

	"Answer the module the receiver is part of"

	^ CpNodeJSHttp
]

{ #category : 'class initialization' }
CpNodeJSHttpServer class >> postInstallOnce [

	"Pre-load the relevant classes"

	CpNodeJSHttpIncomingMessage beLoaded.
	CpNodeJSHttpServerResponse beLoaded
]

{ #category : 'operations' }
CpNodeJSHttpServer >> closeAllConnections [

	"Closes all connections connected to this server."

	self apply: #closeAllConnections
]

{ #category : 'operations' }
CpNodeJSHttpServer >> closeIdleConnections [

	"Closes all connections connected to this server which are not sending a request or waiting for a response."

	self apply: #closeIdleConnections
]

{ #category : 'accessing' }
CpNodeJSHttpServer >> headersTimeout [

	"Limit the amount of time the parser will wait to receive the complete HTTP headers.

	If the timeout expires, the server responds with status 408 without forwarding the request
	to the request listener and then closes the connection.

	It must be set to a non-zero value (e.g. 120 seconds) to protect against potential
	Denial-of-Service attacks in case the server is deployed without a reverse proxy in front."

	^ self propertyAt: #headersTimeout
]

{ #category : 'accessing' }
CpNodeJSHttpServer >> headersTimeout: anInteger [

	"Limit the amount of time (milliseconds) the parser will wait to receive the complete HTTP headers.

	If the timeout expires, the server responds with status 408 without forwarding the request
	to the request listener and then closes the connection.

	It must be set to a non-zero value (e.g. 120 seconds) to protect against potential
	Denial-of-Service attacks in case the server is deployed without a reverse proxy in front."

	self propertyAt: #headersTimeout put: anInteger
]

{ #category : 'accessing' }
CpNodeJSHttpServer >> keepAliveTimeout [

	"The number of milliseconds of inactivity a server needs to wait for additional incoming data,
	after it has finished writing the last response, before a socket will be destroyed. If the server
	receives new data before the keep-alive timeout has fired, it will reset the regular inactivity
	timeout, i.e., server.timeout.

	A value of 0 will disable the keep-alive timeout behavior on incoming connections. A value of 0
	makes the http server behave similarly to Node.js versions prior to 8.0.0, which did not have a
	keep-alive timeout.

	The socket timeout logic is set up on connection, so changing this value only affects new
	connections to the server, not any existing connections.
	
	Default: 5000"

	^ self propertyAt: #keepAliveTimeout
]

{ #category : 'accessing' }
CpNodeJSHttpServer >> keepAliveTimeout: anInteger [

	"The number of milliseconds of inactivity a server needs to wait for additional incoming data,
	after it has finished writing the last response, before a socket will be destroyed. If the server
	receives new data before the keep-alive timeout has fired, it will reset the regular inactivity
	timeout, i.e., server.timeout.

	A value of 0 will disable the keep-alive timeout behavior on incoming connections. A value of 0
	makes the http server behave similarly to Node.js versions prior to 8.0.0, which did not have a
	keep-alive timeout.

	The socket timeout logic is set up on connection, so changing this value only affects new
	connections to the server, not any existing connections.
	
	Default: 5000"

	self propertyAt: #keepAliveTimeout put: anInteger
]

{ #category : 'accessing' }
CpNodeJSHttpServer >> maxHeadersCount [

	"Limits maximum incoming headers count. If set to 0, no limit will be applied.
	Default: 2000"

	^ self propertyAt: #maxHeadersCount
]

{ #category : 'accessing' }
CpNodeJSHttpServer >> maxHeadersCount: anInteger [

	"Limits maximum incoming headers count. If set to 0, no limit will be applied.
	Default: 2000"

	self propertyAt: #maxHeadersCount put: anInteger
]

{ #category : 'accessing' }
CpNodeJSHttpServer >> maxRequestsPerSocket [

	"The maximum number of requests socket can handle before closing keep alive connection.

	A value of 0 will disable the limit.

	When the limit is reached it will set the Connection header value to close, but will not actually
	close the connection, subsequent requests sent after the limit is reached will get
	'503 Service Unavailable' as a response.
	
	Default: 0 (no limit)"

	^ self propertyAt: #maxRequestsPerSocket
]

{ #category : 'accessing' }
CpNodeJSHttpServer >> maxRequestsPerSocket: anInteger [

	"The maximum number of requests socket can handle before closing keep alive connection.

	A value of 0 will disable the limit.

	When the limit is reached it will set the Connection header value to close, but will not actually
	close the connection, subsequent requests sent after the limit is reached will get
	'503 Service Unavailable' as a response.
	
	Default: 0 (no limit)"

	self propertyAt: #maxRequestsPerSocket put: anInteger
]

{ #category : 'event handling' }
CpNodeJSHttpServer >> onCheckContinueDo: aBlock [

	"Emitted each time a request with an 'HTTP Expect: 100-continue' is received. If this event is not
	listened for, the server will automatically respond with a '100 Continue' as appropriate.

	Handling this event involves calling response.writeContinue() if the client should continue to
	send the request body, or generating an appropriate HTTP response (e.g. 400 Bad Request) if
	the client should not continue to send the request body.

	When this event is emitted and handled, the 'request' event will not be emitted.

	The specified Block will be evaluated with:
		request <http.IncomingMessage>
		response <http.ServerResponse>"

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addEventListener: #checkContinue handler: aBlock
]

{ #category : 'event handling' }
CpNodeJSHttpServer >> onCheckExpectationDo: aBlock [

	"Emitted each time a request with an 'HTTP Expect' header is received, where the value is not
	'100-continue'. If this event is not listened for, the server will automatically respond with
	a '417 Expectation Failed' as appropriate.

	When this event is emitted and handled, the 'request' event will not be emitted.

	The specified Block will be evaluated with:
		request <http.IncomingMessage>
		response <http.ServerResponse>"

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addEventListener: #checkExpectation handler: aBlock
]

{ #category : 'event handling' }
CpNodeJSHttpServer >> onClientErrorDo: aBlock [

	"If a client connection emits an 'error' event, it will be forwarded here. Listener of this
	event is responsible for closing/destroying the underlying socket. For example, one may wish
	to more gracefully close the socket with a custom HTTP response instead of abruptly severing
	the connection. The socket must be closed or destroyed before the listener ends.

	This event is guaranteed to be passed an instance of the <net.Socket> class, a subclass of
	<stream.Duplex>, unless the user specifies a socket type other than <net.Socket>.

	Default behavior is to try close the socket with a HTTP '400 Bad Request', or a HTTP
	'431 Request Header Fields Too Large' in the case of a HPE_HEADER_OVERFLOW error. If the
	socket is not writable or headers of the current attached http.ServerResponse has been sent,
	it is immediately destroyed.

	The specified Block will be evaluated with:
		exception <Error>
		socket <net.Socket>"

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addEventListener: #clientError handler: aBlock
]

{ #category : 'event handling' }
CpNodeJSHttpServer >> onConnectDo: aBlock [

	"Emitted each time a client requests an HTTP CONNECT method. If this event is not listened for,
	then clients requesting a CONNECT method will have their connections closed.

	This event is guaranteed to be passed an instance of the <net.Socket> class, a subclass of
	<stream.Duplex>, unless the user specifies a socket type other than <net.Socket>.

	After this event is emitted, the request's socket will not have a 'data' event listener, meaning
	it will need to be bound in order to handle data sent to the server on that socket.

	The specified Block will be evaluated with:
		request <http.IncomingMessage> Arguments for the HTTP request, as it is in the 'request' event
		socket <net.Socket> Network socket between the server and client
		head <Buffer> The first packet of the tunneling stream (may be empty)"

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addEventListener: #connect handler: aBlock
]

{ #category : 'event handling' }
CpNodeJSHttpServer >> onDropRequestDo: aBlock [

	"When the number of requests on a socket reaches the threshold of server.maxRequestsPerSocket,
	the server will drop new requests and emit 'dropRequest' event instead, then send 503 to client.

	The specified Block will be evaluated with:
		request <http.IncomingMessage> Arguments for the HTTP request, as it is in the 'request' event
		socket <net.Socket> Network socket between the server and client"

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addEventListener: #dropRequest handler: aBlock
]

{ #category : 'event handling' }
CpNodeJSHttpServer >> onRequestDo: aBlock [

	"Emitted each time there is a request. There may be multiple requests per connection (in the case of
	HTTP Keep-Alive connections).

	The specified Block will be evaluated with:
		request <http.IncomingMessage> Arguments for the HTTP request, as it is in the 'request' event
		response <http.ServerResponse> Network socket between the server and client"

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addEventListener: #request handler: aBlock
]

{ #category : 'event handling' }
CpNodeJSHttpServer >> onUpgradeDo: aBlock [

	"Emitted each time a client requests an HTTP upgrade. Listening to this event is optional and
	clients cannot insist on a protocol change.

	After this event is emitted, the request's socket will not have a 'data' event listener, meaning
	it will need to be bound in order to handle data sent to the server on that socket.

	This event is guaranteed to be passed an instance of the <net.Socket> class, a subclass of
	<stream.Duplex>, unless the user specifies a socket type other than <net.Socket>.

	The specified Block will be evaluated with:
		request <http.IncomingMessage> Arguments for the HTTP request, as it is in the 'request' event
		socket <net.Socket> Network socket between the server and client
		head <Buffer> The first packet of the tunneling stream (may be empty)"

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addEventListener: #upgrade handler: aBlock
]

{ #category : 'event handling' }
CpNodeJSHttpServer >> removeCheckContinueHandler: aFunction [

	"Remove an earlier installed event listener
	(using the handler which was answered during installation)"

	self removeEventListener: #checkContinue handler: aFunction
]

{ #category : 'event handling' }
CpNodeJSHttpServer >> removeCheckExpectationHandler: aFunction [

	"Remove an earlier installed event listener
	(using the handler which was answered during installation)"

	self removeEventListener: #checkExpectation handler: aFunction
]

{ #category : 'event handling' }
CpNodeJSHttpServer >> removeClientErrorHandler: aFunction [

	"Remove an earlier installed event listener
	(using the handler which was answered during installation)"

	self removeEventListener: #clientError handler: aFunction
]

{ #category : 'event handling' }
CpNodeJSHttpServer >> removeConnectHandler: aFunction [

	"Remove an earlier installed event listener
	(using the handler which was answered during installation)"

	self removeEventListener: #connect handler: aFunction
]

{ #category : 'event handling' }
CpNodeJSHttpServer >> removeDropRequestHandler: aFunction [

	"Remove an earlier installed event listener
	(using the handler which was answered during installation)"

	self removeEventListener: #dropRequest handler: aFunction
]

{ #category : 'event handling' }
CpNodeJSHttpServer >> removeRequestHandler: aFunction [

	"Remove an earlier installed event listener
	(using the handler which was answered during installation)"

	self removeEventListener: #request handler: aFunction
]

{ #category : 'event handling' }
CpNodeJSHttpServer >> removeUpgradeHandler: aFunction [

	"Remove an earlier installed event listener
	(using the handler which was answered during installation)"

	self removeEventListener: #upgrade handler: aFunction
]

{ #category : 'accessing' }
CpNodeJSHttpServer >> requestTimeout [

	"Sets the timeout value in milliseconds for receiving the entire request from the client.

	If the timeout expires, the server responds with status 408 without forwarding the request to the request listener and then closes the connection.

	It must be set to a non-zero value (e.g. 120 seconds) to protect against potential Denial-of-Service attacks in case the server is deployed without a reverse proxy in front.
	Default: 300000"

	^ self propertyAt: #requestTimeout
]

{ #category : 'accessing' }
CpNodeJSHttpServer >> requestTimeout: anInteger [

	"Sets the timeout value in milliseconds for receiving the entire request from the client.

	If the timeout expires, the server responds with status 408 without forwarding the request to the request listener and then closes the connection.

	It must be set to a non-zero value (e.g. 120 seconds) to protect against potential Denial-of-Service attacks in case the server is deployed without a reverse proxy in front.
	Default: 300000"

	self propertyAt: #requestTimeout put: anInteger
]

{ #category : 'accessing' }
CpNodeJSHttpServer >> setTimeout: anInteger [

	self setTimeout: anInteger thenDo: nil
]

{ #category : 'accessing' }
CpNodeJSHttpServer >> setTimeout: anInteger thenDo: aBlock [

	"Sets the timeout value (milliseconds) for sockets, and emits a 'timeout' event on the Server
	object, passing the socket as an argument, if a timeout occurs.

	If there is a 'timeout' event listener on the Server object, then it will be called with the
	timed-out socket as an argument.

	By default, the Server does not timeout sockets. However, if a callback is assigned to the
	Server's 'timeout' event, timeouts must be handled explicitly.

	Use 0 for no timeout."

	self apply: #setTimeout withArguments: { anInteger . aBlock }
]

{ #category : 'accessing' }
CpNodeJSHttpServer >> timeout [

	"The number of milliseconds of inactivity before a socket is presumed to have timed out.

	A value of 0 will disable the timeout behavior on incoming connections.

	The socket timeout logic is set up on connection, so changing this value only affects new
	connections to the server, not any existing connections.
	
	Default: 0 (no timeout)"

	^ self propertyAt: #timeout
]

{ #category : 'accessing' }
CpNodeJSHttpServer >> timeout: anInteger [

	"The number of milliseconds of inactivity before a socket is presumed to have timed out.

	A value of 0 will disable the timeout behavior on incoming connections.

	The socket timeout logic is set up on connection, so changing this value only affects new
	connections to the server, not any existing connections.
	
	Default: 0 (no timeout)"

	self propertyAt: #timeout put: anInteger
]
