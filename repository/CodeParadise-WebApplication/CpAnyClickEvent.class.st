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

{ #category : #combining }
CpAnyClickEvent class >> + aModifier [

	"Answer a  ClickAnnouncement combining the receiver with the specified modifier"

	^ (CpClickAnnouncementClass clickEventClass: self)
		+ aModifier ;
		yourself
]

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

	"Clean up any remaining event handlers after receiving the pointer or click event specified"

	| pointerId |

	pointerId := aPointerOrAnyClickEvent pointerId.
	ClickInstances removeKey: pointerId ifAbsent: [ "ignore" ].

	ClickTargets at: pointerId ifPresent: [ :targetsAndRequirements |

		"Remove the helper event listeners (added in #clickStart:)"
		targetsAndRequirements do: [ :each |
			each key removeInterestIn: CpPointerUpEvent for: CpAnyClickEvent ].

		"Now remove target and requirements collection itself"
		ClickTargets removeKey: pointerId ifAbsent: [ "ignore" ] ].

	self removeSupportingEvents
]

{ #category : #'event handling - private' }
CpAnyClickEvent class >> clickDone: aPointerUpEvent [

	"All click events should be handled, remove any pending handlers"

	self cleanUpAfterEvent: aPointerUpEvent
]

{ #category : #'event handling - private' }
CpAnyClickEvent class >> clickEnd: aPointerUpEvent [

	"Finalize (if possible) the click event.

	Implementation: see #clickStart:"

	| pointerId clickEvent |

	"Handle pending click event matching the specified pointerup event"
	pointerId := aPointerUpEvent pointerId.
	clickEvent := ClickInstances at: pointerId ifAbsent: [ ^ self ].

	"Update the click event"
	clickEvent updateWithPointerUpEvent: aPointerUpEvent.

	"Handle the matching target and requirements by dispatching the click event"
	(ClickTargets at: pointerId ifAbsent: [ ^ self ]) do: [ :each |
		(clickEvent matchesTargetAndRequirements: each)
			ifTrue: [ clickEvent dispatch ] ].

	"Do not remove ClickInstances or ClickTargets here. The event might bubble and reach more
	targets. Clean up is done in #clickDone: which is called when all click events have been
	handled and the event bubbled up to the html document itself."
]

{ #category : #'event handling - private' }
CpAnyClickEvent class >> clickInterrupted: aPointerLeaveEvent [

	"The pointer left the browser window and clicking is therefore interrupted"

	self cleanUpAfterEvent: aPointerLeaveEvent
]

{ #category : #'event handling - private' }
CpAnyClickEvent class >> clickStart: aPointerDownEvent [

	"Handle the click start using 'no key modifiers' as additional (ClickAnnouncement) requirement"

	self
		clickStart: aPointerDownEvent
		withClickAnnouncement: (CpClickAnnouncementClass noKeyModifierForClickEventClass: self)
]

{ #category : #'event handling - private' }
CpAnyClickEvent class >> clickStart: aPointerDownEvent withClickAnnouncement: aClickAnnouncementClass [

	"Keep track of our pointer down event (the possible start of a click),
	its requirements as specified in a ClickAnnouncement.

	Implementation:
	Create an instance of the receiver containing information about the
	pointer down event. When the pointer up event is triggered (see #clickEnd:)
	it will be dispatched, validating it still matches its requirements (like
	button, key modifiers, click duration) and target."

	| pointerId currentTarget |

	"Validate the click can be handled by the receiver"
	(self handlesClickEvent: aPointerDownEvent)
		ifFalse: [ ^ self ].

	"Create a unique click event for the specified PointerDown event.
	Prevent multiple occurrences from being created, so only add on first encounter."
	pointerId := aPointerDownEvent pointerId.
	ClickInstances at: pointerId ifAbsentPut: [ aPointerDownEvent asClickEvent ].

	"Keep track of the target (it will be lost once the pointerdown event is processed)
	and keep track of its requirements as specified by the ClickAnnouncementClass."
	currentTarget := aPointerDownEvent currentTarget.
	ClickTargets
		at: pointerId
		ifPresent: [ :targetAndRequirements | targetAndRequirements add: currentTarget -> aClickAnnouncementClass ]
		ifAbsentPut: [ OrderedCollection with: currentTarget -> aClickAnnouncementClass ].

	"Add supporting event handlers (now that clicking can actually start).
	Use CpAnyClickEvent to specify the subscriber because we don't want subclasses
	being specified explicitly. They should work the same and without explicit
	subscriber we would not be able to unsubscribe later."
	currentTarget when: CpPointerUpEvent send: #clickEnd: to: CpAnyClickEvent.

	self installSupportingEvents
]

{ #category : #announcing }
CpAnyClickEvent class >> handlesClickEvent: aClickEvent [

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

{ #category : #accessing }
CpAnyClickEvent class >> minimalLongPressDuration [

	"Answer the number of milliseconds which is considered minimal to describe
	a click as a long press click"

	^ 750
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

{ #category : #initialization }
CpAnyClickEvent class >> postInstallOnce [

	"Create temporary storage structure and a global event handler
	for the pointer 'up' event to clean up click events (see also: #addListenerTo:)."

	ClickInstances := IdentityDictionary new.
	ClickTargets := IdentityDictionary new.
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

	pointerDownEvent := aPointerDownEvent
]

{ #category : #testing }
CpAnyClickEvent >> isLongClick [

	"Answer whether the receiver represents a long press.

	Implementation:
	This method should not be used during the #clickStart: and #clickEnd:
	process. After/during dispatching it is valid to use."

	^ CpLongClickModifier isValidDuration: self duration
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

	^ CpShortClickModifier isValidDuration: self duration
]

{ #category : #'processing - private' }
CpAnyClickEvent >> matchesTargetAndRequirements: anAssociation [

	"Answer whether the receiver matches the target (key) and requirements (value)
	in the specified Association"

	^ anAssociation key == currentTarget
		and: [ anAssociation value isNil or: [ anAssociation value matchesClickEvent: self ] ]
]

{ #category : #accessing }
CpAnyClickEvent >> modifierCount [

	^ pointerUpEvent modifierCount
]

{ #category : #accessing }
CpAnyClickEvent >> modifiers [

	^ pointerUpEvent modifiers
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
	currentTarget := aPointerUpEvent currentTarget.
	pointerUpEvent := aPointerUpEvent
]
