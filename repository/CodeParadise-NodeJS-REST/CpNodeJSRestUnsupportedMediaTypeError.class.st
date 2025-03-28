Class {
	#name : #CpNodeJSRestUnsupportedMediaTypeError,
	#superclass : #CpNodeJSRestError,
	#category : #'CodeParadise-NodeJS-REST-Errors'
}

{ #category : #accessing }
CpNodeJSRestUnsupportedMediaTypeError class >> responseCode [

	^ 415
]

{ #category : #accessing }
CpNodeJSRestUnsupportedMediaTypeError class >> responseString [

	^ 'Unsupported Media Type'
]
