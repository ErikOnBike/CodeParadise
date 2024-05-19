Class {
	#name : 'CpDropEvent',
	#superclass : 'CpSyntheticEvent',
	#instVars : [
		'dragEvent'
	],
	#category : 'CodeParadise-WebApplication-Events-Custom',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Events-Custom'
}

{ #category : 'announcing' }
CpDropEvent class >> addListenerTo: anElement [

	"Add a listener for the receiver to the specified DOM element.

	Implementation:
	Simulate a DropEvent by using a native drop event to signal the
	DOM element is droppable. The event handler is a no-operation.
	Everything is handled from CpDragEvent >> #dragEnd:"

	super addListenerTo: anElement.

	anElement when: CpNativeDropEvent send: #noop to: self
]

{ #category : 'event handling' }
CpDropEvent class >> dispatchInstanceForDragEvent: aDragEvent [

	"Dispatch an instance of the receiver based on the specified DragEvent"

	(self newFromDragEvent: aDragEvent)
		dispatch
]

{ #category : 'instance creation' }
CpDropEvent class >> newFromDragEvent: aDragEvent [

	"Create a new instance of the receiver from the specified DragEvent and PointerEvent"

	^ self basicNew
		initializeWithDragEvent: aDragEvent ;
		yourself
]

{ #category : 'announcing' }
CpDropEvent class >> removeListenerFrom: anElement [

	"Remove event listener from the specified DOM element.

	Impementation: see #addEventListenerTo:"

	super removeListenerFrom: anElement.

	CpNativeDropEvent removeListenerFrom: anElement
]

{ #category : 'accessing' }
CpDropEvent >> dragElement [

	^ dragEvent currentTarget
]

{ #category : 'accessing' }
CpDropEvent >> dragEndPoint [

	^ dragEvent endPoint
]

{ #category : 'accessing' }
CpDropEvent >> dragStartPoint [

	^ dragEvent startPoint
]

{ #category : 'accessing' }
CpDropEvent >> dragTracePoints [

	^ dragEvent tracePoints
]

{ #category : 'processing - private' }
CpDropEvent >> dropTargetUnderPointer: aPoint [

	| dropTargetsUnderPointer |

	dropTargetsUnderPointer := CpHtmlElement elementsFromPoint: aPoint.

	^ dropTargetsUnderPointer
		detect: [ :each | each isListeningTo: CpNativeDropEvent ]
		ifNone: [ nil ]
]

{ #category : 'initialization' }
CpDropEvent >> initializeWithDragEvent: aDragEvent [

	self initialize.

	timeStamp := aDragEvent timeStamp.
	modifiers := aDragEvent modifiers.
	currentTarget := self dropTargetUnderPointer: aDragEvent point.
	dragEvent := aDragEvent
]

{ #category : 'testing' }
CpDropEvent >> isCanceled [

	^ dragEvent isCanceled
]

{ #category : 'accessing' }
CpDropEvent >> point [

	"Answer the receiver's point (which is the drag's end point)"

	^ self dragEndPoint
]

{ #category : 'printing' }
CpDropEvent >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ', dragEvent: ' ;
		print: dragEvent
]
