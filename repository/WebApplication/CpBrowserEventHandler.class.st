"
I am an event handler for events inside a web browser.

Implementation:
I compose some events (like ClickEvent and KeyPressEvent) from other events.
This to allow as much control over the event handling as possible and
to have a single location to streamline the different browser behaviors.
Different browsers have different ways to trigger events (presence/absence
of events, order of events, data provided by events, etc.).
"
Class {
	#name : #CpBrowserEventHandler,
	#superclass : #Object,
	#instVars : [
		'delegate',
		'clickEvent',
		'dragEvent',
		'keyPressEvent'
	],
	#classVars : [
		'Current'
	],
	#category : #'WebApplication-Events'
}

{ #category : #accessing }
CpBrowserEventHandler class >> cpRequiredClasses [

	^ super cpRequiredClasses, self eventClasses
]

{ #category : #accessing }
CpBrowserEventHandler class >> current [

	"Answer the current instance of the receiver"

	^ Current ifNil: [ Current := self basicNew initialize ; yourself ]
]

{ #category : #accessing }
CpBrowserEventHandler class >> eventClasses [

	^ {
		CpClickEvent .
		CpDragEvent .
		CpPointerDownEvent .
		CpPointerMoveEvent .
		CpPointerUpEvent .
		CpKeyDownEvent .
		CpKeyPressEvent .
		CpKeyUpEvent .
		CpCompositionStartEvent .
		CpCompositionUpdateEvent .
		CpCompositionEndEvent .
		CpInputEvent .
		CpBeforeInputEvent }
]

{ #category : #'instance creation' }
CpBrowserEventHandler class >> new [

	self shouldNotImplement
]

{ #category : #accessing }
CpBrowserEventHandler class >> similarDistance [

	^ 8
]

{ #category : #'event handling' }
CpBrowserEventHandler >> beforeInput: aBeforeInputEvent [

	self dispatchEvent: aBeforeInputEvent
]

{ #category : #'event handling' }
CpBrowserEventHandler >> click: aClickEvent [

	self dispatchEvent: aClickEvent
]

{ #category : #accessing }
CpBrowserEventHandler >> clickEvent [

	^ clickEvent
]

{ #category : #'event handling' }
CpBrowserEventHandler >> compositionEnd: aCompositionEndEvent [

	self dispatchEvent: aCompositionEndEvent
]

{ #category : #'event handling' }
CpBrowserEventHandler >> compositionStart: aCompositionStartEvent [

	self dispatchEvent: aCompositionStartEvent
]

{ #category : #'event handling' }
CpBrowserEventHandler >> compositionUpdate: aCompositionUpdateEvent [

	self dispatchEvent: aCompositionUpdateEvent
]

{ #category : #'event handling' }
CpBrowserEventHandler >> createClickEvent: aPointerDownEvent [

	clickEvent := CpClickEvent new
		target: aPointerDownEvent target ;
		elementId: aPointerDownEvent elementId ;
		clickPoint: aPointerDownEvent point ;
		yourself
]

{ #category : #'event handling' }
CpBrowserEventHandler >> createDragEvent: aPointerDownEvent [

	dragEvent := CpDragEvent new
		target: aPointerDownEvent target ;
		elementId: aPointerDownEvent elementId ;
		startPoint: aPointerDownEvent point ;
		offset: aPointerDownEvent offset ;
		yourself
]

{ #category : #initialization }
CpBrowserEventHandler >> createEventHandlerProcess [

	"Create an event handler process, register it and start it"

	| eventHandlerProcess |

	"Create process with highest priority to handle events as fast as possible"
	eventHandlerProcess := Process
		forContext: [ [

			"Wait for events to become available"
			Processor activeProcess suspend.

			"Handle the events"
			self handleEvents ] repeat ] asContext
		priority: Processor highestPriority.

	"Register the event handler process so the VM (plugin) can activate it"
	self primRegisterProcess: eventHandlerProcess.

	"Start the process (which will actually put it to sleep waiting for the first event)"
	eventHandlerProcess resume
]

{ #category : #'event handling' }
CpBrowserEventHandler >> createKeyPressEvent: aKeyDownEvent [

	keyPressEvent := CpKeyPressEvent new
		modifiers: aKeyDownEvent modifiers ;
		key: aKeyDownEvent key ;
		isComposing: aKeyDownEvent isComposing ;
		yourself
]

{ #category : #accessing }
CpBrowserEventHandler >> delegate [

	^ delegate
]

{ #category : #accessing }
CpBrowserEventHandler >> delegate: anObject [

	delegate := anObject
]

{ #category : #'event handling' }
CpBrowserEventHandler >> dispatchEvent: anEvent [

	self hasDelegate
		ifFalse: [ ^ self ].

	self delegate handleEvent: anEvent
]

{ #category : #accessing }
CpBrowserEventHandler >> dragEvent [

	^ dragEvent
]

{ #category : #accessing }
CpBrowserEventHandler >> eventClass [

	^ CpEvent
]

{ #category : #'event handling' }
CpBrowserEventHandler >> handleClick: aPointerUpEvent [

	(self point: self clickEvent clickPoint isSimilarTo: aPointerUpEvent point)
		ifFalse: [ ^ self ].

	self dispatchEvent: self clickEvent
]

{ #category : #'event handling' }
CpBrowserEventHandler >> handleDragEnd: aPointerUpEvent [

	self dragEvent hasTracePoints
		ifFalse: [ ^ self ].

	self dispatchEvent: (self dragEvent
		endPoint: aPointerUpEvent point ;
		yourself)
]

{ #category : #'event handling' }
CpBrowserEventHandler >> handleDragOver: aPointerMoveEvent [

	self dispatchEvent: (self dragEvent
		addTracePoint: aPointerMoveEvent point ;
		yourself)
]

{ #category : #'event handling' }
CpBrowserEventHandler >> handleEvent: anEvent [

	[ anEvent accept: self ] on: Error do: [ :error | self crTrace: error description ]
]

{ #category : #'event handling' }
CpBrowserEventHandler >> handleEvents [

	"Handle events.
	Implementation: Try to prevent long running synchronous calls for performance (jitter/yank in UI)."

	self latestEvents do: [ :each | self handleEvent: each ]
]

{ #category : #'event handling' }
CpBrowserEventHandler >> handleKeyPress: aKeyUpEvent [

	(self keyPressEvent key = aKeyUpEvent key)
		ifFalse: [
			self keyPressEvent isComposing
				ifFalse: [ self handleKeyPress: self keyPressEvent ].
			^ self ].

	self dispatchEvent: self keyPressEvent
]

{ #category : #testing }
CpBrowserEventHandler >> hasClickEvent [

	^ clickEvent notNil
]

{ #category : #testing }
CpBrowserEventHandler >> hasDelegate [

	^ delegate notNil
]

{ #category : #testing }
CpBrowserEventHandler >> hasDragEvent [

	^ dragEvent notNil
]

{ #category : #testing }
CpBrowserEventHandler >> hasKeyPressEvent [

	^ keyPressEvent notNil
]

{ #category : #initialization }
CpBrowserEventHandler >> initialize [

	"Create the event Process to start handling Events"

	super initialize.

	self
		createEventHandlerProcess ;
		registerEventClasses
]

{ #category : #'event handling' }
CpBrowserEventHandler >> input: anInputEvent [

	self dispatchEvent: anInputEvent
]

{ #category : #'event handling' }
CpBrowserEventHandler >> keyDown: aKeyDownEvent [

	self dispatchEvent: aKeyDownEvent.

	"Key down can become a key press event, create it"
	self hasKeyPressEvent
		ifTrue: [
			self keyPressEvent isComposing
				ifTrue: [ self crTrace: 'Composing not handled yet' ]
				ifFalse: [
					self handleKeyPress: self keyPressEvent.
					self keyPressEvent
						modifiers: aKeyDownEvent modifiers ;
						key: aKeyDownEvent key ;
						isComposing: aKeyDownEvent isComposing ] ]
		ifFalse: [ self createKeyPressEvent: aKeyDownEvent ]
]

{ #category : #'event handling' }
CpBrowserEventHandler >> keyPress: aKeyPressEvent [

	self dispatchEvent: aKeyPressEvent
]

{ #category : #accessing }
CpBrowserEventHandler >> keyPressEvent [

	^ keyPressEvent
]

{ #category : #'event handling' }
CpBrowserEventHandler >> keyUp: aKeyUpEvent [

	self dispatchEvent: aKeyUpEvent.

	self hasKeyPressEvent
		ifTrue: [
			self
				handleKeyPress: aKeyUpEvent ;
				removeKeyPressEvent ]
]

{ #category : #accessing }
CpBrowserEventHandler >> latestEvents [

	"Answer a collection of the latest Events received from the browser"

	^ self primLatestEvents
]

{ #category : #utilities }
CpBrowserEventHandler >> point: aPoint isSimilarTo: otherPoint [

	| distance |

	distance := aPoint dist: otherPoint.

	^ distance < self class similarDistance
]

{ #category : #'event handling' }
CpBrowserEventHandler >> pointerDown: aPointerDownEvent [

	self dispatchEvent: aPointerDownEvent.

	"Pointer down can become both a click and a drag event, create both"
	self
		createClickEvent: aPointerDownEvent ;
		createDragEvent: aPointerDownEvent
]

{ #category : #'event handling' }
CpBrowserEventHandler >> pointerMove: aPointerMoveEvent [

	self dispatchEvent: aPointerMoveEvent.

	"If mouse moved too far assume the earlier mouseDown will not become a click"
	(self hasClickEvent and: [ (self point: self clickEvent clickPoint isSimilarTo: aPointerMoveEvent point) not ])
		ifTrue: [ self removeClickEvent ].

	self hasDragEvent
		ifTrue: [ self handleDragOver: aPointerMoveEvent ]
]

{ #category : #'event handling' }
CpBrowserEventHandler >> pointerUp: aPointerUpEvent [

	self dispatchEvent: aPointerUpEvent.

	self hasClickEvent
		ifTrue: [
			self
				handleClick: aPointerUpEvent ;
				removeClickEvent ].

	self hasDragEvent
		ifTrue: [
			self
				handleDragEnd: aPointerUpEvent ;
				removeDragEvent ]
]

{ #category : #primitives }
CpBrowserEventHandler >> primLatestEvents [

	<primitive: 'primitiveEventHandlerLatestEvents' module: 'CpDOMPlugin'>
	^ #()

]

{ #category : #primitives }
CpBrowserEventHandler >> primRegisterEventClass: anEventClass [

	<primitive: 'primitiveEventHandlerRegisterEventClass:' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
CpBrowserEventHandler >> primRegisterInterestIn: aDomElement [

	<primitive: 'primitiveEventHandlerRegisterInterestIn:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #primitives }
CpBrowserEventHandler >> primRegisterProcess: eventHandlerProcess [

	<primitive: 'primitiveEventHandlerRegisterProcess:' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #initialization }
CpBrowserEventHandler >> registerEventClass: anEventClass [

	self primRegisterEventClass: anEventClass
]

{ #category : #initialization }
CpBrowserEventHandler >> registerEventClasses [

	self class eventClasses do: [ :each | self registerEventClass: each ]
]

{ #category : #'event registration' }
CpBrowserEventHandler >> registerInterestIn: aDomElement [

	self primRegisterInterestIn: aDomElement
]

{ #category : #'event handling' }
CpBrowserEventHandler >> removeClickEvent [

	clickEvent := nil
]

{ #category : #'event handling' }
CpBrowserEventHandler >> removeDragEvent [

	dragEvent := nil
]

{ #category : #removing }
CpBrowserEventHandler >> removeKeyPressEvent [

	keyPressEvent := nil
]
