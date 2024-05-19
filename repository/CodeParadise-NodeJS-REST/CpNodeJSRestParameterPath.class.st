Class {
	#name : #CpNodeJSRestParameterPath,
	#superclass : #CpNodeJSRestParameter,
	#instVars : [
		'key'
	],
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #'instance creation' }
CpNodeJSRestParameterPath class >> withKey: aSymbol [

	^ self basicNew
		initializeWithKey: aSymbol ;
		yourself
]

{ #category : #initialization }
CpNodeJSRestParameterPath >> initializeWithKey: aSymbol [

	self initialize.

	key := aSymbol
]

{ #category : #testing }
CpNodeJSRestParameterPath >> isPathParameter [

	^ true
]

{ #category : #accessing }
CpNodeJSRestParameterPath >> key [

	^ key
]

{ #category : #accessing }
CpNodeJSRestParameterPath >> valueFromRequest: aRestRequest forEndpoint: aRestEndpoint [

	^ aRestRequest pathParameterFrom: aRestRequest path at: key
]
