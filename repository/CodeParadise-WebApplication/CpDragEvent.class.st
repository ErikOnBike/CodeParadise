"
I am a SyntheticEvent representing the user dragging a DOM element.

I exist as a convenience, because the default browser drag event is not flexible enough to perform
all kinds of custom behavior. A DropEvent exists to complete the full drag/drop behavior.

A drag event can be cancelled both manually and automatically (when moving outside the browser
area and then entering again without the primary pointer being down). Any event handling on the
drag event should therefore check for the drag event status using either #isCanceled and #isEnded.

The drag event will not propagate to parents like a click event does. Only a single element
can receive the drag events.

Implementation:
The combination of a PointerDown followed by a number of PointerMove and finishing off with a
PointerUp event is used to 'detect' a drag (and drop) is made. This is handled in the #dragStart:,
#dragMove and #dragEnd: methods. As soon as a PointerDown is announced the appropriate drag event
is already created and registered. If a matching PointerMove or PointerUp event is announced the
registered drag event will announce itself. This means the drag event will announce itself
repeatedly during the dragging (having different properties on every announcement representing
the 'new' state). When a drag moves outside the browser area or is otherwise interupted, this
will also be announced. A drag can also be stopped manually using #cancel, #stopPropagation or
#stopImmediatePropagation. Only #cancel will result in the drag event being announced to the
different listeners. This allows them to restore any state that was changed because of the
dragging. Since dragging does not actually bubble/propagate only a single listener will
receive this state change announcement.

"
Class {
	#name : #CpDragEvent,
	#superclass : #CpSyntheticEvent,
	#instVars : [
		'offset',
		'tracePoints',
		'endPoint',
		'canceled'
	],
	#classVars : [
		'DragInstances',
		'SupportingEventsInstalled'
	],
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #announcing }
CpDragEvent class >> addListenerTo: anElement [

	"Add a listener for the receiver to the specified DOM element.

	Implementation:
	Simulate a DragEvent by using PointerDown/PointerMove/PointerUp events.
	The PointerMove/PointerUp are registered when doing #dragStart:.
	See comment there."

	super addListenerTo: anElement.

	anElement when: CpPointerDownEvent send: #dragStart: to: self
]

{ #category : #'class initialization' }
CpDragEvent class >> beLoaded [

	"Load CpJavaScriptEvent which is used in #preventNativeDragEvents"

	CpJavaScriptEvent beLoaded
]

{ #category : #'event handling - private' }
CpDragEvent class >> dragCancel: aPointerEvent [

	| dragEvent |

	dragEvent := DragInstances at: aPointerEvent pointerId ifAbsent: [ ^ self ].

	"Remove temporary storage"
	DragInstances removeKey: aPointerEvent pointerId.
	self removeSupportingEvents.

	"Update the drag event"
	dragEvent updateWithPointerEvent: aPointerEvent.

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

	"Implementation: Ignore pointer up when the primary button is still pressed"
	aPointerUpEvent isPrimaryButtonPressed
		ifTrue: [ ^ self ].

	dragEvent := DragInstances at: aPointerUpEvent pointerId ifAbsent: [ ^ self ].

	"Remove temporary storage (it is okay to remove supporting events here since dragging
	does not bubble and no further events are to be expected, in contrast with AnyClickEvent)"
	DragInstances removeKey: aPointerUpEvent pointerId.
	self removeSupportingEvents.

	"Stop if no actual drag (move) happened"
	dragEvent hasMoved ifFalse: [ ^ self ].

	"Update the final position and timestamp of the drag event"
	dragEvent updateWithPointerEvent: aPointerUpEvent.

	"Mark the drag event ended"
	dragEvent end.

	"Dispatch the event to allow updates to take place"
	dragEvent dispatch
]

{ #category : #'event handling - private' }
CpDragEvent class >> dragInterrupted: aPointerLeaveEvent [

	"The pointer left the browser window and dragging is therefore interrupted.

	Implementation:
	Future version might include a timer which would invalidate a drag outside
	the window. Currently, re-entering the window with the primary button still
	down will continu the dragging.  See also #dragContinued:"
]

{ #category : #'event handling - private' }
CpDragEvent class >> dragMove: aPointerMoveEvent [

	| dragEvent |

	"Implementation: Only accept dragging if the primary button is still down."
	aPointerMoveEvent isPrimaryButtonPressed
		ifFalse: [ ^ self ].

	dragEvent := DragInstances at: aPointerMoveEvent pointerId ifAbsent: [ ^ self ].

	"Ignore move if not 'long' enough for initial move"
	(dragEvent hasMoved not and: [ (dragEvent point dist: aPointerMoveEvent point) < self minimalMovement ])
		ifTrue: [ ^ self ].

	"Update the latest position of the drag event"
	dragEvent updateWithPointerEvent: aPointerMoveEvent.

	"Dispatch the event to allow updates to take place"
	dragEvent dispatch
]

{ #category : #'event handling - private' }
CpDragEvent class >> dragStart: aPointerDownEvent [

	"Start a drag event if only the primary button is pressed.

	Implementation: Do not dispatch the drag start just yet.
	Wait for movement before actually dispatching a drag event
	(see also #dragMove:)."

	aPointerDownEvent isOnlyPrimaryButtonPressed
		ifFalse: [ ^ self ].

	"Create and register new drag event (if not already present)"
	DragInstances at: aPointerDownEvent pointerId ifAbsentPut: [ self newFromPointerEvent: aPointerDownEvent ].

	"Add supporting event handlers (now that dragging can actually start)"
	self installSupportingEvents
]

{ #category : #'event handling - private' }
CpDragEvent class >> installSupportingEvents [

	"Install (if needed) helper events when dragging started
	(when the first PointerDownEvent has occurred).

	Implementation:
	Add dragmove/dragend at the toplevel element of the document,
	since dragging might move the pointer outside the drag target
	and therefore loose control. Handling it on the toplevel element
	will always succeed.
	Dragging outside the browser area will keep the element in a
	dragged state, until the pointer enters the document again.
	In the future leaving the document could set a timer which
	could cancel the drag after some period of time.
	Pointer events are used to simulate these drag events."

	SupportingEventsInstalled ifTrue: [ ^ self ].

	[ CpHtmlElement document
		when: CpPointerMoveEvent send: #dragMove: to: self ;
		when: CpPointerUpEvent send: #dragEnd: to: self ;
		when: CpPointerEnterEvent send: #dragContinued: to: self ;
		when: CpPointerLeaveEvent send: #dragInterrupted: to: self
	] ensure: [ SupportingEventsInstalled := true ]
]

{ #category : #accessing }
CpDragEvent class >> minimalMovement [

	"Answer the minimal movement (in pixels as Float) to consider a drag is being started"

	^ 12.0
]

{ #category : #'instance creation' }
CpDragEvent class >> newFromPointerEvent: aPointerEvent [

	^ self basicNew
		initializeWithPointerEvent: aPointerEvent ;
		yourself
]

{ #category : #'class initialization' }
CpDragEvent class >> postInstallOnce [

	DragInstances := IdentityDictionary new.
	SupportingEventsInstalled := false.

	self preventNativeDragEvents
]

{ #category : #'event handling - private' }
CpDragEvent class >> preventNativeDragEvents [

	"The native drag support of Some browsers (like Firefox) need to be prevented"

	CpHtmlElement documentBody
		addEventListener: #dragstart handler: [ :event | event preventDefault ]
]

{ #category : #announcing }
CpDragEvent class >> removeListenerFrom: anElement [

	"Remove event listener from the specified DOM element.

	Impementation: see #addEventListenerTo:"

	super removeListenerFrom: anElement.

	CpPointerDownEvent removeListenerFrom: anElement
]

{ #category : #'event handling - private' }
CpDragEvent class >> removeSupportingEvents [

	"Remove (if needed) helper events for dragging (see #installSupportingEvents)"

	SupportingEventsInstalled ifFalse: [ ^ self ].
	DragInstances ifNotEmpty: [ ^ self ].

	[ CpHtmlElement document
		removeInterestIn: CpPointerMoveEvent for: self ;
		removeInterestIn: CpPointerUpEvent for: self ;
		removeInterestIn: CpPointerEnterEvent for: self ;
		removeInterestIn: CpPointerLeaveEvent for: self
	] ensure: [
		SupportingEventsInstalled := false ]
]

{ #category : #updating }
CpDragEvent class >> updateAll [

	"Update all instances by dispatching the most recent event"

	DragInstances valuesDo: [ :each | each dispatch ]
]

{ #category : #actions }
CpDragEvent >> cancel [

	canceled := true
]

{ #category : #actions }
CpDragEvent >> drop [

	"Create a drop event and dispatch it, if the receiver is ended and not canceled.
	Use #forceDrop to dispatch even if not ended and/or canceled."

	self ifCanceled: [ ^ self ].

	self forceDrop
]

{ #category : #actions }
CpDragEvent >> end [

	"Mark the receiver is ended (make the last added trace point the end point).

	Implementation:
	Repeatedly calling this method will have no effect."

	endPoint ifNotNil: [ ^ self ].

	endPoint := tracePoints removeLast
]

{ #category : #accessing }
CpDragEvent >> endPoint [

	^ endPoint
]

{ #category : #actions }
CpDragEvent >> forceDrop [

	"Dispatch drop event.
	
	See #drop for a more safe version of the drop beahvior.
	Using forceDrop allows to create 'droplets' during a drag
	event (on key presses for example)."

	CpDropEvent dispatchInstanceForDragEvent: self
]

{ #category : #testing }
CpDragEvent >> hasMoved [

	"Answer whether the receiver started moving.

	Implementation:
	The receiver's initial position is added, so moving starts with at least 2 trace points."

	^ tracePoints size > 1
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

	canceled := false
]

{ #category : #initialization }
CpDragEvent >> initializeWithPointerEvent: aPointerEvent [

	self initialize.

	timeStamp := aPointerEvent timeStamp.
	modifiers := aPointerEvent modifiers.
	currentTarget := aPointerEvent currentTarget.
	offset := aPointerEvent offset.
	tracePoints := OrderedCollection with: aPointerEvent point
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

	Implementation:
	The receiver has two tracepoints (ie initial and one movement taken place)"

	^ tracePoints size = 2
]

{ #category : #accessing }
CpDragEvent >> lastDelta [

	| lastPoint penultimatePoint |

	self hasMoved
		ifFalse: [ ^ 0 @ 0 ].

	lastPoint := tracePoints last.
	penultimatePoint := tracePoints nextToLast.

	^ lastPoint - penultimatePoint
]

{ #category : #accessing }
CpDragEvent >> offsetX [

	^ offset x
]

{ #category : #accessing }
CpDragEvent >> offsetY [

	^ offset y
]

{ #category : #accessing }
CpDragEvent >> point [

	"Answer the current point"

	^ endPoint ifNil: [ tracePoints last ]
]

{ #category : #printing }
CpDragEvent >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ', startPoint: ' ;
		print: self startPoint ;
		nextPutAll: ', tracePoints: ' ;
		print: self tracePoints size ;
		nextPutAll: ', point: ' ;
		print: self point ;
		nextPutAll: ', endPoint: ' ;
		print: self endPoint ;
		nextPutAll: ', canceled: ' ;
		print: self isCanceled
]

{ #category : #accessing }
CpDragEvent >> startPoint [

	^ tracePoints first
]

{ #category : #accessing }
CpDragEvent >> tracePoints [

	"Answer a collection of Points representing the trace the drag made.
	The trace points will include the 'historic' point, ie not the current drag point."

	^ tracePoints
]

{ #category : #'processing - private' }
CpDragEvent >> updateWithPointerEvent: aPointerEvent [

	timeStamp := aPointerEvent timeStamp.
	modifiers := aPointerEvent modifiers.
	tracePoints add: aPointerEvent point
]
