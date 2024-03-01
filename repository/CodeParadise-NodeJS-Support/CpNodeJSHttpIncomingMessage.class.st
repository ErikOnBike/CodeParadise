Class {
	#name : #CpNodeJSHttpIncomingMessage,
	#superclass : #CpNodeJSStreamReadable,
	#category : #'CodeParadise-NodeJS-Support-Http'
}

{ #category : #accessing }
CpNodeJSHttpIncomingMessage class >> module [

	"Answer the module the receiver is part of"

	^ CpNodeJSHttp
]

{ #category : #accessing }
CpNodeJSHttpIncomingMessage >> complete [

	"The message.complete property will be true if a complete HTTP message has been received and successfully parsed."

	^ self propertyAt: #complete
]

{ #category : #accessing }
CpNodeJSHttpIncomingMessage >> headers [

	"The request/response headers object.

	Key-value pairs of header names and values. Header names are lower-cased.

	Duplicates in raw headers are handled in the following ways, depending on the header name:

	- Duplicates of age, authorization, content-length, content-type, etag, expires, from, host,
	  if-modified-since, if-unmodified-since, last-modified, location, max-forwards, proxy-authorization,
	  referer, retry-after, server, or user-agent are discarded. To allow duplicate values of the headers
	  listed above to be joined, use the option joinDuplicateHeaders in http.request() and
	  http.createServer(). See RFC 9110 Section 5.3 for more information.
	- set-cookie is always an array. Duplicates are added to the array.
	- For duplicate cookie headers, the values are joined together with ; .
	- For all other headers, the values are joined together with , ."

	^ self propertyAt: #headers
]

{ #category : #accessing }
CpNodeJSHttpIncomingMessage >> headersDistinct [

	"Similar to message.headers, but there is no join logic and the values are always arrays of strings, even for headers received just once."

	^ self propertyAt: #headersDistinct
]

{ #category : #accessing }
CpNodeJSHttpIncomingMessage >> httpVersion [

	"In case of server request, the HTTP version sent by the client. In the case of client response, the HTTP version of the connected-to server. Probably either '1.1' or '1.0'.

	Also message.httpVersionMajor is the first integer and message.httpVersionMinor is the second."

	^ self propertyAt: #httpVersion
]

{ #category : #accessing }
CpNodeJSHttpIncomingMessage >> method [

	"Only valid for request obtained from http.Server.

	The request method as a string. Read only. Examples: 'GET', 'DELETE'."

	^ self propertyAt: #method
]

{ #category : #accessing }
CpNodeJSHttpIncomingMessage >> rawHeaders [

	"The raw request/response headers list exactly as they were received.

	The keys and values are in the same list. It is not a list of tuples. So, the even-numbered offsets are key values, and the odd-numbered offsets are the associated values.

	Header names are not lowercased, and duplicates are not merged."

	^ self propertyAt: #rawHeaders
]

{ #category : #accessing }
CpNodeJSHttpIncomingMessage >> rawTrailers [

	"The raw request/response trailer keys and values exactly as they were received. Only populated at the 'end' event."

	^ self propertyAt: #rawTrailers
]

{ #category : #accessing }
CpNodeJSHttpIncomingMessage >> setTimeout: anInteger [

	self setTimeout: anInteger thenDo: nil
]

{ #category : #accessing }
CpNodeJSHttpIncomingMessage >> setTimeout: anInteger thenDo: aBlock [

	"Calls message.socket.setTimeout(msecs, callback)."

	self apply: #setTimeout withArguments: { anInteger . aBlock }
]

{ #category : #accessing }
CpNodeJSHttpIncomingMessage >> socket [

	"The net.Socket object associated with the connection.

	With HTTPS support, use request.socket.getPeerCertificate() to obtain the client's authentication details.

	This property is guaranteed to be an instance of the <net.Socket> class, a subclass of <stream.Duplex>, unless the user specified a socket type other than <net.Socket> or internally nulled."

	^ self propertyAt: #socket
]

{ #category : #accessing }
CpNodeJSHttpIncomingMessage >> statusCode [

	"Only valid for response obtained from http.ClientRequest.

	The 3-digit HTTP response status code. E.G. 404."

	^ self propertyAt: #statusCode
]

{ #category : #accessing }
CpNodeJSHttpIncomingMessage >> statusMessage [

	"Only valid for response obtained from http.ClientRequest.

	The HTTP response status message (reason phrase). E.G. OK or Internal Server Error."

	^ self propertyAt: #statusMessage
]

{ #category : #accessing }
CpNodeJSHttpIncomingMessage >> trailers [

	"The request/response trailers object. Only populated at the 'end' event."

	^ self propertyAt: #trailers
]

{ #category : #accessing }
CpNodeJSHttpIncomingMessage >> trailersDistinct [

	"Similar to message.trailers, but there is no join logic and the values are always arrays of strings, even for headers received just once. Only populated at the 'end' event."

	^ self propertyAt: #trailersDistinct
]

{ #category : #accessing }
CpNodeJSHttpIncomingMessage >> url [

	"Only valid for request obtained from http.Server.

	Request URL string. This contains only the URL that is present in the actual HTTP request."

	^ self propertyAt: #url
]
