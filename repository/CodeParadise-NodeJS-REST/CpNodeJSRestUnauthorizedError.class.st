Class {
	#name : #CpNodeJSRestUnauthorizedError,
	#superclass : #CpNodeJSRestError,
	#category : #'CodeParadise-NodeJS-REST-Errors'
}

{ #category : #accessing }
CpNodeJSRestUnauthorizedError class >> responseCode [

	^ 401
]
