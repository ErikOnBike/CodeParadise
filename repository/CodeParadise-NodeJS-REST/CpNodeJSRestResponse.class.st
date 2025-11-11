Class {
	#name : #CpNodeJSRestResponse,
	#superclass : #Object,
	#instVars : [
		'request',
		'serverResponse'
	],
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #'instance creation' }
CpNodeJSRestResponse class >> new [

	self errorNewReplacedBy: #request:response:
]

{ #category : #'instance creation' }
CpNodeJSRestResponse class >> request: aRestRequest response: aServerResponse [

	"Answer an instance of the receiver with the specified
	REST request and the HTTP ServerResponse"

	^ self basicNew
		initializeWithRequest: aRestRequest response: aServerResponse ;
		yourself
]

{ #category : #writing }
CpNodeJSRestResponse >> end [

	serverResponse end
]

{ #category : #initialization }
CpNodeJSRestResponse >> initializeWithRequest: aRestRequest response: aServerResponse [

	self initialize.

	request := aRestRequest.
	serverResponse := aServerResponse
]

{ #category : #accessing }
CpNodeJSRestResponse >> request [

	^ request
]

{ #category : #writing }
CpNodeJSRestResponse >> setHeaderWithName: aString value: anObject [

	serverResponse setHeaderWithName: aString value: anObject
]

{ #category : #accessing }
CpNodeJSRestResponse >> statusCode [

	^ serverResponse statusCode
]

{ #category : #accessing }
CpNodeJSRestResponse >> statusCode: anInteger [

	serverResponse statusCode: anInteger
]

{ #category : #writing }
CpNodeJSRestResponse >> writableEnded [

	^ serverResponse writableEnded
]

{ #category : #writing }
CpNodeJSRestResponse >> writeChunk: anObject [

	serverResponse writeChunk: anObject
]

{ #category : #writing }
CpNodeJSRestResponse >> writeError: anError [

	"Write the specified Error to the receiver.
	The specified Error can be a CpNodeJSRestError (sub)class or a 'regular' Error instance."

	CpClientEnvironment current
		ifDevelopment: [
			(anError restResponseCode = CpNodeJSRestForbiddenError responseCode or: [ anError restResponseCode = CpNodeJSRestUnauthorizedError responseCode ])
				ifFalse: [ self traceCr: 'Error: ', anError printString ].
			self traceCr: 'Response: ', anError restResponseString ].

	"Prevent error if response already written"
	self writableEnded
		ifTrue: [ ^ self ].

	self
		statusCode: anError restResponseCode ;
		writeChunk: anError restResponseString ;
		end
]
