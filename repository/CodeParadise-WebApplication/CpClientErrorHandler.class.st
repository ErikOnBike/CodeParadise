Class {
	#name : #CpClientErrorHandler,
	#superclass : #Object,
	#category : #'CodeParadise-WebApplication-Support'
}

{ #category : #'message handling' }
CpClientErrorHandler >> handleClientError: aClientError for: aServerEnvironment [

	"Handle the specified error within the specified ServerEnvironment"

	self subclassResponsibility
]
