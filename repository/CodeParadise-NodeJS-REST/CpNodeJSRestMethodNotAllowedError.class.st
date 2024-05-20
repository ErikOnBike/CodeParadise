Class {
	#name : #CpNodeJSRestMethodNotAllowedError,
	#superclass : #CpNodeJSRestError,
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #accessing }
CpNodeJSRestMethodNotAllowedError class >> responseCode [

	^ 405
]
