Class {
	#name : #CpNodeJSRestParameterBody,
	#superclass : #CpNodeJSRestParameter,
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #accessing }
CpNodeJSRestParameterBody >> valueFromRequest: aRestRequest forEndpoint: aRestEndpoint [

	^ aRestRequest body
]
