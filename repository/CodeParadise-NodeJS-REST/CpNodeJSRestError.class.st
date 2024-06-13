Class {
	#name : #CpNodeJSRestError,
	#superclass : #Error,
	#category : #'CodeParadise-NodeJS-REST-Errors'
}

{ #category : #accessing }
CpNodeJSRestError class >> responseCode [

	^ 500
]

{ #category : #accessing }
CpNodeJSRestError class >> responseString [

	^ 'Internal Server Error'
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

{ #category : #'as yet unclassified' }
CpNodeJSRestError >> restResponseString [

	^ messageText isEmptyOrNil
		ifTrue: [ self class responseString ]
		ifFalse: [ messageText ]
]
