Class {
	#name : #CpNodeJSRestBodyParameter,
	#superclass : #CpNodeJSRestParameter,
	#category : #'CodeParadise-NodeJS-REST-Request'
}

{ #category : #accessing }
CpNodeJSRestBodyParameter >> valueFromRequest: aRestRequest forEndpointOperation: aRestEndpointOperation [

	^ CpNodeJSRestBodyParameterValue value: aRestRequest body
]
