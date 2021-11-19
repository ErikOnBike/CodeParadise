Class {
	#name : #CpGestureEvent,
	#superclass : #CpUserInterfaceEvent,
	#instVars : [
		'offsetX',
		'offsetY',
		'rotation',
		'scale'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #accessing }
CpGestureEvent >> offset [

	^ offsetX @ offsetY
]

{ #category : #accessing }
CpGestureEvent >> offset: aPoint [

	offsetX := aPoint x.
	offsetY := aPoint y
]

{ #category : #accessing }
CpGestureEvent >> offsetX [

	^ offsetX
]

{ #category : #accessing }
CpGestureEvent >> offsetX: aNumber [

	offsetX := aNumber
]

{ #category : #accessing }
CpGestureEvent >> offsetY [

	^ offsetY
]

{ #category : #accessing }
CpGestureEvent >> offsetY: aNumber [

	offsetY := aNumber
]

{ #category : #printing }
CpGestureEvent >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ', offset: ' ;
		print: self offset ;
		nextPutAll: ', rotation: ' ;
		print: self rotation ;
		nextPutAll: ', scale: ' ;
		print: self scale
]

{ #category : #accessing }
CpGestureEvent >> rotation [

	^ rotation
]

{ #category : #accessing }
CpGestureEvent >> rotation: aNumber [

	rotation := aNumber
]

{ #category : #accessing }
CpGestureEvent >> scale [

	^ scale
]

{ #category : #accessing }
CpGestureEvent >> scale: aNumber [

	scale := aNumber
]
