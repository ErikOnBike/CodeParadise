"
I am an SMTP Transport (definition).

See https://nodemailer.com/smtp/
"
Class {
	#name : #CpNodeJSNodemailerSmtpTransport,
	#superclass : #CpNodeJSNodemailerTransport,
	#category : #'CodeParadise-NodeJS-Nodemailer-Support'
}

{ #category : #accessing }
CpNodeJSNodemailerSmtpTransport >> authMethod [

	"defines preferred authentication method, defaults to ‘PLAIN’"

	^ options at: #authMethod
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpTransport >> authMethod: aString [

	"defines preferred authentication method, defaults to ‘PLAIN’"

	options at: #authMethod put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpTransport >> authPassword [

	"is the password for the user if normal login is used"

	^ (options at: #auth)
		ifNotNil: [ :auth | auth at: #pass ]
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpTransport >> authPassword: aString [

	"is the password for the user if normal login is used"

	(options at: #auth ifAbsentPut: [ CpJsonObject new ])
		at: #pass put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpTransport >> authType [

	"indicates the authetication type, defaults to ‘login’, other option is ‘oauth2’"

	^ (options at: #auth)
		ifNotNil: [ :auth | auth at: #type ]
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpTransport >> authType: aString [

	"indicates the authetication type, defaults to ‘login’, other option is ‘oauth2’"

	(options at: #auth ifAbsentPut: [ CpJsonObject new ])
		at: #type put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpTransport >> authUser [

	"is the username"

	^ (options at: #auth)
		ifNotNil: [ :auth | auth at: #user ]
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpTransport >> authUser: aString [

	"is the username"

	(options at: #auth ifAbsentPut: [ CpJsonObject new ])
		at: #user put: aString
]

{ #category : #'accessing - connection' }
CpNodeJSNodemailerSmtpTransport >> connectionTimeout [

	"how many milliseconds to wait for the connection to establish (default is 2 minutes)"

	^ options at: #connectionTimeout
]

{ #category : #'accessing - connection' }
CpNodeJSNodemailerSmtpTransport >> connectionTimeout: anInteger [

	"how many milliseconds to wait for the connection to establish (default is 2 minutes)"

	options at: #connectionTimeout put: anInteger
]

{ #category : #'accessing - debug' }
CpNodeJSNodemailerSmtpTransport >> debug [

	"if set to true, then logs SMTP traffic, otherwise logs only transaction events"

	^ options at: #debug
]

{ #category : #'accessing - debug' }
CpNodeJSNodemailerSmtpTransport >> debug: aBoolean [

	"if set to true, then logs SMTP traffic, otherwise logs only transaction events"

	options at: #debug put: aBoolean
]

{ #category : #'accessing - connection' }
CpNodeJSNodemailerSmtpTransport >> dnsTimeout [

	"Time to wait in ms for the DNS requests to be resolved (defaults to 30 seconds)"

	^ options at: #dnsTimeout
]

{ #category : #'accessing - connection' }
CpNodeJSNodemailerSmtpTransport >> dnsTimeout: anInteger [

	"Time to wait in ms for the DNS requests to be resolved (defaults to 30 seconds)"

	options at: #dnsTimeout put: anInteger
]

{ #category : #'accessing - connection' }
CpNodeJSNodemailerSmtpTransport >> greetingTimeout [

	"how many milliseconds to wait for the greeting after connection is established (default is 30 seconds)"

	^ options at: #greetingTimeout
]

{ #category : #'accessing - connection' }
CpNodeJSNodemailerSmtpTransport >> greetingTimeout: anInteger [

	"how many milliseconds to wait for the greeting after connection is established (default is 30 seconds)"

	options at: #greetingTimeout put: anInteger
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpTransport >> host [

	"is the hostname or IP address to connect to (defaults to ‘localhost’)"

	^ options at: #host
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpTransport >> host: aString [

	"is the hostname or IP address to connect to (defaults to ‘localhost’)"

	options at: #host put: aString
]

{ #category : #'accessing - tls' }
CpNodeJSNodemailerSmtpTransport >> ignoreTLS [

	"if this is true and secure is false then TLS is not used even if the server supports STARTTLS extension"

	^ options at: #ignoreTLS
]

{ #category : #'accessing - tls' }
CpNodeJSNodemailerSmtpTransport >> ignoreTLS: aBoolean [

	"if this is true and secure is false then TLS is not used even if the server supports STARTTLS extension"

	options at: #ignoreTLS put: aBoolean
]

{ #category : #'accessing - connection' }
CpNodeJSNodemailerSmtpTransport >> localAddress [

	"is the local interface to bind to for network connections"

	^ options at: #localAddress
]

{ #category : #'accessing - connection' }
CpNodeJSNodemailerSmtpTransport >> localAddress: aString [

	"is the local interface to bind to for network connections"

	options at: #localAddress put: aString
]

{ #category : #'accessing - debug' }
CpNodeJSNodemailerSmtpTransport >> logger [

	"optional bunyan compatible logger instance. If set to true then logs to console. If value is not set or is false then nothing is logged"

	^ options at: #logger
]

{ #category : #'accessing - debug' }
CpNodeJSNodemailerSmtpTransport >> logger: aLoggerOrBoolean [

	"optional bunyan compatible logger instance. If set to true then logs to console. If value is not set or is false then nothing is logged"

	options at: #logger put: aLoggerOrBoolean
]

{ #category : #'accessing - pool' }
CpNodeJSNodemailerSmtpTransport >> maxConnections [

	"is the count of maximum simultaneous connections to make against the SMTP server (defaults to 5)"

	^ options at: #maxConnections
]

{ #category : #'accessing - pool' }
CpNodeJSNodemailerSmtpTransport >> maxConnections: anInteger [

	"is the count of maximum simultaneous connections to make against the SMTP server (defaults to 5)"

	options at: #maxConnections put: anInteger
]

{ #category : #'accessing - pool' }
CpNodeJSNodemailerSmtpTransport >> maxMessages [

	"limits the message count to be sent using a single connection (defaults to 100). After maxMessages is reached the connection is dropped and a new one is created for the following messages"

	^ options at: #maxMessages
]

{ #category : #'accessing - pool' }
CpNodeJSNodemailerSmtpTransport >> maxMessages: anInteger [

	"limits the message count to be sent using a single connection (defaults to 100). After maxMessages is reached the connection is dropped and a new one is created for the following messages"

	options at: #maxMessages put: anInteger
]

{ #category : #'accessing - connection' }
CpNodeJSNodemailerSmtpTransport >> name [

	"optional hostname of the client, used for identifying to the server, defaults to hostname of the machine"

	^ options at: #name
]

{ #category : #'accessing - connection' }
CpNodeJSNodemailerSmtpTransport >> name: aString [

	"optional hostname of the client, used for identifying to the server, defaults to hostname of the machine"

	options at: #name put: aString
]

{ #category : #'accessing - pool' }
CpNodeJSNodemailerSmtpTransport >> pool [

	"set to true to use pooled connections (defaults to false) instead of creating a new connection for every email"

	^ options at: #pool
]

{ #category : #'accessing - pool' }
CpNodeJSNodemailerSmtpTransport >> pool: aBoolean [

	"set to true to use pooled connections (defaults to false) instead of creating a new connection for every email"

	options at: #pool put: aBoolean
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpTransport >> port [

	"is the port to connect to (defaults to 587 if is secure is false or 465 if true)"

	^ options at: #port
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpTransport >> port: anInteger [

	"is the port to connect to (defaults to 587 if is secure is false or 465 if true)"

	options at: #port put: anInteger
]

{ #category : #'accessing - proxy' }
CpNodeJSNodemailerSmtpTransport >> proxy [

	"is a proxy URL"

	^ options at: #proxy
]

{ #category : #'accessing - proxy' }
CpNodeJSNodemailerSmtpTransport >> proxy: aString [

	"is a proxy URL"

	options at: #proxy put: aString
]

{ #category : #'accessing - tls' }
CpNodeJSNodemailerSmtpTransport >> requireTLS [

	"if this is true and secure is false then Nodemailer tries to use STARTTLS even if the server does not advertise support for it. If the connection can not be encrypted then message is not sent"

	^ options at: #requireTLS
]

{ #category : #'accessing - tls' }
CpNodeJSNodemailerSmtpTransport >> requireTLS: aBoolean [

	"if this is true and secure is false then Nodemailer tries to use STARTTLS even if the server does not advertise support for it. If the connection can not be encrypted then message is not sent"

	options at: #requireTLS put: aBoolean
]

{ #category : #'accessing - tls' }
CpNodeJSNodemailerSmtpTransport >> secure [

	"if true the connection will use TLS when connecting to server. If false (the default) then TLS is used if server supports the STARTTLS extension. In most cases set this value to true if you are connecting to port 465. For port 587 or 25 keep it false"

	^ options at: #secure
]

{ #category : #'accessing - tls' }
CpNodeJSNodemailerSmtpTransport >> secure: aBoolean [

	"if true the connection will use TLS when connecting to server. If false (the default) then TLS is used if server supports the STARTTLS extension. In most cases set this value to true if you are connecting to port 465. For port 587 or 25 keep it false"

	options at: #secure put: aBoolean
]

{ #category : #'accessing - connection' }
CpNodeJSNodemailerSmtpTransport >> socketTimeout [

	"how many milliseconds of inactivity to allow (default is 10 minutes)"

	^ options at: #socketTimeout
]

{ #category : #'accessing - connection' }
CpNodeJSNodemailerSmtpTransport >> socketTimeout: anInteger [

	"how many milliseconds of inactivity to allow (default is 10 minutes)"

	options at: #socketTimeout put: anInteger
]

{ #category : #'accessing - tls' }
CpNodeJSNodemailerSmtpTransport >> tls [

	"defines additional node.js TLSSocket options to be passed to the socket constructor, eg. {rejectUnauthorized: true}."

	^ options at: #tls
]

{ #category : #'accessing - tls' }
CpNodeJSNodemailerSmtpTransport >> tls: aDictionary [

	"defines additional node.js TLSSocket options to be passed to the socket constructor, eg. {rejectUnauthorized: true}."

	options at: #tls put: aDictionary
]

{ #category : #'accessing - tls' }
CpNodeJSNodemailerSmtpTransport >> tlsServername [

	"is optional hostname for TLS validation if host was set to an IP address"

	^ (options at: #tls)
		ifNotNil: [ :tls | tls at: #servername ]
]

{ #category : #'accessing - tls' }
CpNodeJSNodemailerSmtpTransport >> tlsServername: aString [

	"is optional hostname for TLS validation if host was set to an IP address"

	(options at: #tls ifAbsentPut: [ CpJsonObject new ])
		at: #servername put: aString
]
