Class {
	#name : #CpNodeJSRestMethodNotAllowedError,
	#superclass : #CpNodeJSRestError,
	#category : #'CodeParadise-NodeJS-REST-Errors'
}

{ #category : #accessing }
CpNodeJSRestMethodNotAllowedError class >> responseCode [

	^ 405
]

{ #category : #accessing }
CpNodeJSRestMethodNotAllowedError class >> responseString [

	^ 'Method Not Allowed'
]
