Class {
	#name : #CpNodeJSRestError,
	#superclass : #Error,
	#category : #'CodeParadise-NodeJS-REST-Errors'
}

{ #category : #'instance creation' }
CpNodeJSRestError class >> messageText: aString [

	"Answer an instance of the receiver with the specified message"

	^ self new
		messageText: aString ;
		yourself
]

{ #category : #accessing }
CpNodeJSRestError class >> responseCode [

	^ 500
]

{ #category : #accessing }
CpNodeJSRestError class >> responseString [

	^ 'Internal Server Error'
]

{ #category : #accessing }
CpNodeJSRestError class >> restResponseCode [

	"Answer the REST response code (aka HTTP status code)"

	^ self responseCode
]

{ #category : #accessing }
CpNodeJSRestError class >> restResponseString [

	"Answer the REST response String (matching #responseCode)"

	^ self responseString
]

{ #category : #accessing }
CpNodeJSRestError >> responseCode [

	^ self class responseCode
]

{ #category : #accessing }
CpNodeJSRestError >> restResponseCode [

	"Answer the REST response code (aka HTTP status code).
	This method's name refers to REST more explicitly, to
	prevent a name clash with other extensions."

	^ self responseCode
]

{ #category : #accessing }
CpNodeJSRestError >> restResponseString [

	^ messageText ifEmptyOrNil: [ self class responseString ]
]
