Class {
	#name : #CpWebApplicationStaticFileServerDelegate,
	#superclass : #Object,
	#instVars : [
		'applicationStaticFileServerDelegate',
		'globalStaticFileServerDelegate'
	],
	#category : #'CodeParadise-WebApplication-Support'
}

{ #category : #'instance creation' }
CpWebApplicationStaticFileServerDelegate class >> application: applicationDelegate global: globalDelegate [

	"Answer a new instance of the receiver with the specified application and global static file server delegates"

	^ self basicNew
		initializeWithApplication: applicationDelegate global: globalDelegate ;
		yourself
]

{ #category : #'instance creation' }
CpWebApplicationStaticFileServerDelegate class >> new [

	self errorNewReplacedBy: #application:global:
]

{ #category : #public }
CpWebApplicationStaticFileServerDelegate >> handleRequest: aRequest [

	"Handle requests which should be mapped onto the application.

	Implementation:
	First try the local application resources. If nothing is found then try the
	global static resources."

	| response |

	"Try to let the application's static file server delegate handle it first"
	applicationStaticFileServerDelegate ifNotNil: [
		(response := applicationStaticFileServerDelegate handleRequest: aRequest) isNotFound
			ifFalse: [ ^ response ] ].

	"Fall back to global static file server delegate"
	^ globalStaticFileServerDelegate handleRequest: aRequest
]

{ #category : #initialization }
CpWebApplicationStaticFileServerDelegate >> initializeWithApplication: applicationDelegate global: globalDelegate [

	self initialize.

	applicationStaticFileServerDelegate := applicationDelegate.
	globalStaticFileServerDelegate := globalDelegate
]

{ #category : #testing }
CpWebApplicationStaticFileServerDelegate >> isGlobalStaticFileServerDelegate [

	^ false
]
