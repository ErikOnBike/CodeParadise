"
I am the base class for Events. I also implement the same protocol as the Announcement class for announcing. 

Implementation:
My class name should match the browser's event type (Event.type, see https://wiki.developer.mozilla.org/en-US/docs/Web/API/Event/type). So event type ""pointermove"" did become CpPointerMoveEvent. The class name prefix #Cp and the class name postfix #Event are discarded for comparison. Please prevent having similar names like #CpPointerMove or #CpPointermoveEvent, because only one will be used (more specific, last being installed in the ClientEnvironment).

Beware: CpPointerEnterEvent and CpPointerLeaveEvent work slightly differently than expected. These can only be used on the <body> tag.

"
Class {
	#name : #CpEvent,
	#superclass : #Object,
	#instVars : [
		'timeStamp',
		'type',
		'target',
		'elements',
		'currentElementIndex'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #announcing }
CpEvent class >> addListenerTo: anElement [

	"Add a listener for the receiver to the specified DOM element"

	self primAddListenerTo: anElement
]

{ #category : #'processing - private' }
CpEvent class >> createEventProcess [

	"Create an event process, register it and start it"

	| eventProcess |

	"Create process with highest priority to handle events as fast as possible"
	eventProcess := Process
		forContext: [ [

			"Wait for events to become available"
			Processor activeProcess suspend.

			"Dispatch the events"
			self dispatchEvents ] repeat ] asContext
		priority: Processor highestPriority.

	"Register the event process so the VM (plugin) can activate it"
	self primRegisterEventProcess: eventProcess.

	"Start the process (which will actually put it to sleep waiting for the first event)"
	eventProcess resume
]

{ #category : #'processing - private' }
CpEvent class >> dispatchEvent: anEvent [

	[ anEvent dispatch ] on: Error do: [ :error |
		self crTrace: 'Error when handling event ', anEvent printString.
		self crTrace: error description.
		self crTrace: error signalerContext printString ]
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

	"The receiver acts as a filter to determine whether subscribers who used the receiver as signaling tag (event identifier class or symbol)
	should receive incoming announcement. In particular, registering to a superclass will receive the announcements from all subclasses.
	See Announcement >> #handlesAnnouncement:"

	^ anAnnouncement class includesBehavior: self
]

{ #category : #'processing - private' }
CpEvent class >> latestEvents [

	<primitive: 'primitiveEventLatestEvents' module: 'CpDOMPlugin'>
	^ #()

]

{ #category : #accessing }
CpEvent class >> point: aPoint isSimilarTo: otherPoint [

	| distance |

	distance := aPoint dist: otherPoint.

	^ distance < self similarDistance
]

{ #category : #'class initialization' }
CpEvent class >> postInstall [

	super postInstall.

	"Create the event handler process once"
	self == CpEvent
		ifTrue: [ self createEventProcess ].

	self primRegisterEventClass: self
]

{ #category : #'processing - private' }
CpEvent class >> primAddListenerTo: anElement [

	<primitive: 'primitiveEventAddListenerTo:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #'processing - private' }
CpEvent class >> primRegisterEventClass: anEventClass [

	<primitive: 'primitiveEventRegisterClass:' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #'processing - private' }
CpEvent class >> primRegisterEventProcess: eventHandlerProcess [

	<primitive: 'primitiveEventRegisterProcess:' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #accessing }
CpEvent class >> similarDistance [

	^ 8
]

{ #category : #announcing }
CpEvent >> asAnnouncement [

	^ self
]

{ #category : #testing }
CpEvent >> autoPropagate [

	^ false
]

{ #category : #accessing }
CpEvent >> currentElement [

	"Answer the current (targetted) DOM element (similar to the DOM's currentTarget).
	Answer nil if the receiver has been dispatched to all interested elements."

	^ self elements at: currentElementIndex ifAbsent: [ nil ]
]

{ #category : #dispatching }
CpEvent >> dispatch [

	"Dispatch the receiver by announcing it through its element"

	(self currentElement ifNil: [ ^ self ])
		announce: self.

	"Propagate (bubble up to top level) to next interested element"
	self autoPropagate
		ifTrue: [ self propagate ]
]

{ #category : #accessing }
CpEvent >> elements [

	"Answer the DOM elements (from descendant to ancestor) which are interested in the event.
	This might be different than the target which received the event."

	^ elements
]

{ #category : #accessing }
CpEvent >> elements: anArray [

	elements := anArray
]

{ #category : #testing }
CpEvent >> hasSameOrigin: anEvent [

	"Answer whether the receiver and the specified Event share the same origin.

	Implementation:
	The same origin is shared if the event is targetted to the same DOM element and
	has the same timestamp of occurrence."

	^ self target = anEvent target and: [ self timeStamp = anEvent timeStamp ]
]

{ #category : #initialization }
CpEvent >> initialize [

	super initialize.

	"By default start at the first element of the elements
	(in #currentElement it is validated a first element exists)"
	currentElementIndex := 1
]

{ #category : #copying }
CpEvent >> postCopy [

	"Create a full copy of the receiver without shared state, to allow the copy to be dispatched
	or propagated without influencing the (original) receiver"

	super postCopy.

	"Implementation: Only elements need to be 'deep' copied, other fields can be shared."
	elements := elements copy
]

{ #category : #announcing }
CpEvent >> prepareForDelivery [

	"This method will be executed once before subscriptions delivery.
	If nobody subscribed on me this method will not be called.
	It allows to put some heavy initialization logic here. It will be executed only 
	if there is interest on me
	See Announcement >> #prepareForDelivery"
]

{ #category : #dispatching }
CpEvent >> preventDefault [

	"Prevent default browser behavior"

	self primPreventDefault
]

{ #category : #'dispatching - private' }
CpEvent >> primPreventDefault [

	<primitive: 'primitiveEventPreventDefault' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #printing }
CpEvent >> printOn: aStream [

	aStream nextPutAll: self class name.
	aStream nextPutAll: ', type: '.
	self type printOn: aStream.
	aStream nextPutAll: ', timeStamp: '.
	self timeStamp printOn: aStream.
	aStream nextPutAll: ', target: '.
	self target printOn: aStream.
	aStream nextPutAll: ', element: '.
	self currentElement printOn: aStream
]

{ #category : #dispatching }
CpEvent >> propagate [

	"Propagate the receiver to the next interested element"

	currentElementIndex > self elements size
		ifTrue: [ ^ self ].

	currentElementIndex := currentElementIndex + 1.
	self dispatch
]

{ #category : #dispatching }
CpEvent >> redispatch [

	"Dispatch the receiver again (any current propagation is ignored)"

	self
		reset ;
		dispatch
]

{ #category : #dispatching }
CpEvent >> reset [

	"Reset the receiver to allow dispatching again (from the deepest DOM element)"

	currentElementIndex := 1
]

{ #category : #dispatching }
CpEvent >> stopPropagation [

	"Stop propagation (bubbling) of the receiver"

	currentElementIndex := self elements size
]

{ #category : #accessing }
CpEvent >> target [

	"Answer the DOM element which received the event.
	In contrast with regular browser events, this target
	might be part of a shadow DOM."

	^ target
]

{ #category : #accessing }
CpEvent >> target: aDomElement [

	target := aDomElement
]

{ #category : #accessing }
CpEvent >> timeStamp [

	"Answer the relative timestamp (an Integer in millisecond resolution) for when the receiver was triggered"

	^ timeStamp
]

{ #category : #accessing }
CpEvent >> timeStamp: aNumber [

	"Set the relative timestamp for when the receiver was triggered"

	timeStamp := aNumber
]

{ #category : #accessing }
CpEvent >> type [

	^ type
]

{ #category : #accessing }
CpEvent >> type: aString [

	type := aString
]
