Class {
	#name : #CpJavaScriptError,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-JavaScript-Core'
}

{ #category : #'instance creation' }
CpJavaScriptError class >> message: aString [

	"Answer an instance of the receiver with the specified message"

	^ self newInstanceWithArguments: { aString } resultAs: self
]

{ #category : #'class initialization' }
CpJavaScriptError class >> postInstallOnce [

	"Register the uncaught instance context once"

	self registerUncaughtInstanceContext
]

{ #category : #support }
CpJavaScriptError class >> registerUncaughtInstanceContext [

	"Register the Context which gets executed on uncaught Exceptions or unhandled Rejections.

	Implementation:
	Since there is no Context to handle this issue (asynchronous Promise failing), only signal
	the exception. Its default behavior will be to log itself (including origin of the issue)
	and announce it through the global ExceptionAnnouncer. A handler can be added to listen
	for this specific announcement and perform some (application specific) clean-up."

	self registerUncaughtInstanceContext: [
		self uncaughtInstance
			ifNotNil: [ :exception | exception signal ].

		"This Context will run in a newly created Process, terminate it to prevent the Context
		from trying to access (a missing) sender Context."
		Processor activeProcess terminate ] asContext
]

{ #category : #support }
CpJavaScriptError class >> registerUncaughtInstanceContext: aContext [

	"Register the Context which gets executed on uncaught Exceptions or unhandled Rejections"

	<primitive: 'primitiveJavaScriptErrorRegisterUncaughtInstanceContext:' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #support }
CpJavaScriptError class >> uncaughtInstance [

	"Answer the last uncaught exception or unhandled rejection and reset it.
	If no uncaught exception nor unhandled rejection has occurred, nil will be answered.

	Be aware: this will not answer an instance of the receiver, but an instance of either
	CpUncaughtException or CpUnhandledRejection which are subclasses of (Smalltalk) Exception.

	The value is reset after this call. This means that if two consecutive calls
	are made directly after each other, the second call will answer nil."

	self uncaughtObject ifNotNil: [ :uncaughtObject |
		uncaughtObject at: #error ifPresent: [ :error |
			^ CpUncaughtException exception: error ].
		uncaughtObject at: #promise ifPresent: [ :promise |
			^ CpUnhandledRejection
				reason: (uncaughtObject at: #reason ifAbsent: [ nil ])
				promise: promise
				compiledCode: (uncaughtObject at: #compiledCode ifAbsent: [ nil ]) ] ].

	^ nil
]

{ #category : #private }
CpJavaScriptError class >> uncaughtObject [

	"Answer the internal uncaught object representing either an uncaught Exception or an unhandled Rejection.
	After this call, the internal uncaught object is reset back to nil."

	<primitive: 'primitiveJavaScriptErrorUncaughtObject' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #accessing }
CpJavaScriptError >> cause [

	"Error cause indicating the reason why the current error is thrown — usually another caught error. For user-created Error objects, this is the value provided as the cause property of the constructor's second argument."

	^ self propertyAt: #cause
]

{ #category : #accessing }
CpJavaScriptError >> cause: anObject [

	"Error cause indicating the reason why the current error is thrown — usually another caught error. For user-created Error objects, this is the value provided as the cause property of the constructor's second argument."

	self propertyAt: #cause put: anObject
]

{ #category : #accessing }
CpJavaScriptError >> description [

	"Answer a description of the receiver (similar to Exception >> #description)"

	^ String streamContents: [ :stream |
		| message |
		stream nextPutAll: (self getClass name ifNil: [ 'Error' ]).
		(message := self message) isEmptyOrNil
			ifFalse: [
				stream
					nextPutAll: ': ' ;
					print: message ] ]
]

{ #category : #testing }
CpJavaScriptError >> isErrorObject [

	"Answer whether the receiver represents an Error"

	^ true
]

{ #category : #accessing }
CpJavaScriptError >> message [

	"Error message. For user-created Error objects, this is the string provided as the constructor's first argument."

	^ self propertyAt: #message
]

{ #category : #accessing }
CpJavaScriptError >> message: aString [

	"Error message. For user-created Error objects, this is the string provided as the constructor's first argument."

	self propertyAt: #message put: aString
]

{ #category : #accessing }
CpJavaScriptError >> rootCause [

	"Answer the 'lowest' cause (an Error object) of the receiver"

	^ self cause
		ifNotNil: [ :cause |
			cause isErrorObject
				ifTrue: [ cause rootCause ]
				ifFalse: [ cause ] ]
		ifNil: [ self ]
]

{ #category : #accessing }
CpJavaScriptError >> rootException [

	"Answer the Exception causing (or wrapped in) the receiver"

	^ self cause
		ifNotNil: [ :cause |
			cause isErrorObject
				ifTrue: [ cause rootException ]
				ifFalse: [ self ] ]
		ifNil: [ self ]
]

{ #category : #signalling }
CpJavaScriptError >> signal [

	"Signal the receiver"

	Error signal: 'Error in JavaScript' withTag: self
]

{ #category : #operations }
CpJavaScriptError >> toString [

	"Returns a string representing the specified object. Overrides the Object.prototype.toString() method."

	^ self apply: #toString
]
