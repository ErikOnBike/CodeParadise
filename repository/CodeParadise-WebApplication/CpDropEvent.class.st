Class {
	#name : #CpDropEvent,
	#superclass : #CpUserInterfaceEvent,
	#instVars : [
		'dragEvent',
		'pointerId'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #announcing }
CpDropEvent class >> addListenerTo: anElement [

	"Add a listener for the receiver to the specified DOM element.

	Implementation: Simulate a DropEvent by using a PointerUp event.
	This allows the drop event to be set on an element and be recognized as such.
	This is needed because there is no equivalent drop event in browsers."

	super addListenerTo: anElement.

	"Implementation: Send meaningless message to self, since there is no need to handle the event itself"
	anElement
		when: CpPointerUpEvent send: #doNothing to: self
]

{ #category : #'event handling' }
CpDropEvent class >> dispatchInstanceForDragEvent: aDragEvent pointerEvent: aPointerEvent [

	"Dispatch an instance of the receiver based on the specified DragEvent"

	(self newFromDragEvent: aDragEvent withPointerEvent: aPointerEvent)
		dispatch
]

{ #category : #actions }
CpDropEvent class >> doNothing [

	"This method is present to allow the receiver to be recognized as native event.
	See self >> #addListener:"
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

	type := #drop
]

{ #category : #initialization }
CpDropEvent >> initializeWithDragEvent: aDragEvent pointerEvent: aPointerEvent [

	self initialize.

	dragEvent := aDragEvent.
	pointerId := aPointerEvent pointerId.
	timeStamp := aPointerEvent timeStamp.
	target := aPointerEvent target.
	elements := aPointerEvent elements copy.
	point := aPointerEvent point copy
]

{ #category : #initialization }
CpDropEvent >> initializeWithDragEvent: aDragEvent pointerId: aNumber [

	self initialize.

	dragEvent := aDragEvent.
	pointerId := aNumber
]

{ #category : #testing }
CpDropEvent >> isCanceled [

	^ dragEvent isCanceled
]

{ #category : #testing }
CpDropEvent >> isForDragEvent: aDragEvent [

	^ dragEvent hasSameOrigin: aDragEvent
]

{ #category : #printing }
CpDropEvent >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ', dragEvent: '.
	dragEvent printOn: aStream.
	aStream nextPutAll: ', pointerId: '.
	pointerId printOn: aStream
]
