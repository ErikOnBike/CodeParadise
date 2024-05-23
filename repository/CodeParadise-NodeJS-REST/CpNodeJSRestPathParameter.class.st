Class {
	#name : #CpNodeJSRestPathParameter,
	#superclass : #CpNodeJSRestParameter,
	#instVars : [
		'key'
	],
	#category : #'CodeParadise-NodeJS-REST-Request'
}

{ #category : #'instance creation' }
CpNodeJSRestPathParameter class >> withKey: aSymbol [

	^ self basicNew
		initializeWithKey: aSymbol ;
		yourself
]

{ #category : #initialization }
CpNodeJSRestPathParameter >> initializeWithKey: aSymbol [

	self initialize.

	key := aSymbol
]

{ #category : #testing }
CpNodeJSRestPathParameter >> isPathParameter [

	^ true
]

{ #category : #accessing }
CpNodeJSRestPathParameter >> key [

	^ key
]

{ #category : #accessing }
CpNodeJSRestPathParameter >> valueFromRequest: aRestRequest forEndpointOperation: aRestEndpointOperation [

	^ CpNodeJSRestParameterValue value: (aRestEndpointOperation pathParameterFrom: aRestRequest path at: key)
]
