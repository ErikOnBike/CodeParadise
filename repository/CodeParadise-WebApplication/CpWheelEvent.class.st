Class {
	#name : #CpWheelEvent,
	#superclass : #CpUserInterfaceEvent,
	#instVars : [
		'offset',
		'delta',
		'deltaMode'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #accessing }
CpWheelEvent >> delta [

	^ delta
]

{ #category : #accessing }
CpWheelEvent >> delta: aPoint [

	delta := aPoint
]

{ #category : #accessing }
CpWheelEvent >> deltaMode [

	^ deltaMode
]

{ #category : #accessing }
CpWheelEvent >> deltaMode: anInteger [

	"Set the mode of the receiver's delta value.
	0 - Pixel amount
	1 - Line amount
	2 - Page amount"

	deltaMode := anInteger
]

{ #category : #accessing }
CpWheelEvent >> offset [

	^ offset
]

{ #category : #accessing }
CpWheelEvent >> offset: aPoint [

	offset := aPoint
]

{ #category : #printing }
CpWheelEvent >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ', offset: '.
	self offset printOn: aStream.
	aStream nextPutAll: ', delta: '.
	self delta printOn: aStream.
	aStream nextPutAll: ', deltaMode: '.
	self deltaMode printOn: aStream
]
