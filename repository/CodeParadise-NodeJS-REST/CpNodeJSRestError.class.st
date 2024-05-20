Class {
	#name : #CpNodeJSRestError,
	#superclass : #Error,
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #accessing }
CpNodeJSRestError class >> responseCode [

	^ 500
]

{ #category : #accessing }
CpNodeJSRestError >> responseCode [

	^ self class responseCode
]
