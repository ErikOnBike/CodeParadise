Class {
	#name : #CpNodeJSRestHeaderParameter,
	#superclass : #CpNodeJSRestParameter,
	#instVars : [
		'key'
	],
	#category : #'CodeParadise-NodeJS-REST-Request'
}

{ #category : #'instance creation' }
CpNodeJSRestHeaderParameter class >> withKey: aSymbol [

	^ self basicNew
		initializeWithKey: aSymbol ;
		yourself
]

{ #category : #initialization }
CpNodeJSRestHeaderParameter >> initializeWithKey: aSymbol [

	self initialize.

	key := aSymbol
]

{ #category : #initialization }
CpNodeJSRestHeaderParameter >> key [

	^ key
]

{ #category : #accessing }
CpNodeJSRestHeaderParameter >> valueFromRequest: aRestRequest forEndpointOperation: aRestEndpointOperation [

	^ CpNodeJSRestParameterValue value: (aRestRequest headerAt: key)
]
