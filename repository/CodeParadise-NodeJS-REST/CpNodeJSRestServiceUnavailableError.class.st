Class {
	#name : #CpNodeJSRestServiceUnavailableError,
	#superclass : #CpNodeJSRestError,
	#category : #'CodeParadise-NodeJS-REST-Errors'
}

{ #category : #accessing }
CpNodeJSRestServiceUnavailableError class >> responseCode [

	^ 503
]
