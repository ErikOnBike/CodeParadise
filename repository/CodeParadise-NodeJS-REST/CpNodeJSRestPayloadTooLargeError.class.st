Class {
	#name : #CpNodeJSRestPayloadTooLargeError,
	#superclass : #CpNodeJSRestError,
	#category : #'CodeParadise-NodeJS-REST-Errors'
}

{ #category : #accessing }
CpNodeJSRestPayloadTooLargeError class >> responseCode [

	^ 413
]

{ #category : #accessing }
CpNodeJSRestPayloadTooLargeError class >> responseString [

	^ 'Payload Too Large'
]
