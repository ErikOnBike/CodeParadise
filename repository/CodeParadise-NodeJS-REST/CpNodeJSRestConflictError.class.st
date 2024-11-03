Class {
	#name : #CpNodeJSRestConflictError,
	#superclass : #CpNodeJSRestError,
	#category : #'CodeParadise-NodeJS-REST-Errors'
}

{ #category : #accessing }
CpNodeJSRestConflictError class >> responseCode [

	^ 409
]

{ #category : #accessing }
CpNodeJSRestConflictError class >> responseString [

	^ 'Conflict'
]
