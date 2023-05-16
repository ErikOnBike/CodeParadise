Class {
	#name : #CpDropEvent,
	#superclass : #CpSyntheticEvent,
	#instVars : [
		'dragEvent'
	],
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #'event handling' }
CpDropEvent class >> dispatchInstanceForDragEvent: aDragEvent [

	"Dispatch an instance of the receiver based on the specified DragEvent"

	(self newFromDragEvent: aDragEvent)
		dispatch
]

{ #category : #'instance creation' }
CpDropEvent class >> newFromDragEvent: aDragEvent [

	"Create a new instance of the receiver from the specified DragEvent and PointerEvent"

	^ self basicNew
		initializeWithDragEvent: aDragEvent ;
		yourself
]

{ #category : #accessing }
CpDropEvent >> dragElement [

	^ dragEvent currentTarget
]

{ #category : #accessing }
CpDropEvent >> dragEndPoint [

	^ dragEvent endPoint
]

{ #category : #accessing }
CpDropEvent >> dragStartPoint [

	^ dragEvent startPoint
]

{ #category : #accessing }
CpDropEvent >> dragTracePoints [

	^ dragEvent tracePoints
]

{ #category : #initialization }
CpDropEvent >> initializeWithDragEvent: aDragEvent [

	self initialize.

	timeStamp := aDragEvent timeStamp.
	currentTarget := aDragEvent currentTarget.
	dragEvent := aDragEvent
]

{ #category : #testing }
CpDropEvent >> isCanceled [

	^ dragEvent isCanceled
]

{ #category : #accessing }
CpDropEvent >> point [

	"Answer the receiver's point (which is the drag's end point)"

	^ self dragEndPoint point
]

{ #category : #printing }
CpDropEvent >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ', dragEvent: ' ;
		print: dragEvent
]
