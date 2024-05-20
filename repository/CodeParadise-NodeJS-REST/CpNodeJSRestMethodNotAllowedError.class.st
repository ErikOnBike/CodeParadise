Class {
	#name : #CpNodeJSRestMethodNotAllowedError,
	#superclass : #CpNodeJSRestError,
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #accessing }
CpNodeJSRestMethodNotAllowedError >> responseCode [

	^ 405
]
