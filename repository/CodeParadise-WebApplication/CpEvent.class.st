"
I am the base class for actual browser Events. I also implement the same protocol as the Announcement class for announcing. 

Implementation:
My class name should match the browser's event type (Event.type, see https://wiki.developer.mozilla.org/en-US/docs/Web/API/Event/type). So event type ""pointermove"" did become CpPointerMoveEvent. The class name prefix #Cp and the class name postfix #Event are discarded for comparison. Please prevent having similar names like #CpPointerMove or #CpPointermoveEvent, because only one will be used (more specific, last being installed in the ClientEnvironment).

In a few places my (or one of my subclass's) behavior is slightly different than default browser behavior and/or the behavior is limited in some way.
- I only support event bubbling (ie not capturing, see https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Building_blocks/Events#event_bubbling_and_capture)
- Some events are 'throttled', meaning not every browser event triggered will actually be handled in the Smalltalk code (especially pointermove and wheel events). This is a performance trade off.
- The default event handling for somethrottled events (like wheel events) is prevented since they would otherwise interfere with custom behavior.

Implementation:
Because the Announcement model (as used in CodeParadise) and the browser event model work slightly differently (browser events are registered individually and DOM announcements are registered per DOM element), internally browser events are de-duplicated per DOM element. This is visible for examply in CpAnyClickEvent class >> #clickStart:withClickAnnouncement:.

"
Class {
	#name : #CpEvent,
	#superclass : #CpBaseEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #conditionals }
CpEvent class >> addConditionsToDenySpecialsTo: aConditionalEvent [

	"Add condition to specified conditional event which prevents
	special conditions to be allowed. By default all modifiers are denied.

	Subclasses might add other conditions."

	aConditionalEvent addCondition: CpNoModifiersDown
]

{ #category : #'processing - private' }
CpEvent class >> addListenerTo: anElement [

	"Add a browser event listener to the specified element"

	<primitive: 'primitiveEventAddListenerTo:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #'processing - private' }
CpEvent class >> dispatchEvent: anEvent [

	[ anEvent dispatch ] on: Error do: [ :error |

		"Announce the error (for debugger or otherwise)"
		CpExceptionAnnouncer announceException: error.

		self errorCr: 'Error when handling event ', anEvent printString.
		self errorCr: error description.
		self errorCr: error signalerContext printString ]
]

{ #category : #'processing - private' }
CpEvent class >> dispatchEvents [

	"Handle events.
	
	Implementation:
	Try to prevent long running synchronous calls for performance (jitter/yank in UI)."

	self latestEvents do: [ :each | self dispatchEvent: each ]
]

{ #category : #announcing }
CpEvent class >> handlesAnnouncement: anAnnouncement [

	"Answer whether the specified Announcement can be handled by the receiver.
	If the Announcement is already stopped, prevent further handling."

	^ (super handlesAnnouncement: anAnnouncement)
		and: [ anAnnouncement isStopped not ]
]

{ #category : #'processing - private' }
CpEvent class >> isListenedToOn: anElement [

	"Answer whether a browser event listener is installed in the specified element"

	<primitive: 'primitiveEventIsListenedToOn:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #testing }
CpEvent class >> isPoint: aPoint similarTo: otherPoint [

	"Answer whether the two specified Points are close together and therefore seamingly similar"

	| distance |

	distance := aPoint dist: otherPoint.

	^ distance < self similarDistance
]

{ #category : #'processing - private' }
CpEvent class >> latestEvents [

	"Answer a collection of browser events which are pending/need handling.

	Implementation:
	In most cases this will result in an Array with a single event. For some
	throttled events (like pointermove) it may contain a few events."

	<primitive: 'primitiveEventLatestEvents' module: 'CpDOMPlugin'>
	^ #()
]

{ #category : #'class initialization' }
CpEvent class >> postInstall [

	super postInstall.

	self registerEventClass: self forType: self type
]

{ #category : #'class initialization' }
CpEvent class >> postInstallOnce [

	"Register the event handler process once"

	self registerEventProcess
]

{ #category : #'processing - private' }
CpEvent class >> registerEventClass: anEventClass forType: aString [

	"Register the specified event class in the browser
	(creates binding between browser and Smalltalk events)"

	<primitive: 'primitiveEventRegisterClass:forType:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #'processing - private' }
CpEvent class >> registerEventProcess [

	"Register an event process.

	Implementation:
	After each loop it will suspend itself to be resumed by the internal event mechanism."

	| process |

	process := Process
		forContext: [
			"Use #whileTrue: because it is inlined"
			[ true ] whileTrue: [
				self dispatchEvents.
				Processor activeProcess suspend ] ] asContext
		priority: Processor highestPriority.

	process name: 'Event'.

	self registerEventProcess: process
]

{ #category : #'processing - private' }
CpEvent class >> registerEventProcess: eventHandlerProcess [

	"Register the process which handles events to allow it to be activated on events"

	<primitive: 'primitiveEventRegisterProcess:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #'processing - private' }
CpEvent class >> removeListenerFrom: anElement [

	"Remove a browser event listener from the specified element"

	<primitive: 'primitiveEventRemoveListenerFrom:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #accessing }
CpEvent class >> similarDistance [

	"Maximum distance in pixels (as a Float value) between two points to consider the similar"

	^ 8.0
]

{ #category : #accessing }
CpEvent class >> type [

	"Answer the JavaScript type (a String) representing the receiver"

	^ (self nameWithoutPrefix withoutSuffix: #Event) asLowercase
]

{ #category : #'accessing - private' }
CpEvent >> copy [

	"Answer a copy of the receiver.
	BE AWARE: The copy is NOT a fully functional event. Use it only within the Smalltalk world.
	The copy is already 'stopped' so #isStopped will answer true."

	<primitive: 'primitiveEventCopy' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #accessing }
CpEvent >> currentTarget [

	"Answer the current targetted DOM element (might be different from #target which could be a descendant)"

	^ self propertyAt: #currentTarget
]

{ #category : #testing }
CpEvent >> isStopped [

	"Answer whether the receiver is stopped by either
	#stopPropagation or #stopImmediatePropagation. In the former
	case, false is answered on any event listeners on the same
	target."

	<primitive: 'primitiveEventIsStopped' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #accessing }
CpEvent >> modifiers [

	"Answer an Integer specifying the different modifiers pressed.
	See superclass' implementation for details."

	<primitive: 'primitiveEventModifiers' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #dispatching }
CpEvent >> preventDefault [

	"Prevent the default browser behavior from being performed"

	<primitive: 'primitiveEventPreventDefault' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #printing }
CpEvent >> printOn: aStream [

	aStream
		nextPutAll: self class name ;
		nextPutAll: ', type: ' ;
		print: self type ;
		nextPutAll: ', timeStamp: ' ;
		print: self timeStamp ;
		nextPutAll: ', target: ' ;
		print: self target ;
		nextPutAll: ', currentTarget: ' ;
		print: self currentTarget
]

{ #category : #'accessing - private' }
CpEvent >> propertyAt: nameString [

	"Answer the value (String, Number, Boolean or nil) of the specified property of the receiver"

	<primitive: 'primitiveEventPropertyAt:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #dispatching }
CpEvent >> stopImmediatePropagation [

	"Stop immediate propagation (bubbling) of the receiver. Not even listeners on the
	current target will receive this event. Use #stopPropagation instead
	to allow other listeners on the current target to receive this event."

	<primitive: 'primitiveEventStopImmediatePropagation' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #dispatching }
CpEvent >> stopPropagation [

	"Stop propagation (bubbling) of the receiver. Other listeners on the
	current target will receive this event. Use #stopImmediatePropagation
	instead to prevent any listener from receiving this event."

	<primitive: 'primitiveEventStopPropagation' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #accessing }
CpEvent >> target [

	"Answer the DOM element which received the event"

	^ self propertyAt: #target
]

{ #category : #accessing }
CpEvent >> timeStamp [

	"Answer the relative timestamp (an Integer in millisecond resolution) for when the receiver was triggered"

	^ self propertyAt: #timeStamp
]

{ #category : #accessing }
CpEvent >> type [

	"Answer the type of event (a String)"

	^ self propertyAt: #type
]
