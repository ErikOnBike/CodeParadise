Class {
	#name : #CpNodeJSRestUnauthorizedError,
	#superclass : #CpNodeJSRestError,
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #accessing }
CpNodeJSRestUnauthorizedError class >> responseCode [

	^ 401
]
