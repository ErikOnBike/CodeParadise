"
I am a SyntheticEvent representing the user clicking on DOM elements.

I exist as a convenience, because the default browser click event only works for primary clicks.
I represent any type of button being used to click on a DOM element. You can ask me which button
is pressed during the click event. You can also ask me for the modifiers which where pressed
when the click event took place (the key state during the pointer up event are deciding here).

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
		'ClickTargets'
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

{ #category : #'processing - private' }
CpAnyClickEvent class >> addListenerTo: anElement [

	"Add an event listener to the specified DOM element.

	Simulate our click event by setting up an event handler to catch the pointer
	'down' and 'up' events which are the start and end of a click. A global
	pointer 'up' event handler is installed in #postInstallOnce for clean up."

	anElement
		when: CpPointerDownEvent send: #clickStart: to: self ;
		when: CpPointerUpEvent send: #clickEnd: to: self
]

{ #category : #'processing - private' }
CpAnyClickEvent class >> clickEnd: aPointerUpEvent [

	"Finalize (if possible) the click event.

	Implementation: see #clickStart:"

	| pointerId |

	"Handle pending click event matching the specified pointerup event"
	pointerId := aPointerUpEvent pointerId.
	ClickInstances
		at: pointerId
		ifPresent: [ :clickEvent |

			| targetAndRequirements targetIndex |

			targetAndRequirements := ClickTargets at: pointerId ifAbsent: [ ^ self ].

			"Update the click event"
			(clickEvent updateWith: aPointerUpEvent)
				ifFalse: [

					"Failed to update, meaning a mismatching event. Perform clean up."
					self removeClickEvents: aPointerUpEvent.
					^ self ].

			"Find the first matching target and dispatch event"
			targetIndex := targetAndRequirements findFirst: [ :each | clickEvent matchesTargetAndRequirements: each ].
			targetIndex > 0
				ifTrue: [
self crTrace: 'ClickTargets before: ', (ClickTargets at: pointerId) size printString.
					"Remove all targets up to and including our current target to prevent
					repeated dispatching when listener is set on the same target multiple times.
					Use of #removeFirst is efficient since it does not require moving elements
					(and does not create a temporary list of elements like in #removeFirst:)."
					targetIndex timesRepeat: [ targetAndRequirements removeFirst ].
self crTrace: 'ClickTargets after: ', (ClickTargets at: pointerId) size printString.

					clickEvent dispatch ] ]
]

{ #category : #'processing - private' }
CpAnyClickEvent class >> clickStart: aPointerDownEvent [

	"Handle the click start using 'no key modifiers' as additional (ClickAnnouncement) requirement"

	self
		clickStart: aPointerDownEvent
		withClickAnnouncement: (CpClickAnnouncementClass noKeyModifierForClickEventClass: self)
]

{ #category : #'processing - private' }
CpAnyClickEvent class >> clickStart: aPointerDownEvent withClickAnnouncement: aClickAnnouncementClass [

	"Keep track of our pointer down event (the possible start of a click),
	its requirements as specified in a ClickAnnouncement.

	Implementation:
	Create an instance of the receiver containing information about the
	pointer down event. When the pointer up event is triggered (see #clickEnd:)
	it will be dispatched, validating it still matches its requirements (like
	button, key modifiers, click duration) and target."

	| pointerId currentTarget |
self crTrace: 'Click start ', aPointerDownEvent printString.
	"Validate the click can be handled by the receiver"
	(self handlesClickEvent: aPointerDownEvent)
		ifFalse: [ ^ self ].

	"Create a unique click event for the specified PointerDown event"
	pointerId := aPointerDownEvent pointerId.
	ClickInstances
		at: pointerId
		ifPresent: [ :clickEvent |
			(clickEvent originatedFrom: aPointerDownEvent)
				ifFalse: [
					self crTrace: 'Old click present from other PointerDownEvent ', aPointerDownEvent printString.
					ClickInstances at: pointerId put: aPointerDownEvent asClickEvent ] ]
		ifAbsentPut: [ aPointerDownEvent asClickEvent ].

	"Keep track of the target (it will be lost once the pointerdown event is processed)
	and keep track of its requirements as specified by the ClickAnnouncementClass."
	currentTarget := aPointerDownEvent currentTarget.
	ClickTargets
		at: pointerId
		ifPresent: [ :targetAndRequirements |

			"Do not store the same target, since the announcement mechanism already takes care of this"
			(targetAndRequirements anySatisfy: [ :each | each key == currentTarget ])
				ifTrue: [ self crTrace: 'Skip known target: ', aPointerDownEvent printString. ^ self ].

			"Store the unique target"
			self crTrace: 'Adding target ', currentTarget printString.
			targetAndRequirements add: currentTarget -> aClickAnnouncementClass ]
		ifAbsentPut: [ OrderedCollection with: currentTarget -> aClickAnnouncementClass ]
]

{ #category : #announcing }
CpAnyClickEvent class >> handlesClickEvent: aClickEvent [

	"Accept any kind of click.

	Implementation:
	This method is called with PointerDown and PointerUp events."

	^ true
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

	CpHtmlElement document
		when: CpPointerUpEvent send: #removeClickEvents: to: self
]

{ #category : #'processing - private' }
CpAnyClickEvent class >> removeClickEvents: aPointerUpEvent [

	"Remove the stored click events for the specified pointer"

	| pointerId |

self crTrace: 'Remove click events now that all clicks are handled'.
	pointerId := aPointerUpEvent pointerId.
	ClickInstances at: pointerId ifPresent: [ :clickEvent | self crTrace: 'Removing click event: ', clickEvent printString. clickEvent release ].
	ClickInstances removeKey: pointerId ifAbsent: [ "Ignore" ].

	ClickTargets removeKey: pointerId ifAbsent: [ "Ignore" ]
]

{ #category : #'processing - private' }
CpAnyClickEvent class >> removeListenerFrom: anElement [

	"Remove event listener from the specified DOM element.

	Impementation: see #addEventListenerTo:"
self crTrace: 'Remove anyclick listener'.
	CpPointerDownEvent removeListenerFrom: anElement.
	CpPointerUpEvent removeListenerFrom: anElement
]

{ #category : #dispatching }
CpAnyClickEvent class >> stopImmediatePropagationOf: aClickEvent [

	"Stop immediate propagation of the specified click event.

	Implementation clean up any remaining instances and targets.
	See also CpEvent >> #stopPropagation and
	CpEvent >> #stopImmediatePropagation to explain their difference."

	| pointerId |

self crTrace: 'Stop immediate, removing all events/targets'.
	pointerId := aClickEvent pointerId.
	ClickTargets removeKey: pointerId ifAbsent: [ "Ignore" ].
	ClickInstances removeKey: pointerId ifAbsent: [ "Ignore" ]
]

{ #category : #dispatching }
CpAnyClickEvent class >> stopPropagationOf: aClickEvent [

	"Stop propagation of the specified click event.

	Implementation:
	Clean up any remaining instances and targets which are NOT equal to
	the specified click event. See the comments in #clickStart: for further
	explanation of the internal structure used."

	| removeClickEvent pointerId |

	"Assume the click event itself will be removed, because no events
	will remain (general case). See also CpEvent >> #stopPropagation and
	CpEvent >> #stopImmediatePropagation to explain their difference."
	removeClickEvent := true.

	pointerId := aClickEvent pointerId.
	ClickTargets
		at: pointerId
		ifPresent: [ :targetAndRequirements |

			| removeIndex currentTarget |

			"Remove all events except for events aimed at same target.
			Events are added 'in bubbling order', so expect events to be
			at the front of the targets collection."
			currentTarget := aClickEvent currentTarget.
			removeIndex := targetAndRequirements findFirst: [ :each | each key ~= currentTarget ].
			removeIndex <= 1
				ifTrue: [ self crTrace: 'Remove all targets'. ClickTargets removeKey: pointerId ifAbsent: [ "Ignore" ] ]
				ifFalse: [
					"Some events remain, do not remove the click event just yet"
					removeClickEvent := false.
self crTrace: 'Keeping ', (removeIndex - 1) printString, ' elements to handle after stopPropagation'.
					ClickTargets at: pointerId put: (targetAndRequirements first: removeIndex - 1) ] ].

	removeClickEvent
		ifTrue: [ ClickInstances removeKey: pointerId ifAbsent: [ "Ignore" ] ]
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

{ #category : #testing }
CpAnyClickEvent >> originatedFrom: aPointerDownEvent [

	"Answer whether the receiver is created using the specified PointerDown event"

	^ pointerDownEvent == aPointerDownEvent
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

{ #category : #dispatching }
CpAnyClickEvent >> stopImmediatePropagation [

	"Stop propagation immediately. Not even 'same target' events will fire.

	Implementation:
	Stop the synthetic (receiver's) propagation mechanism.
	Clean up the receiver's internal state."

	super stopImmediatePropagation.

	self class stopImmediatePropagationOf: self
]

{ #category : #dispatching }
CpAnyClickEvent >> stopPropagation [

	"Stop propagation. Only 'same target' events will still fire.

	Implementation:
	Stop the synthetic (receiver's) propagation mechanism.
	Clean up the receiver's internal state."

	super stopPropagation.

	self class stopPropagationOf: self
]

{ #category : #'processing - private' }
CpAnyClickEvent >> updateWith: aPointerUpEvent [

	"Update the receiver for dispatching, by registering the PointerUpEvent.
	Answer a Boolean specifying whether the PointerUpEvent matches the receiver.

	The PointerUpEvent resembles the click event better (position, timestamp)
	than the PointerDownEvent registered during click start.
	After this update the receiver can be dispatched to the current target."

	timeStamp := aPointerUpEvent timeStamp.
	currentTarget := aPointerUpEvent currentTarget.
	pointerUpEvent := aPointerUpEvent.

	^ pointerDownEvent modifiers = pointerUpEvent modifiers
]
