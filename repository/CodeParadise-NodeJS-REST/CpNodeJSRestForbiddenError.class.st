Class {
	#name : #CpNodeJSRestForbiddenError,
	#superclass : #CpNodeJSRestError,
	#category : #'CodeParadise-NodeJS-REST-Errors'
}

{ #category : #accessing }
CpNodeJSRestForbiddenError class >> responseCode [

	^ 403
]
