Class {
	#name : #CpDragEvent,
	#superclass : #CpUserInterfaceEvent,
	#instVars : [
		'offset',
		'tracePoints',
		'endPoint',
		'canceled'
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
CpDragEvent class >> dragCancel: aPointerEvent [

	| dragEvent |

	dragEvent := DragInstances at: aPointerEvent pointerId ifAbsent: [ ^ self ].

	"Remove temporary storage (for all situations)"
	DragInstances removeKey: aPointerEvent pointerId.

	"Cancel the drag event"
	dragEvent cancel.

	"Dispatch the event to allow updates to take place"
	dragEvent dispatch
]

{ #category : #'event handling - private' }
CpDragEvent class >> dragContinued: aPointerEnterEvent [

	"Validate there is still a drag (ie primary pointer is still down)"
	(aPointerEnterEvent isPrimaryButtonPressed)
		ifTrue: [ self dragMove: aPointerEnterEvent ]
		ifFalse: [ self dragCancel: aPointerEnterEvent ]
]

{ #category : #'event handling - private' }
CpDragEvent class >> dragEnd: aPointerUpEvent [

	| dragEvent |

	"Implementation: Ignore pointer up when a combination of buttons was pressed and
	a secondary button is released."
	aPointerUpEvent isPrimaryButtonPressed
		ifTrue: [ ^ self ].

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

	"Implementation: Only accept dragging if the primary button is still down."
	aPointerMoveEvent isPrimaryButtonPressed
		ifFalse: [ ^ self ].

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

	"Start a drag event if only the primary button is pressed"

	| dragEvent |

	aPointerDownEvent isOnlyPrimaryButtonPressed
		ifFalse: [ ^ self ].

	dragEvent := DragInstances at: aPointerDownEvent pointerId ifAbsent: [ nil ].

	(dragEvent isNil or: [ (dragEvent hasSameOrigin: aPointerDownEvent) not ])
		ifTrue: [ DragInstances at: aPointerDownEvent pointerId put: (self newFromPointerEvent: aPointerDownEvent) ]
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
	will always succeed.
	Dragging outside the browser area will keep the element in a
	dragged state, until the pointer enters the document again.
	In the future leaving the document could set a timer which
	could cancel the drag after some period of time."
	CpHtmlElement documentBody
		when: CpPointerMoveEvent send: #dragMove: to: self ;
		when: CpPointerUpEvent send: #dragEnd: to: self ;
		when: CpPointerEnterEvent send: #dragContinued: to: self" ;
		when: CpPointerLeaveEvent send: #dragInterrupted: to: self"
]

{ #category : #accessing }
CpDragEvent >> addTracePoint: aPoint [

	self tracePoints add: aPoint.
	self point: aPoint.

	^ aPoint
]

{ #category : #actions }
CpDragEvent >> cancel [

	canceled := true
]

{ #category : #accessing }
CpDragEvent >> endPoint [

	^ endPoint
]

{ #category : #accessing }
CpDragEvent >> endPoint: aPoint [

	endPoint := aPoint.
	self point: aPoint
]

{ #category : #testing }
CpDragEvent >> hasTracePoints [

	^ tracePoints isEmpty not
]

{ #category : #initialization }
CpDragEvent >> initialize [

	super initialize.

	tracePoints := OrderedCollection new.
	canceled := false
]

{ #category : #testing }
CpDragEvent >> isAtStart [ 

	^ tracePoints size = 1 
]

{ #category : #testing }
CpDragEvent >> isCanceled [

	^ canceled
]

{ #category : #testing }
CpDragEvent >> isEnded [

	^ self endPoint notNil
]

{ #category : #accessing }
CpDragEvent >> lastDelta [

	| lastPoint penultimatePoint |

	self tracePoints size < 2
		ifTrue: [ ^ 0 @ 0 ].

	lastPoint := self tracePoints last.
	penultimatePoint := self tracePoints nextToLast.

	^ lastPoint - penultimatePoint
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
