Class {
	#name : #CynRestResponseError,
	#superclass : #Error,
	#instVars : [
		'statusCode'
	],
	#category : #'CodeParadise-Canyon-App-Support'
}

{ #category : #'accessing - status codes' }
CynRestResponseError class >> codeBadRequest [

	^ 400
]

{ #category : #'accessing - status codes' }
CynRestResponseError class >> codeConflict [

	^ 409
]

{ #category : #'accessing - status codes' }
CynRestResponseError class >> codeForbidden [

	^ 403
]

{ #category : #'accessing - status codes' }
CynRestResponseError class >> codeGone [

	^ 410
]

{ #category : #'accessing - status codes' }
CynRestResponseError class >> codeInternalServerError [

	^ 500
]

{ #category : #'accessing - status codes' }
CynRestResponseError class >> codeMethodNotAllowed [

	^ 405
]

{ #category : #'accessing - status codes' }
CynRestResponseError class >> codeNotFound [

	^ 404
]

{ #category : #'accessing - status codes' }
CynRestResponseError class >> codeUnauthorized [

	^ 401
]

{ #category : #'instance creation' }
CynRestResponseError class >> messageText: aString statusCode: anInteger [

	"Answer an instance of the receiver with the specified text and status code"

	^ (self statusCode: anInteger)
		messageText: aString ;
		yourself
]

{ #category : #'instance creation' }
CynRestResponseError class >> new [

	self errorNewReplacedBy: #statusCode:
]

{ #category : #'instance creation' }
CynRestResponseError class >> signal: aString withStatusCode: anInteger [

	(self statusCode: anInteger)
		signal: aString
]

{ #category : #'instance creation' }
CynRestResponseError class >> statusCode: anInteger [

	"Answer an instance of the receiver with the specified status code"

	^ self basicNew
		initializeWithStatusCode: anInteger ;
		yourself
]

{ #category : #initialization }
CynRestResponseError >> initializeWithStatusCode: anInteger [

	self initialize.

	statusCode := anInteger
]

{ #category : #printing }
CynRestResponseError >> printOn: aStream [

	aStream
		nextPutAll: self class name ;
		space ;
		print: self statusCode ;
		nextPutAll: ' - ' ;
		print: self messageText trim
]

{ #category : #accessing }
CynRestResponseError >> statusCode [

	^ statusCode
]
