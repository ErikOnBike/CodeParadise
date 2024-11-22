"
I am the Nodemailer Transporter. I am responsible for sending mails.

See https://nodemailer.com/transports/
"
Class {
	#name : #CpNodeJSNodemailerTransporter,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-NodeJS-Nodemailer-Core'
}

{ #category : #'instance creation' }
CpNodeJSNodemailerTransporter class >> createTransport: aTransportOptions [

	^ self createTransport: aTransportOptions withDefaults: Dictionary new
]

{ #category : #'instance creation' }
CpNodeJSNodemailerTransporter class >> createTransport: aTransportOptions withDefaults: aMessage [

	"Create and answer an instance of a Transporter.

	aTransportOptions: transport is the transport configuration object, connection url or a transport plugin instance
	aMessage: defaults is an object that defines default values for mail options"

	^ self module require
		apply: #createTransport withArguments: { aTransportOptions asDictionary . aMessage asDictionary } resultAs: self
]

{ #category : #accessing }
CpNodeJSNodemailerTransporter class >> module [

	^ CpNodeJSNodemailer
]

{ #category : #'operations - pool' }
CpNodeJSNodemailerTransporter >> close [

	"If transporter uses pooling then connections are kept open even if there is nothing to be sent. Connections that idle for longer than the socketTimeout will be closed automatically and reopened once there’s more mail to send. You can also use transporter.close() to clean up all connections."

	self apply: #close
]

{ #category : #'operations - pool' }
CpNodeJSNodemailerTransporter >> isIdle [

	"Returns true if there are available connection slots"

	^ self apply: #isIdle
]

{ #category : #'operations - pool' }
CpNodeJSNodemailerTransporter >> onIdle: aBlock [

	"Evaluate the specified Block when the connection pool has a free slot.

	See also: https://nodemailer.com/smtp/pooled/"

	self apply: #on withArguments: { #idle . CpJavaScriptFunction wrap: aBlock }
]

{ #category : #'operations - proxy' }
CpNodeJSNodemailerTransporter >> proxyHandler: aBlock [

	"Set the proxy handler to the specified Block.
	The Block should accept 3 arguments and answer a proxied socket.

	handler is the function to run to create a proxied socket. It gets the following arguments:
		proxy is the proxy url in a parsed form
		options is transport configuration object
		callback is the function to return the socket

	See also: https://nodemailer.com/smtp/proxies/"

	self apply: #set withArguments: { #proxy_handler_myproxy . CpJavaScriptFunction wrap: aBlock }
]

{ #category : #operations }
CpNodeJSNodemailerTransporter >> sendMail: aMessage [

	"Send the specified Message.

	See also: https://nodemailer.com/usage/#sending-mail"

	self sendMail: aMessage thenDo: [ "Having an empty Block as callback handler here, preventS the creation of a Promise" ]
]

{ #category : #operations }
CpNodeJSNodemailerTransporter >> sendMail: aMessage thenDo: aBlock [

	"Send the specified Message and evaluate the specified Block once done.

	The Block should accept two arguments:
		err is the error object if message failed
		info includes the result, the exact format depends on the transport mechanism used
			info.messageId most transports should return the final Message-Id value used with this property
			info.envelope includes the envelope object for the message
			info.accepted is an array returned by SMTP transports (includes recipient addresses that were accepted by the server)
			info.rejected is an array returned by SMTP transports (includes recipient addresses that were rejected by the server)
			info.pending is an array returned by Direct SMTP transport. Includes recipient addresses that were temporarily rejected together with the server response
			info.response is a string returned by SMTP transports and includes the last SMTP response from the server

	See also: https://nodemailer.com/usage/#sending-mail"

	self apply: #sendMail withArguments: { aMessage asDictionary . CpJavaScriptFunction wrap: [ :err :info | aBlock value: err value: (CpNodeJSNodemailerResultInfo from: info) ] }
]

{ #category : #'operations - smtp' }
CpNodeJSNodemailerTransporter >> verify: aBlock [

	"You can verify your SMTP configuration with verify.
	The specified Block is evaluated with two arguments: error and success.
	The first argument 'error' will be nil if no error is found.

	Be aware though that this call only tests connection and authentication,
	but it does not check if the service allows you to use a specific
	envelope “From” address or not."

	self apply: #verify withArguments: { CpJavaScriptFunction wrap: aBlock }
]
