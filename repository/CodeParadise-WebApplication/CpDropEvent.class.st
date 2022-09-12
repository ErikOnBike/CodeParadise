Class {
	#name : #CpDropEvent,
	#superclass : #CpSyntheticEvent,
	#instVars : [
		'dragEvent',
		'pointerId'
	],
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #'event handling' }
CpDropEvent class >> dispatchInstanceForDragEvent: aDragEvent pointerEvent: aPointerEvent [

	"Dispatch an instance of the receiver based on the specified DragEvent"

	(self newFromDragEvent: aDragEvent withPointerEvent: aPointerEvent)
		dispatch
]

{ #category : #'instance creation' }
CpDropEvent class >> newFromDragEvent: aDragEvent withPointerEvent: aPointerEvent [

	"Create a new instance of the receiver from the specified DragEvent and PointerEvent"

	^ self basicNew
		initializeWithDragEvent: aDragEvent pointerEvent: aPointerEvent ;
		yourself
]

{ #category : #accessing }
CpDropEvent >> dragElement [

	^ dragEvent currentElement
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
CpDropEvent >> initialize [

	super initialize.

"	type := #drop"
]

{ #category : #initialization }
CpDropEvent >> initializeWithDragEvent: aDragEvent pointerEvent: aPointerEvent [

	self initialize.

"	timeStamp := aPointerEvent timeStamp.
	target := aPointerEvent target.
	pageX := aPointerEvent pageX.
	pageY := aPointerEvent pageY.
	offsetX := aPointerEvent offsetX.
	offsetY := aPointerEvent offsetY.
	elements := aPointerEvent elements select: [ :each | each isListeningTo: self class ].
	buttons := aPointerEvent buttons.
	modifiers := aPointerEvent modifiers.
"	dragEvent := aDragEvent.
	pointerId := aPointerEvent pointerId

]

{ #category : #testing }
CpDropEvent >> isCanceled [

	^ dragEvent isCanceled
]

{ #category : #accessing }
CpDropEvent >> modifiers [

	^ dragEvent modifiers
]

{ #category : #printing }
CpDropEvent >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ', dragEvent: ' ;
		print: dragEvent ;
		nextPutAll: ', pointerId: ' ;
		print: pointerId
]
