Class {
	#name : #CpDropEvent,
	#superclass : #CpUserInterfaceEvent,
	#instVars : [
		'dragEvent',
		'pointerId'
	],
	#classVars : [
		'DropInstances'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #announcing }
CpDropEvent class >> addListenerTo: anElement [

	"Add a listener for the receiver to the specified DOM element.

	Implementation: Simulate a DropEvent by using a PointerUp event.
	This allows the event to be set on an element and furthermore receive
	necessary information like a target, timestamp and elements."

	super addListenerTo: anElement.

	anElement
		when: CpPointerUpEvent send: #updateInstanceFromPointerEvent: to: self
]

{ #category : #'event handling' }
CpDropEvent class >> dispatchInstanceForDragEvent: aDragEvent [

	"Dispatch an instance of the receiver based on the specified DragEvent"

	| dropEvent dropAssoc |

	"Find the drop event belonging to the specified drag event"
	dropAssoc := DropInstances associations
		detect: [ :each | each value isForDragEvent: aDragEvent ]
		ifNone: [ ^ self ].
	dropEvent := dropAssoc value.

	"Remove drop instance to prevent multiple dispatches"
	DropInstances removeKey: dropAssoc key.

	dropEvent dispatch
]

{ #category : #'instance creation' }
CpDropEvent class >> newFromDragEvent: aDragEvent withPointerId: anObject [

	"Create a new instance of the receiver from the specified DragEvent and pointer id.

	Implementation: This method will not answer a full DropEvent instance. Dispatching it
	will not have any effect. See #dropped: where DropEvent is fulfilled and dispatched."

	^ self basicNew
		initializeWithDragEvent: aDragEvent pointerId: anObject ;
		yourself
]

{ #category : #'class initialization' }
CpDropEvent class >> postInstall [

	super postInstall.

	DropInstances := Dictionary new
]

{ #category : #support }
CpDropEvent class >> prepareInstanceForDragEvent: aDragEvent withPointerId: aNumber [

	"Prepare the receiver that a DropEvent is going to be needed, based on the fact
	that a DragEvent exists using a specific pointer"

	DropInstances at: aNumber put: (self newFromDragEvent: aDragEvent withPointerId: aNumber)
]

{ #category : #support }
CpDropEvent class >> resetInstanceForDragEvent: aDragEvent [

	"Reset the receiver for the fact that a DragEvent is no longer valid"

	DropInstances removeAllSuchThat: [ :each | each isForDragEvent: aDragEvent ]
]

{ #category : #'event handling' }
CpDropEvent class >> updateInstanceFromPointerEvent: aPointerEvent [

	"Update the instance of the receiver matching the specified Pointer Event."

	| dropEvent |

	dropEvent := DropInstances at: aPointerEvent pointerId ifAbsent: [ ^ self ].

	"Update the latest info"
	dropEvent
		type: #drop ;
		timeStamp: aPointerEvent timeStamp ;
		target: aPointerEvent target ;
		elements: aPointerEvent elements copy ;
		point: aPointerEvent point copy
]

{ #category : #accessing }
CpDropEvent >> dragElement [

	^ dragEvent currentElement
]

{ #category : #accessing }
CpDropEvent >> dragEndPoint [

	^ dragEvent endPoint
]

{ #category : #accessing }
CpDropEvent >> dragStartPoint [

	^ dragEvent startPoint
]

{ #category : #accessing }
CpDropEvent >> dragTracePoints [

	^ dragEvent tracePoints
]

{ #category : #initialization }
CpDropEvent >> initializeWithDragEvent: aDragEvent pointerId: aNumber [

	self initialize.

	dragEvent := aDragEvent.
	pointerId := aNumber
]

{ #category : #testing }
CpDropEvent >> isCanceled [

	^ dragEvent isCanceled
]

{ #category : #testing }
CpDropEvent >> isForDragEvent: aDragEvent [

	^ dragEvent hasSameOrigin: aDragEvent
]

{ #category : #printing }
CpDropEvent >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ', dragEvent: '.
	dragEvent printOn: aStream.
	aStream nextPutAll: ', pointerId: '.
	pointerId printOn: aStream
]
