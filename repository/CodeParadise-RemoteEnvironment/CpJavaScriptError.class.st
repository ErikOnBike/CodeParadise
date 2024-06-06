Class {
	#name : #CpJavaScriptError,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #accessing }
CpJavaScriptError >> cause [

	"Error cause indicating the reason why the current error is thrown — usually another caught error. For user-created Error objects, this is the value provided as the cause property of the constructor's second argument."

	^ self propertyAt: #cause
]

{ #category : #accessing }
CpJavaScriptError >> description [

	"Answer a description of the receiver (similar to Exception >> #description)"

	^ String streamContents: [ :stream |
		| message |
		stream << (self getClass name ifNil: [ 'Error' ]).
		(message := self message) isEmptyOrNil
			ifFalse: [ stream << ': ' << message ] ]
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
