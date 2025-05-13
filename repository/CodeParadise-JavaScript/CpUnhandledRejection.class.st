Class {
	#name : #CpUnhandledRejection,
	#superclass : #Error,
	#instVars : [
		'reason',
		'promise',
		'promiseCompiledCode'
	],
	#category : #'CodeParadise-JavaScript-Support'
}

{ #category : #'instance creation' }
CpUnhandledRejection class >> new [

	self errorNewReplacedBy: #reason:promise:compiledCode:
]

{ #category : #'instance creation' }
CpUnhandledRejection class >> reason: anObject promise: aPromise compiledCode: aCompiledCode [

	"Answer a new instance of the receiver for the specified reason (a JavaScript Object) and JavaScript Promise"

	^ self basicNew
		initializeWithReason: anObject promise: aPromise compiledCode: aCompiledCode ;
		yourself
]

{ #category : #converting }
CpUnhandledRejection >> asJavaScriptError [

	"Answer the JavaScript rejection reason if it's an error,
	otherwise nil"

	^ reason isErrorObject
		ifTrue: [ reason ]
]

{ #category : #accessing }
CpUnhandledRejection >> cause [

	"Answer the rejection reason if it's an Error,
	otherwise answer the reason itself"

	^ reason isErrorObject
		ifTrue: [ reason cause ]
		ifFalse: [ reason ]
]

{ #category : #initialization }
CpUnhandledRejection >> initializeWithReason: anObject promise: aPromise compiledCode: aCompiledCode [

	self initialize.

	reason := anObject.
	promise := aPromise.
	promiseCompiledCode := aCompiledCode
]

{ #category : #testing }
CpUnhandledRejection >> isSync [

	"Answer whether this unhandled rejection occurred in a synchronous context.

	Implementation:
	A synchronous unhandled rejection should have the class side #syncMarker as
	compiled code. See CpJavaScriptPromise >> #await"

	^ promiseCompiledCode == (CpUnhandledRejection >> #syncMarker)
]

{ #category : #logging }
CpUnhandledRejection >> log [

	"Log the receiver (showing the incriminating code origin and cause)"

	self errorCr: 'Unhandled rejection from: ', promiseCompiledCode printString.
	self errorCr: 'Exception: ', self rootException printString.
	self errorCr: 'Reason: ', self rootCause printString
]

{ #category : #accessing }
CpUnhandledRejection >> rootCause [

	"Answer the root cause of receiver's cause"

	^ reason isErrorObject
		ifTrue: [ reason rootCause ]
		ifFalse: [ reason ]
]

{ #category : #accessing }
CpUnhandledRejection >> rootException [

	"Answer the Exception causing (or wrapped in) the receiver"

	^ reason isErrorObject
		ifTrue: [ reason rootException ]
		ifFalse: [ self ]
]

{ #category : #signaling }
CpUnhandledRejection >> signal [

	self isSync
		ifTrue: [ super signal ]
		ifFalse: [ self signalAsync ]
]

{ #category : #signaling }
CpUnhandledRejection >> signalAsync [

	"Signal the unhandled rejection.
	Since this is an asynchronous call (a Promise failed and/or got rejected, but no catch was
	in place), there is no error handler which can catch this issue. Therefore show the issue
	in the console and announce the receiver to the global ExceptionAnnouncer. Consider this a
	programming issue and try to add a #catch: to the incriminating code (see console log for
	the origin of the issue)."

	"Set the signalContext and signaler (happens in #signal normally)"
	signalContext := thisContext.
	signaler ifNil: [ signaler := self receiver ].

	self log.

	CpExceptionAnnouncer announceException: self
]

{ #category : #resources }
CpUnhandledRejection >> syncMarker [

	"This method is simply a marker to distinguish between synchronous and asynchronous unhandled rejections"
]
