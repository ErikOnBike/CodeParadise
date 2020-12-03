Class {
	#name : #CpPointerEvent,
	#superclass : #CpUserInterfaceEvent,
	#instVars : [
		'offset'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #accessing }
CpPointerEvent >> offset [

	^ offset
]

{ #category : #accessing }
CpPointerEvent >> offset: aPoint [

	offset := aPoint
]

{ #category : #printing }
CpPointerEvent >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ', offset: '.
	self offset printOn: aStream
]
