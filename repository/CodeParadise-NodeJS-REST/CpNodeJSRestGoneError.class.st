Class {
	#name : #CpNodeJSRestGoneError,
	#superclass : #CpNodeJSRestError,
	#category : #'CodeParadise-NodeJS-REST-Errors'
}

{ #category : #accessing }
CpNodeJSRestGoneError class >> responseCode [

	^ 410
]

{ #category : #accessing }
CpNodeJSRestGoneError class >> responseString [

	^ 'Gone'
]
