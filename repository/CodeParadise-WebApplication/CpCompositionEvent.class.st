Class {
	#name : #CpCompositionEvent,
	#superclass : #CpUserInterfaceEvent,
	#instVars : [
		'data'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #accessing }
CpCompositionEvent >> data [

	^ data
]

{ #category : #accessing }
CpCompositionEvent >> data: aString [

	data := aString
]

{ #category : #printing }
CpCompositionEvent >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ', data: '.
	self data printOn: aStream
]
