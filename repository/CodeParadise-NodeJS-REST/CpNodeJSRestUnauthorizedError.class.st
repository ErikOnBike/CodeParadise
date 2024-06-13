Class {
	#name : #CpNodeJSRestUnauthorizedError,
	#superclass : #CpNodeJSRestError,
	#category : #'CodeParadise-NodeJS-REST-Errors'
}

{ #category : #accessing }
CpNodeJSRestUnauthorizedError class >> responseCode [

	^ 401
]

{ #category : #accessing }
CpNodeJSRestUnauthorizedError class >> responseString [

	^ 'Unauthorized'
]
