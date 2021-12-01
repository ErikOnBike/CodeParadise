Class {
	#name : #CpGestureEvent,
	#superclass : #CpUserInterfaceEvent,
	#instVars : [
		'rotation',
		'scale'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #printing }
CpGestureEvent >> printOn: aStream [

	super printOn: aStream.
	aStream
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
