Class {
	#name : 'CpNodeJSHttp',
	#superclass : 'CpNodeJSBuiltinModule',
	#category : 'CodeParadise-NodeJS-Support-Http',
	#package : 'CodeParadise-NodeJS-Support',
	#tag : 'Http'
}

{ #category : 'operations' }
CpNodeJSHttp >> createServerOn: aBlock [

	^ self createServerOn: aBlock withOptions: nil
]

{ #category : 'operations' }
CpNodeJSHttp >> createServerOn: aBlock withOptions: aDictionary [

	"Returns a new instance of http.Server.

	The specified block should accept two arguments:
		a http.Request
		a http.Response

	The following options can be specified:

	connectionsCheckingInterval <Integer>
		Sets the interval value in milliseconds to check for request and headers timeout in
		incomplete requests. Default: 30000.
	headersTimeout <Integer>
		Sets the timeout value in milliseconds for receiving the complete HTTP headers from
		the client. See server.headersTimeout for more information. Default: 60000.
	highWaterMark <Integer>
		Optionally overrides all sockets' readableHighWaterMark and writableHighWaterMark.
		This affects highWaterMark property of both IncomingMessage and ServerResponse.
		Default: See stream.getDefaultHighWaterMark().
	insecureHTTPParser <Boolean>
		Use an insecure HTTP parser that accepts invalid HTTP headers when true. Using the
		insecure parser should be avoided. See --insecure-http-parser for more information.
		Default: false.
	IncomingMessage <Class>
		Specifies the IncomingMessage class to be used. Useful for extending the original
		IncomingMessage. Default: IncomingMessage.
	joinDuplicateHeaders <Boolean>
		If set to true, this option allows joining the field line values of multiple headers
		in a request with a comma (, ) instead of discarding the duplicates. For more
		information, refer to message.headers. Default: false.
	keepAlive <Boolean>
		If set to true, it enables keep-alive functionality on the socket immediately after
		a new incoming connection is received, similarly on what is done in
		[socket.setKeepAlive([enable][, initialDelay])]
		[socket.setKeepAlive(enable, initialDelay)]. Default: false.
	keepAliveInitialDelay <Integer>
		If set to a positive number, it sets the initial delay before the first keepalive
		probe is sent on an idle socket. Default: 0.
	keepAliveTimeout <Integer>
		The number of milliseconds of inactivity a server needs to wait for additional
		incoming data, after it has finished writing the last response, before a socket will
		be destroyed. See server.keepAliveTimeout for more information. Default: 5000.
	maxHeaderSize <Integer>
		Optionally overrides the value of --max-http-header-size for requests received by this
		server, i.e. the maximum length of request headers in bytes. Default: 16384 (16 KiB).
	noDelay <Boolean>
		If set to true, it disables the use of Nagle's algorithm immediately after a new
		incoming connection is received. Default: true.
	requestTimeout <Integer>
		Sets the timeout value in milliseconds for receiving the entire request from the
		client. See server.requestTimeout for more information. Default: 300000.
	requireHostHeader <Boolean>
		If set to true, it forces the server to respond with a 400 (Bad Request) status code
		to any HTTP/1.1 request message that lacks a Host header (as mandated by the
		specification). Default: true.
	ServerResponse <Class>
		Specifies the ServerResponse class to be used. Useful for extending the original
		ServerResponse. Default: ServerResponse.
	uniqueHeaders <Array>
		A list of response headers that should be sent only once. If the header's value is an
		array, the items will be joined using ; .

	"

	^ self apply: #createServer withArguments: { aDictionary . aBlock } resultAs: CpNodeJSHttpServer
]
