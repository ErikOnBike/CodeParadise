"
I am a SyntheticEvent representing the user clicking on DOM elements.

I exist as a convenience, because the default browser click event only works for primary clicks
and does not distinguish between modifiers being pressed.
I represent any type of button being used to click on a DOM element. You can ask me which button
is pressed during the click event. You can also ask me for the modifiers which where pressed
when the click event took place (the key state during the pointer up event are deciding here).

Like most applications, I do not support multi-button clicks (ie clicking both primary and secundary
buttons simultaneously).

A number of my subclasses allow for describing the need for some specific events like
the PrimaryButton being used to click (ie CpPrimaryClickEvent) or the SecondaryButton. I can be
used in combination with CpKeyModifier and CpClickDurationModifier to specify my required
behaviour.

For example:
	aDomElement
		when: CpAnyClickEvent send: #anyButtonNoModifiers to: self.
	aDomElement
		when: CpPrimaryClickEvent send: #onlyPrimaryButtonNoModifiers to: self.
	aDomElement
		when: CpPrimaryClickEvent + CpShiftModifier send: #primaryButtonAndShiftKey to: self.
	aDomElement
		when: CpSecondaryClickEvent + CpMetaModifier + CpLongClickModifier send: #longSecondaryButtonAndMetaKey to: self.

BE AWARE: because of my implementation (see below) I will not work correctly if a PointerDown
or PointerUp event is being stopped using either #stopPropagation or #stopImmediatePropagation.
In such situations the regular CpClickEvent will work, but still requires the additional check
for modifiers being used.

Implementation:
The combination of a PointerDown followed by a PointerUp event is used to 'detect' a click is
made. This is handled in the #clickStart: and #clickEnd: methods. As soon as a PointerDown is
announced the appropriate click event is already created and registered. If a matching PointerUp
event is announced the registered click event will announce itself. When the PointerUp does not
match (different position or different modifiers pressed) the created click event will simply
be disgarded.
"
Class {
	#name : #CpAnyClickEvent,
	#superclass : #CpSyntheticEvent,
	#instVars : [
		'pointerDownEvent',
		'pointerUpEvent'
	],
	#classVars : [
		'ClickInstances',
		'ClickTargets',
		'SupportingEventsInstalled'
	],
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #announcing }
CpAnyClickEvent class >> addListenerTo: anElement [

	"Add an event listener to the specified DOM element.

	Simulate our click event by setting up an event handler to catch the pointer
	'down' event which is the start of a click. A pointer 'up' event is installed
	once the click is started."

	super addListenerTo: anElement.

	anElement when: CpPointerDownEvent send: #clickStart: to: self
]

{ #category : #'event handling - private' }
CpAnyClickEvent class >> cleanUpAfterEvent: aPointerOrAnyClickEvent [

	"Clean up any remaining event handlers after receiving the pointer event"

	ClickInstances removeKey: aPointerOrAnyClickEvent pointerId ifAbsent: [ "ignore" ].

	"Remove any listeners for the pointer up event"
	ClickTargets do: [ :each | each removeInterestIn: CpPointerUpEvent for: CpAnyClickEvent ].
	ClickTargets removeAll.

	self removeSupportingEvents
]

{ #category : #'event handling - private' }
CpAnyClickEvent class >> clickDone: aPointerUpEvent [

	"All click events have been handled, remove any pending handlers"

	self cleanUpAfterEvent: aPointerUpEvent
]

{ #category : #'event handling - private' }
CpAnyClickEvent class >> clickEnd: aPointerUpEvent [

	"Finalize the click event.

	Implementation:
	Find the correct pre-created AnyClickEvent instance and update it with the
	current information. This means the currentTarget is set, as well as the
	duration which becomes available.

	Handle all individual pointer up events (this method, like #clickStart: will be
	invoked for all listeners). Not all registered targets might actually receive
	the pointer up event. Not only because of stopping propagation, but a small
	pointer move might have but a target just outside the click position. A future
	version might prevent moving the pointer too much (moving cancels the click),
	but even then a small move might make a (pointer down) target to be missed on
	pointer up.

	Do not remove ClickInstances here. The event might bubble and reach more targets.
	For every (nested) target this method is invoked.
	Clean up is done in #clickDone: which is called when all click events have been
	handled and the event bubbled up to the html document itself. See also the method
	#installSupportingEvents for clean up code.

	See also #clickStart: for more details."

	| clickEvent |

	"Handle pending click event matching the specified pointerup event"
	clickEvent := ClickInstances at: aPointerUpEvent pointerId ifAbsent: [ ^ self ].

	"Dispatch event once per target (annoucement mechanism already reaches all listeners)"
	clickEvent currentTarget == aPointerUpEvent currentTarget
		ifTrue: [ ^ self ].

	"Update the click event with latest timestamp, modifier and duration information"
	clickEvent updateWithPointerUpEvent: aPointerUpEvent.

	"Dispatch the click event"
	clickEvent dispatch
]

{ #category : #'event handling - private' }
CpAnyClickEvent class >> clickInterrupted: aPointerLeaveEvent [

	"The pointer left the browser window and clicking is therefore interrupted"

	self cleanUpAfterEvent: aPointerLeaveEvent
]

{ #category : #'event handling - private' }
CpAnyClickEvent class >> clickStart: aPointerDownEvent [

	"The start of an AnyClickEvent is triggered by a pointer down event.

	Implementation:
	The pointer down event can be announced for multiple DOM elements under the pointer
	(overlapping DOM elements). In such a situation, this method will be called multiple
	times consecutively. We only need a single instance of AnyClickEvent, because it will
	be dispatched to the different (matching) DOM elements."

	| currentTarget |

	"Validate the click can be handled by the receiver"
	(self handlesClickEvent: aPointerDownEvent)
		ifFalse: [ ^ self ].

	"Create the single instance (per pointer id)"
	ClickInstances at: aPointerDownEvent pointerId ifAbsentPut: [ aPointerDownEvent asClickEvent ].

	"Add supporting event handlers (now that clicking can actually start).
	Use CpAnyClickEvent to specify the subscriber because we don't want subclasses
	being specified explicitly. They should work the same and without explicit
	subscriber we would not be able to unsubscribe later."
	currentTarget := aPointerDownEvent currentTarget.
	currentTarget when: CpPointerUpEvent send: #clickEnd: to: CpAnyClickEvent.
	ClickTargets add: currentTarget.

	self installSupportingEvents
]

{ #category : #'event handling - private' }
CpAnyClickEvent class >> handlesClickEvent: aPointerEvent [

	"Accept any kind of click.

	Implementation:
	This method is called with PointerDown and PointerUp events."

	^ true
]

{ #category : #'event handling - private' }
CpAnyClickEvent class >> installSupportingEvents [

	"Install (if needed) helper events when clicking started
	(when the first PointerDownEvent has occurred).

	Implementation:
	Add additional event handlers. Use pointer up event on the document
	itself to identify the event bubbled up to the top and is therefore done.
	The pointer leave event on the same document means the click is interrupted
	and can't be ended in a normal way.
	Do NOT use 'self' to specify where the event should be sent to, but specify
	CpAnyClickEvent explicitly. This is to prevent subclasses (which can be used
	as well) from being the subscriber here. In #removeSupportingEvents there
	would be no way of knowing which subclass has been used. And there should be
	no difference."

	SupportingEventsInstalled ifTrue: [ ^ self ].

	[ CpHtmlElement document
		when: CpPointerUpEvent send: #clickDone: to: CpAnyClickEvent ;
		when: CpPointerLeaveEvent send: #clickInterrupted: to: CpAnyClickEvent
	] ensure: [ SupportingEventsInstalled := true ]
]

{ #category : #'instance creation' }
CpAnyClickEvent class >> newFromPointerEvent: aPointerDownEvent [

	"Answer a new instance of the receiver using a PointerDownEvent
	as the start of the click. When a matching PointerUpEvent is
	provided it allows the event to be dispatched (or if no match
	to be disgarded)."

	^ self basicNew
		initializeWithPointerDownEvent: aPointerDownEvent ;
		yourself
]

{ #category : #'class initialization' }
CpAnyClickEvent class >> postInstallOnce [

	"Create temporary storage structure and a global event handler
	for the pointer 'up' event to clean up click events (see also: #addListenerTo:)."

	ClickInstances := Dictionary new.
	ClickTargets := OrderedCollection new.
	SupportingEventsInstalled := false
]

{ #category : #announcing }
CpAnyClickEvent class >> removeListenerFrom: anElement [

	"Remove event listener from the specified DOM element.

	Impementation: see #addEventListenerTo:"

	super removeListenerFrom: anElement.

	CpPointerDownEvent removeListenerFrom: anElement
]

{ #category : #'event handling - private' }
CpAnyClickEvent class >> removeSupportingEvents [

	"Remove (if needed) helper events for clicking (see #installSupportingEvents)"

	SupportingEventsInstalled ifFalse: [ ^ self ].
	ClickInstances ifNotEmpty: [ ^ self ].

	[ CpHtmlElement document
		removeInterestIn: CpPointerUpEvent for: CpAnyClickEvent ;
		removeInterestIn: CpPointerLeaveEvent for: CpAnyClickEvent
	] ensure: [
		SupportingEventsInstalled := false ]
]

{ #category : #accessing }
CpAnyClickEvent >> button [

	^ pointerUpEvent button
]

{ #category : #accessing }
CpAnyClickEvent >> clientX [

	^ pointerUpEvent clientX
]

{ #category : #accessing }
CpAnyClickEvent >> clientY [

	^ pointerUpEvent clientY
]

{ #category : #accessing }
CpAnyClickEvent >> duration [

	"Answer the duration (as Integer in milliseconds) of the click
	(this is the time between pointer down and pointer up). This method
	will only answer a valid value if the pointer (up) event is set."

	^ pointerUpEvent timeStamp - pointerDownEvent timeStamp
]

{ #category : #testing }
CpAnyClickEvent >> hasOriginatedFrom: aPointerDownEvent [

	"Answer whether the receiver is created using the specified PointerDown event"

	^ pointerDownEvent == aPointerDownEvent
]

{ #category : #initialization }
CpAnyClickEvent >> initializeWithPointerDownEvent: aPointerDownEvent [

	"Initialize the receiver with the click start event (i.e. PointerDownEvent).

	Implementation:
	A partial click event is created by keeping the PointerDownEvent. Further
	processing and dispatching is allowed when the click event end (i.e. PointerUpEvent
	is received).
	The required<Xyz> instance variables are used to keep track what exact type
	of click is requested. When these instance variables are kept nil, it means
	there is no requirement set."

	self initialize.

	timeStamp := aPointerDownEvent timeStamp.
	modifiers := aPointerDownEvent modifiers.
	pointerDownEvent := aPointerDownEvent
]

{ #category : #testing }
CpAnyClickEvent >> isLongClick [

	"Answer whether the receiver represents a long press.

	Implementation:
	This method should not be used during the #clickStart: and #clickEnd:
	process. After/during dispatching it is valid to use."

	^ CpLongClick matches: self
]

{ #category : #testing }
CpAnyClickEvent >> isPrimaryButtonPressed [

	^ self button = 0
]

{ #category : #testing }
CpAnyClickEvent >> isSecondaryButtonPressed [

	^ self button = 2
]

{ #category : #testing }
CpAnyClickEvent >> isShortClick [

	"Answer whether the receiver represents a short press.

	Implementation:
	This method should not be used during the #clickStart: and #clickEnd:
	process. After/during dispatching it is valid to use."

	^ CpShortClick matches: self
]

{ #category : #accessing }
CpAnyClickEvent >> movementX [

	^ pointerUpEvent screenX - pointerDownEvent screenX
]

{ #category : #accessing }
CpAnyClickEvent >> movementY [

	^ pointerUpEvent screenY - pointerDownEvent screenY
]

{ #category : #accessing }
CpAnyClickEvent >> offset [

	^ pointerUpEvent offset
]

{ #category : #accessing }
CpAnyClickEvent >> offsetX [

	^ pointerUpEvent offsetX
]

{ #category : #accessing }
CpAnyClickEvent >> offsetY [

	^ pointerUpEvent offsetY
]

{ #category : #accessing }
CpAnyClickEvent >> pageX [

	^ pointerUpEvent pageX
]

{ #category : #accessing }
CpAnyClickEvent >> pageY [

	^ pointerUpEvent pageY
]

{ #category : #accessing }
CpAnyClickEvent >> point [

	^ pointerUpEvent point
]

{ #category : #accessing }
CpAnyClickEvent >> pointerId [

	^ pointerUpEvent pointerId
]

{ #category : #printing }
CpAnyClickEvent >> printOn: aStream [

	super printOn: aStream.
	pointerUpEvent
		ifNotNil: [
			aStream
				nextPutAll: ', point: ' ;
				print: self point ;
				nextPutAll: ', currentTarget: ' ;
				print: self currentTarget ;
				nextPutAll: ', target: ' ;
				print: self target ;
				nextPutAll: ', offset: ' ;
				print: self offset ;
				nextPutAll: ', button: ' ;
				print: self button ;
				nextPutAll: ', modifiers: ' ;
				print: self modifiers ;
				nextPutAll: ', duration: ' ;
				print: self duration ]
		ifNil: [
			aStream
				nextPutAll: ', preliminary based on pointerDownEvent: ' ;
				print: pointerDownEvent ]
]

{ #category : #initialization }
CpAnyClickEvent >> release [

	pointerDownEvent := nil.
	pointerUpEvent := nil.

	super release
]

{ #category : #accessing }
CpAnyClickEvent >> screenX [

	^ pointerUpEvent screenX
]

{ #category : #accessing }
CpAnyClickEvent >> screenY [

	^ pointerUpEvent screenY
]

{ #category : #accessing }
CpAnyClickEvent >> target [

	^ pointerUpEvent target
]

{ #category : #'processing - private' }
CpAnyClickEvent >> updateWithPointerUpEvent: aPointerUpEvent [

	"Update the receiver for dispatching, by registering the PointerUpEvent.

	Implementation:
	The PointerUpEvent resembles the click event better (position, timestamp)
	than the PointerDownEvent registered during click start.
	After this update the receiver can be dispatched to the current target."

	timeStamp := aPointerUpEvent timeStamp.
	modifiers := aPointerUpEvent modifiers.
	currentTarget := aPointerUpEvent currentTarget.
	pointerUpEvent := aPointerUpEvent
]
