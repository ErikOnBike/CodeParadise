Class {
	#name : #CpDragEvent,
	#superclass : #CpUserInterfaceEvent,
	#instVars : [
		'offset',
		'tracePoints',
		'endPoint',
		'modifiers',
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
	dragEvent dispatch.

	"If drag is finished successfully (and not canceled during ending), create a drop event"
	dragEvent ifCanceled: [ ^ self ].
	CpDropEvent dispatchInstanceForDragEvent: dragEvent pointerEvent: aPointerUpEvent
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
	dragEvent timeStamp: aPointerMoveEvent timeStamp.

	"Dispatch the event to allow updates to take place"
	dragEvent dispatch
]

{ #category : #'event handling - private' }
CpDragEvent class >> dragStart: aPointerDownEvent [

	"Start a drag event if only the primary button is pressed"

	| dragEvent |

	aPointerDownEvent isOnlyPrimaryButtonPressed
		ifFalse: [ ^ self ].

	dragEvent := DragInstances at: aPointerDownEvent pointerId ifAbsent: [ nil ].

	(dragEvent isNil or: [ (dragEvent hasSameOrigin: aPointerDownEvent) not ])
		ifTrue: [ dragEvent := DragInstances at: aPointerDownEvent pointerId put: (self newFromPointerEvent: aPointerDownEvent) ].

	"Dispatch the new DragEvent"
	dragEvent dispatch

]

{ #category : #'instance creation' }
CpDragEvent class >> newFromPointerEvent: aPointerEvent [

	^ self new
		type: #drag ;
		timeStamp: aPointerEvent timeStamp ;
		modifiers: aPointerEvent modifiers ;
		point: aPointerEvent point ;
		offset: aPointerEvent offset ;
		target: aPointerEvent target ;
		elements: aPointerEvent elements copy ;
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

{ #category : #'updating screen' }
CpDragEvent class >> updateAll [

	"Update all instances by dispatching the most recent event"

	DragInstances valuesDo: [ :each | each redispatch ]
]

{ #category : #accessing }
CpDragEvent >> addTracePoint: aPoint [

	self tracePoints add: self point.
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
CpDragEvent >> ifCanceled: aBlock [

	^ canceled
		ifTrue: [ aBlock value ]
		ifFalse: [ self ]
]

{ #category : #testing }
CpDragEvent >> ifEnded: aBlock [

	^ endPoint
		ifNotNil: [ aBlock value ]
		ifNil: [ self ]
]

{ #category : #testing }
CpDragEvent >> ifStarted: aBlock [

	"Evaluate the specified Block if the receiver is just started and made its first move"

	^ self isStarted
		ifTrue: [ aBlock value ]
		ifFalse: [ self ]
]

{ #category : #initialization }
CpDragEvent >> initialize [

	super initialize.

	tracePoints := OrderedCollection new.
	canceled := false
]

{ #category : #testing }
CpDragEvent >> isCanceled [

	^ canceled
]

{ #category : #testing }
CpDragEvent >> isEnded [

	^ endPoint notNil
]

{ #category : #testing }
CpDragEvent >> isStarted [

	"Answer whether the receiver is just started and made its first move.

	Implementation: Receiver has a single tracepoint (ie one movement taken place)"

	^ tracePoints size = 1
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
CpDragEvent >> modifiers [

	^ modifiers
]

{ #category : #accessing }
CpDragEvent >> modifiers: anInteger [

	modifiers := anInteger
]

{ #category : #accessing }
CpDragEvent >> offset [

	^ offset
]

{ #category : #accessing }
CpDragEvent >> offset: aPoint [

	offset := aPoint
]

{ #category : #copying }
CpDragEvent >> postCopy [

	"Create a full copy of the receiver without shared state, to allow the copy to be dispatched
	or propagated without influencing the (original) receiver"

	super postCopy.

	"Implementation: Only tracepoints need to be 'deep' copied, other fields can be shared."
	tracePoints := tracePoints copy
]

{ #category : #printing }
CpDragEvent >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ', endPoint: ' ;
		print: self endPoint ;
		nextPutAll: ', offset: ' ;
		print: self offset
]

{ #category : #accessing }
CpDragEvent >> startPoint [

	^ self tracePoints first
		ifNil: [ self point ]
]

{ #category : #accessing }
CpDragEvent >> tracePoints [

	"Answer a collection of Points representing the trace the drag made.
	The trace points will include the 'historic' point, ie not the current drag point."

	^ tracePoints
]
