Class {
	#name : 'CpWheelEvent',
	#superclass : 'CpMouseEvent',
	#category : 'CodeParadise-WebApplication-Events',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Events'
}

{ #category : 'accessing' }
CpWheelEvent >> delta [

	"Answer a Point representing the delta the wheel has scrolled"

	^ self deltaX @ self deltaY
]

{ #category : 'accessing' }
CpWheelEvent >> deltaMode [

	"Answer a Number representing the delta unit.

	Possible values:
		0: pixels
		1: lines
		2: pages
	"

	^ self propertyAt: #deltaMode
]

{ #category : 'accessing' }
CpWheelEvent >> deltaX [

	"Answer a Number representing the horizontal scroll amount (in units, see #deltaMode)"

	^ self propertyAt: #deltaX
]

{ #category : 'accessing' }
CpWheelEvent >> deltaY [

	"Answer a Number representing the vertical scroll amount (in units, see #deltaMode)"

	^ self propertyAt: #deltaY
]

{ #category : 'printing' }
CpWheelEvent >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ', delta: ' ;
		print: self delta ;
		nextPutAll: ', deltaMode: ' ;
		print: self deltaMode
]
