Class {
	#name : #CpNodeJSRestNotFoundError,
	#superclass : #CpNodeJSRestError,
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #accessing }
CpNodeJSRestNotFoundError class >> responseCode [

	^ 404
]
