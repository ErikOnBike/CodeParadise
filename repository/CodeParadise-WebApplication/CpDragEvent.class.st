Class {
	#name : #CpDragEvent,
	#superclass : #CpUserInterfaceEvent,
	#instVars : [
		'offset',
		'tracePoints',
		'endPoint'
	],
	#classVars : [
		'DragInstances'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #announcing }
CpDragEvent class >> addListenerTo: anElement [

	"Add a listener for the receiver to the specified DOM element.

	Implementation:
	Simulate a DragEvent by using PointerDown/PointerMove/PointerUp events.
	The PointerMove/PointerUp are registered in #postInstall. See comment there."

	super addListenerTo: anElement.

	anElement
		when: CpPointerDownEvent send: #dragStart: to: self
]

{ #category : #'event handling - private' }
CpDragEvent class >> dragEnd: aPointerUpEvent [

	| dragEvent |

	dragEvent := DragInstances at: aPointerUpEvent pointerId ifAbsent: [ ^ self ].

	"Remove temporary storage (for all situations)"
	DragInstances removeKey: aPointerUpEvent pointerId.

	"Update the final position of the drag event"
	dragEvent endPoint: aPointerUpEvent point.

	"Dispatch the event to allow updates to take place"
	dragEvent dispatch
]

{ #category : #'event handling - private' }
CpDragEvent class >> dragMove: aPointerMoveEvent [

	| dragEvent |

	dragEvent := DragInstances at: aPointerMoveEvent pointerId ifAbsent: [ ^ self ].

	"Update the latest position of the drag event"
	dragEvent addTracePoint: aPointerMoveEvent point.

	"Dispatch the event to allow updates to take place
	(and reset afterwards to allow dispatching again)"
	dragEvent
		dispatch ;
		reset
]

{ #category : #'event handling - private' }
CpDragEvent class >> dragStart: aPointerDownEvent [

	| dragEvent |

	dragEvent := DragInstances at: aPointerDownEvent pointerId ifAbsent: [ nil ].

	(dragEvent isNil or: [ (dragEvent hasSameOrigin: aPointerDownEvent) not ])
		ifTrue: [ DragInstances at: aPointerDownEvent pointerId put: (self newFromPointerEvent: aPointerDownEvent) ].

	"Prevent default browser behavior (like selecting text)"
	aPointerDownEvent preventDefault
]

{ #category : #'instance creation' }
CpDragEvent class >> newFromPointerEvent: aPointerEvent [

	^ self new
		type: #drag ;
		timeStamp: aPointerEvent timeStamp ;
		point: aPointerEvent point ;
		offset: aPointerEvent offset ;
		target: aPointerEvent target ;
		elements: aPointerEvent elements ;
		yourself
]

{ #category : #'class initialization' }
CpDragEvent class >> postInstall [

	super postInstall.

	DragInstances := Dictionary new.

	"Add dragmove/dragend at the toplevel element of the document,
	since dragging might move the pointer outside the drag target
	and therefore loose control. Handling it on the toplevel element
	will always succeed."
	CpHtmlElement documentBody
		when: CpPointerMoveEvent send: #dragMove: to: self ;
		when: CpPointerUpEvent send: #dragEnd: to: self
]

{ #category : #accessing }
CpDragEvent >> addTracePoint: aPoint [

	^ self tracePoints add: aPoint
]

{ #category : #accessing }
CpDragEvent >> endPoint [

	^ endPoint
]

{ #category : #accessing }
CpDragEvent >> endPoint: aPoint [

	endPoint := aPoint
]

{ #category : #testing }
CpDragEvent >> hasTracePoints [

	^ tracePoints isEmpty not
]

{ #category : #initialization }
CpDragEvent >> initialize [

	super initialize.

	tracePoints := OrderedCollection new
]

{ #category : #testing }
CpDragEvent >> isEnded [

	^ self endPoint notNil
]

{ #category : #accessing }
CpDragEvent >> lastPoint [

	^ self isEnded
		ifTrue: [ self endPoint ]
		ifFalse: [ self tracePoints last ]
]

{ #category : #accessing }
CpDragEvent >> offset [

	^ offset
]

{ #category : #accessing }
CpDragEvent >> offset: aPoint [

	offset := aPoint
]

{ #category : #printing }
CpDragEvent >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ', endPoint: '.
	self endPoint printOn: aStream.
	aStream nextPutAll: ', offset: '.
	self offset printOn: aStream
]

{ #category : #visiting }
CpDragEvent >> sendTo: anObject [

	anObject handleDragEvent: self
]

{ #category : #accessing }
CpDragEvent >> tracePoints [

	^ tracePoints
]
