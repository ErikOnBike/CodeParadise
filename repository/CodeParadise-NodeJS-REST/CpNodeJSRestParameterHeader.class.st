Class {
	#name : #CpNodeJSRestParameterHeader,
	#superclass : #CpNodeJSRestParameter,
	#instVars : [
		'key'
	],
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #'instance creation' }
CpNodeJSRestParameterHeader class >> withKey: aSymbol [

	^ self basicNew
		initializeWithKey: aSymbol ;
		yourself
]

{ #category : #initialization }
CpNodeJSRestParameterHeader >> initializeWithKey: aSymbol [

	self initialize.

	key := aSymbol
]

{ #category : #initialization }
CpNodeJSRestParameterHeader >> key [

	^ key
]

{ #category : #accessing }
CpNodeJSRestParameterHeader >> valueFromRequest: aRestRequest forEndpoint: aRestEndpoint [

	^ aRestRequest headerAt: key
]
