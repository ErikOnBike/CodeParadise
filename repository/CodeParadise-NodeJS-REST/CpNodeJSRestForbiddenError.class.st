Class {
	#name : #CpNodeJSRestForbiddenError,
	#superclass : #CpNodeJSRestError,
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #accessing }
CpNodeJSRestForbiddenError >> responseCode [

	^ 403
]
