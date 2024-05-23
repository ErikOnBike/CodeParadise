Class {
	#name : #CpNodeJSRestRequest,
	#superclass : #Object,
	#instVars : [
		'path',
		'incomingMessage'
	],
	#category : #'CodeParadise-NodeJS-REST-Request'
}

{ #category : #'instance creation' }
CpNodeJSRestRequest class >> fromIncomingMessage: anIncomingMessage [

	^ self basicNew
		initializeWithIncomingMessage: anIncomingMessage ;
		yourself
]

{ #category : #accessing }
CpNodeJSRestRequest >> body [

	"Answer the body of the request.

	Implementation:
	Since the incomingMessage is a subclass of readable stream, it represents
	the body itself. Be aware it requires an event mechanism to retrieve the
	content.
	See also CpNodeJSStreamReadable"

	^ incomingMessage
]

{ #category : #accessing }
CpNodeJSRestRequest >> headerAt: aSymbol [

	"Answer the value of the specified header
	or nil if the specified header value does not exist."

	^ incomingMessage headers
		at: aSymbol ifAbsent: [ nil ]
]

{ #category : #initialization }
CpNodeJSRestRequest >> initializeWithIncomingMessage: anIncomingMessage [

	| url |

	self initialize.

	url := CpJavaScriptURL newUrl: anIncomingMessage url base: 'http://localhost'.
	path := CpNodeJSRestPath fromString: url pathname.
	incomingMessage := anIncomingMessage
]

{ #category : #accessing }
CpNodeJSRestRequest >> method [

	^ incomingMessage method
]

{ #category : #accessing }
CpNodeJSRestRequest >> path [

	^ path
]
