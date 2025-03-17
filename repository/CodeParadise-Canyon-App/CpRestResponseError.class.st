Class {
	#name : #CpRestResponseError,
	#superclass : #Error,
	#instVars : [
		'statusCode'
	],
	#category : #'CodeParadise-Canyon-App-Support'
}

{ #category : #'accessing - status codes' }
CpRestResponseError class >> codeBadRequest [

	^ 400
]

{ #category : #'accessing - status codes' }
CpRestResponseError class >> codeConflict [

	^ 409
]

{ #category : #'accessing - status codes' }
CpRestResponseError class >> codeForbidden [

	^ 403
]

{ #category : #'accessing - status codes' }
CpRestResponseError class >> codeGone [

	^ 410
]

{ #category : #'accessing - status codes' }
CpRestResponseError class >> codeInternalServerError [

	^ 500
]

{ #category : #'accessing - status codes' }
CpRestResponseError class >> codeMethodNotAllowed [

	^ 405
]

{ #category : #'accessing - status codes' }
CpRestResponseError class >> codeNotFound [

	^ 404
]

{ #category : #'accessing - status codes' }
CpRestResponseError class >> codeUnauthorized [

	^ 401
]

{ #category : #'instance creation' }
CpRestResponseError class >> new [

	self errorNewReplacedBy: #statusCode:
]

{ #category : #'instance creation' }
CpRestResponseError class >> signal: aString withStatusCode: anInteger [

	(self statusCode: anInteger)
		signal: aString
]

{ #category : #'instance creation' }
CpRestResponseError class >> statusCode: anInteger [

	^ self basicNew
		initializeWithStatusCode: anInteger ;
		yourself
]

{ #category : #initialization }
CpRestResponseError >> initializeWithStatusCode: anInteger [

	self initialize.

	statusCode := anInteger
]

{ #category : #printing }
CpRestResponseError >> printOn: aStream [

	aStream
		nextPutAll: self class name ;
		space ;
		print: self statusCode ;
		nextPutAll: ' - ' ;
		print: self messageText trim
]

{ #category : #accessing }
CpRestResponseError >> statusCode [

	^ statusCode
]
