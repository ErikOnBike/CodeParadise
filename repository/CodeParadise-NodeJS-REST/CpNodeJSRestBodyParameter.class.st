Class {
	#name : #CpNodeJSRestBodyParameter,
	#superclass : #CpNodeJSRestParameter,
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #accessing }
CpNodeJSRestBodyParameter >> valueFromRequest: aRestRequest forEndpoint: aRestEndpoint [

	^ CpNodeJSRestBodyParameterValue value: aRestRequest body
]
