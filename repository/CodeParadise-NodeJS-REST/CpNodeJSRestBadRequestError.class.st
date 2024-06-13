Class {
	#name : #CpNodeJSRestBadRequestError,
	#superclass : #CpNodeJSRestError,
	#category : #'CodeParadise-NodeJS-REST-Errors'
}

{ #category : #accessing }
CpNodeJSRestBadRequestError class >> responseCode [

	^ 400
]

{ #category : #accessing }
CpNodeJSRestBadRequestError class >> responseString [

	^ 'Bad Request'
]
