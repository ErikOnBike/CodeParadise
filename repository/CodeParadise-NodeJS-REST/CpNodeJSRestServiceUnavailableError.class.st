Class {
	#name : #CpNodeJSRestServiceUnavailableError,
	#superclass : #CpNodeJSRestError,
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #accessing }
CpNodeJSRestServiceUnavailableError class >> responseCode [

	^ 503
]
