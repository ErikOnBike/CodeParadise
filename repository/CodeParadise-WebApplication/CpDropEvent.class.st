Class {
	#name : #CpDropEvent,
	#superclass : #CpMouseEvent,
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
		when: CpPointerUpEvent send: #doNothing: to: self
]

{ #category : #'event handling' }
CpDropEvent class >> dispatchInstanceForDragEvent: aDragEvent pointerEvent: aPointerEvent [

	"Dispatch an instance of the receiver based on the specified DragEvent"

	(self newFromDragEvent: aDragEvent withPointerEvent: aPointerEvent)
		dispatch
]

{ #category : #actions }
CpDropEvent class >> doNothing: aPointerUpEvent [

	"This method is present to allow the receiver to be recognized as native event.
	See self >> #addListenerTo:"

	"First let other handle the PointerUp event"
	aPointerUpEvent propagate
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

	timeStamp := aPointerEvent timeStamp.
	target := aPointerEvent target.
	pageX := aPointerEvent pageX.
	pageY := aPointerEvent pageY.
	offsetX := aPointerEvent offsetX.
	offsetY := aPointerEvent offsetY.
	elements := aPointerEvent elements select: [ :each | each isListeningTo: self class ].
	buttons := aPointerEvent buttons.
	modifiers := aPointerEvent modifiers.
	dragEvent := aDragEvent.
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
