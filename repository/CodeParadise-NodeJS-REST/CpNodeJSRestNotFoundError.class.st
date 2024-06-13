Class {
	#name : #CpNodeJSRestNotFoundError,
	#superclass : #CpNodeJSRestError,
	#category : #'CodeParadise-NodeJS-REST-Errors'
}

{ #category : #accessing }
CpNodeJSRestNotFoundError class >> responseCode [

	^ 404
]

{ #category : #accessing }
CpNodeJSRestNotFoundError class >> responseString [

	^ 'Resource Not Found'
]
