Class {
	#name : #CpNodeJSRestPayload,
	#superclass : #Object,
	#instVars : [
		'incomingMessage',
		'data',
		'error',
		'dataHandler',
		'endHandler',
		'errorHandler'
	],
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #'instance creation' }
CpNodeJSRestPayload class >> fromIncomingMessage: anIncomingMessage [

	^ self basicNew
		initializeWithIncomingMessage: anIncomingMessage ;
		yourself
]

{ #category : #initialization }
CpNodeJSRestPayload >> initializeWithIncomingMessage: anIncomingMessage [

	self initialize.

	incomingMessage := anIncomingMessage.
	data := ''.

	dataHandler := incomingMessage onDataDo: [ :chunk | data := data, chunk ].
	endHandler := incomingMessage onEndDo: [
		incomingMessage
			removeDataHandler: dataHandler ;
			removeEndHandler: endHandler ;
			removeErrorHandler: errorHandler.

		"Clean up to prevent memory leaks"
		dataHandler := nil.
		endHandler := nil.
		errorHandler := nil.
		incomingMessage := nil ].
	errorHandler := incomingMessage onErrorDo: [ :anError |
		error := anError.
		incomingMessage
			removeDataHandler: dataHandler ;
			removeEndHandler: endHandler ;
			removeErrorHandler: errorHandler.

		"Clean up to prevent memory leaks"
		dataHandler := nil.
		endHandler := nil.
		errorHandler := nil.
		incomingMessage := nil ]
]
