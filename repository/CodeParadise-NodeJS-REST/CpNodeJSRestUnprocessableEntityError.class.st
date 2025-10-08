Class {
	#name : #CpNodeJSRestUnprocessableEntityError,
	#superclass : #CpNodeJSRestError,
	#category : #'CodeParadise-NodeJS-REST-Errors'
}

{ #category : #accessing }
CpNodeJSRestUnprocessableEntityError class >> responseCode [

	^ 422
]

{ #category : #accessing }
CpNodeJSRestUnprocessableEntityError class >> responseString [

	^ 'Unprocessable Entity'
]
