Class {
	#name : #CpNodeJSRestUnauthorizedError,
	#superclass : #CpNodeJSRestError,
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #accessing }
CpNodeJSRestUnauthorizedError >> responseCode [

	^ 401
]
