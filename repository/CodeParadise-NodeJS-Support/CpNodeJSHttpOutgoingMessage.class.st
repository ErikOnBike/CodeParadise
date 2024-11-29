Class {
	#name : #CpNodeJSHttpOutgoingMessage,
	#superclass : #CpNodeJSStreamWritable,
	#category : #'CodeParadise-NodeJS-Support-Http'
}

{ #category : #accessing }
CpNodeJSHttpOutgoingMessage class >> module [

	"Answer the module the receiver is part of"

	^ CpNodeJSHttp
]

{ #category : #accessing }
CpNodeJSHttpOutgoingMessage >> addTrailers: aDictionary [

	"Adds HTTP trailers (headers but at the end of the message) to the message.

	Trailers will only be emitted if the message is chunked encoded. If not, the trailers will be silently discarded.

	HTTP requires the Trailer header to be sent to emit trailers, with a list of header field names in its value"

	self apply: #addTrailers withArguments: { aDictionary }
]

{ #category : #accessing }
CpNodeJSHttpOutgoingMessage >> appendHeaderWithName: aString value: anObject [

	"Append a single header value for the header object.

	If the value is an array, this is equivalent of calling this method multiple times.

	If there were no previous value for the header, this is equivalent of calling outgoingMessage.setHeader(name, value).

	Depending of the value of options.uniqueHeaders when the client request or the server were created, this will end up in the header being sent multiple times or a single time with values joined using ; .

	Value should be either String or Array of Strings"

	self apply: #appendHeader withArguments: { aString . anObject }
]

{ #category : #operations }
CpNodeJSHttpOutgoingMessage >> flushHeaders [

	"Flushes the message headers.

	For efficiency reason, Node.js normally buffers the message headers until outgoingMessage.end()
	is called or the first chunk of message data is written. It then tries to pack the headers and
	data into a single TCP packet.

	It is usually desired (it saves a TCP round-trip), but not when the first data is not sent until
	possibly much later. outgoingMessage.flushHeaders() bypasses the optimization and kickstarts the
	message."

	^ self apply: #flushHeaders
]

{ #category : #accessing }
CpNodeJSHttpOutgoingMessage >> getHeaderNames [

	"Returns an array containing the unique names of the current outgoing headers. All names are lowercase."

	^ self apply: #getHeaderNames
]

{ #category : #accessing }
CpNodeJSHttpOutgoingMessage >> getHeaderWithName: aString [

	"Gets the value of the HTTP header with the given name. If that header is not set, the returned value will be undefined."

	^ self apply: #getHeader withArguments: { aString }
]

{ #category : #accessing }
CpNodeJSHttpOutgoingMessage >> getHeaders [

	"Returns a shallow copy of the current outgoing headers. Since a shallow copy is used, array values may
	be mutated without additional calls to various header-related HTTP module methods. The keys of the
	returned object are the header names and the values are the respective header values. All header names
	are lowercase.

	The object returned by the outgoingMessage.getHeaders() method does not prototypically inherit from the
	JavaScript Object. This means that typical Object methods such as obj.toString(), obj.hasOwnProperty(),
	and others are not defined and will not work."

	^ self apply: #getHeaders
]

{ #category : #accessing }
CpNodeJSHttpOutgoingMessage >> hasHeaderWithName: aString [

	"Returns true if the header identified by name is currently set in the outgoing headers. The header name is case-insensitive."

	^ self apply: #hasHeader withArguments: { aString }
]

{ #category : #accessing }
CpNodeJSHttpOutgoingMessage >> headersSent [

	"Read-only. true if the headers were sent, otherwise false."

	^ self propertyAt: #headersSent
]

{ #category : #accessing }
CpNodeJSHttpOutgoingMessage >> removeHeaderWithName: aString [

	"Removes a header that is queued for implicit sending."

	self apply: #removeHeader withArguments: { aString }
]

{ #category : #accessing }
CpNodeJSHttpOutgoingMessage >> setHeaderWithName: aString value: anObject [

	"Sets a single header value. If the header already exists in the to-be-sent headers, its value will be replaced. Use an array of strings to send multiple headers with the same name.

	Value should be either String or Array of Strings"

	self apply: #setHeader withArguments: { aString . anObject }
]

{ #category : #accessing }
CpNodeJSHttpOutgoingMessage >> setHeaders: aHeaders [

	"Sets multiple header values for implicit headers. headers must be an instance of Headers or Map, if a header already exists in the to-be-sent headers, its value will be replaced.

	When headers have been set with outgoingMessage.setHeaders(), they will be merged with any headers passed to response.writeHead(), with the headers passed to response.writeHead() given precedence."

	self apply: #setHeaders withArguments: { aHeaders }
]

{ #category : #accessing }
CpNodeJSHttpOutgoingMessage >> setTimeout: anInteger [

	self setTimeout: anInteger thenDo: nil
]

{ #category : #accessing }
CpNodeJSHttpOutgoingMessage >> setTimeout: anInteger thenDo: aBlock [

	"Once a socket is associated with the message and is connected, socket.setTimeout() will be called with msecs as the first parameter."

	self apply: #setTimeout withArguments: { anInteger . aBlock }
]

{ #category : #accessing }
CpNodeJSHttpOutgoingMessage >> socket [

	"Reference to the underlying socket. Usually, users will not want to access this property.

	After calling outgoingMessage.end(), this property will be nulled."

	^ self propertyAt: #socket
]
