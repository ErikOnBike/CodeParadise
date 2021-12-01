Class {
	#name : #CpWheelEvent,
	#superclass : #CpMouseEvent,
	#instVars : [
		'deltaX',
		'deltaY',
		'deltaMode'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #accessing }
CpWheelEvent >> delta [

	^ deltaX @ deltaY
]

{ #category : #accessing }
CpWheelEvent >> delta: aPoint [

	deltaX := aPoint x.
	deltaY := aPoint y
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
CpWheelEvent >> deltaX [

	^ deltaX
]

{ #category : #accessing }
CpWheelEvent >> deltaX: aNumber [

	deltaX := aNumber
]

{ #category : #accessing }
CpWheelEvent >> deltaY [

	^ deltaY
]

{ #category : #accessing }
CpWheelEvent >> deltaY: aNumber [

	deltaY := aNumber
]

{ #category : #printing }
CpWheelEvent >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ', delta: ' ;
		print: self delta ;
		nextPutAll: ', deltaMode: ' ;
		print: self deltaMode
]
