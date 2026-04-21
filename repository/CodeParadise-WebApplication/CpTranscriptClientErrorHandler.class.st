Class {
	#name : #CpTranscriptClientErrorHandler,
	#superclass : #CpClientErrorHandler,
	#category : #'CodeParadise-WebApplication-Support'
}

{ #category : #'message handling' }
CpTranscriptClientErrorHandler >> handleClientError: aClientError for: aServerEnvironment [

	self errorCr: ('{1} occurred in ServerEnvironment with id: {2}' format: { aClientError printString . aServerEnvironment id })
]
