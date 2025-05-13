Class {
	#name : #CpUncaughtException,
	#superclass : #Error,
	#instVars : [
		'exception'
	],
	#category : #'CodeParadise-JavaScript-Support'
}

{ #category : #'instance creation' }
CpUncaughtException class >> exception: anException [

	"Answer a new instance of the receiver for the specified (uncaught) JavaScript Exception"

	^ self basicNew
		initializeWithException: anException ;
		yourself
]

{ #category : #'instance creation' }
CpUncaughtException class >> new [

	self errorNewReplacedBy: #exception:
]

{ #category : #converting }
CpUncaughtException >> asJavaScriptError [

	"Answer the JavaScript Exception as error"

	^ exception
]

{ #category : #accessing }
CpUncaughtException >> cause [

	"Answer the (uncaught) JavaScript Exception as cause"

	^ exception
]

{ #category : #handling }
CpUncaughtException >> defaultAction [

	"Log issue as default action"

	self errorCr: 'Uncaught exception: ', self rootException printString.

	^ nil
]

{ #category : #initialization }
CpUncaughtException >> initializeWithException: anException [

	self initialize.

	exception := anException
]

{ #category : #accessing }
CpUncaughtException >> rootCause [

	"Answer the root cause of the JavaScript Exception as root cause"

	^ exception rootCause
]

{ #category : #accessing }
CpUncaughtException >> rootException [

	"Answer the Exception causing (or wrapped in) the receiver"

	^ exception rootException
]
