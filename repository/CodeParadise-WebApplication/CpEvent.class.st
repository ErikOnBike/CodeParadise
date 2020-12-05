"
I am the base class for Events. I also implement the same protocol as the Announcement class for announcing. 

Implementation:
My class name should match the browser's event type (Event.type, see https://wiki.developer.mozilla.org/en-US/docs/Web/API/Event/type). So event type ""pointermove"" did become CpPointerMoveEvent. The class name prefix #Cp and the class name postfix #Event are discarded for comparison. Please prevent having similar names like #CpPointerMove or #CpPointermoveEvent, because only one will be used (more specific, last being installed in the ClientEnvironment).

"
Class {
	#name : #CpEvent,
	#superclass : #Object,
	#instVars : [
		'timeStamp',
		'type',
		'target',
		'element'
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

	[ anEvent dispatch ] on: Error do: [ :error | self crTrace: error description ]
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

{ #category : #sending }
CpEvent >> dispatch [

	"Dispatch the receiver by announcing it through its element"

	self element announce: self
]

{ #category : #accessing }
CpEvent >> element [

	"Answer the DOM element which has interest in the event.
	This might be different than the target (a descendant of the interested
	element) which received the event."

	^ element
]

{ #category : #accessing }
CpEvent >> element: anElement [

	element := anElement
]

{ #category : #announcing }
CpEvent >> prepareForDelivery [

	"This method will be executed once before subscriptions delivery.
	If nobody subscribed on me this method will not be called.
	It allows to put some heavy initialization logic here. It will be executed only 
	if there is interest on me
	See Announcement >> #prepareForDelivery"
]

{ #category : #printing }
CpEvent >> printOn: aStream [

	self class name printOn: aStream.
	aStream nextPutAll: ', type: '.
	self type printOn: aStream.
	aStream nextPutAll: ', timeStamp: '.
	self timeStamp printOn: aStream.
	aStream nextPutAll: ', target: '.
	self target printOn: aStream.
	aStream nextPutAll: ', element: '.
	self element printOn: aStream
]

{ #category : #visiting }
CpEvent >> sendTo: anObject [

	self subclassResponsibility
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

	"Answer the relative timestamp (a Number) for when the receiver was triggered"

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
