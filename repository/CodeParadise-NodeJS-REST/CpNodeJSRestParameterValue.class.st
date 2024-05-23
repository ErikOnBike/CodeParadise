"
I represent a parameter value for REST operations.
Since a body parameter is not retrieved in full by default,
I need to resolve my value in some cases. It is the responsibility
of my users to ask me to resolve my value (to prevent that I
prematurely start reading information which is not used).

"
Class {
	#name : #CpNodeJSRestParameterValue,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'CodeParadise-NodeJS-REST-Request'
}

{ #category : #accessing }
CpNodeJSRestParameterValue class >> value: anObject [

	"Answer a new instance of the receiver with the specified value"

	^ self basicNew
		initializeWithValue: anObject ;
		yourself
]

{ #category : #initialization }
CpNodeJSRestParameterValue >> initializeWithValue: anObject [

	self initialize.

	value := anObject
]

{ #category : #testing }
CpNodeJSRestParameterValue >> isResolved [

	^ true
]

{ #category : #resolving }
CpNodeJSRestParameterValue >> resolveThenDo: aBlock [

	"Resolve the receiver's value then evaluate the specified Block.
	If an Error occurred the error is used as value.

	Implementation:
	Since my value is already resolved, just evaluate the Block."

	aBlock value
]

{ #category : #accessing }
CpNodeJSRestParameterValue >> value [

	"Answer the receiver's value"

	^ value
]
