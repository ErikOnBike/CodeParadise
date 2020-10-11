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
		'clickEvent',
		'dragEvent',
		'keyPressEvent'
	],
	#classVars : [
		'Current'
	],
	#category : #'CodeParadise-WebApplication-Events'
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
		CpBeforeInputEvent .
		CpFocusInEvent .
		CpFocusOutEvent }
]

{ #category : #'instance creation' }
CpBrowserEventHandler class >> new [

	"Use self >> #current instead to get the singleton instance"

	self shouldNotImplement
]

{ #category : #utilities }
CpBrowserEventHandler class >> point: aPoint isSimilarTo: otherPoint [

	| distance |

	distance := aPoint dist: otherPoint.

	^ distance < self similarDistance
]

{ #category : #accessing }
CpBrowserEventHandler class >> similarDistance [

	^ 8
]

{ #category : #accessing }
CpBrowserEventHandler >> clickEvent [

	^ clickEvent
]

{ #category : #'event handling' }
CpBrowserEventHandler >> createClickEvent: aPointerDownEvent [

	clickEvent := CpClickEvent new
		target: aPointerDownEvent target ;
		elementId: aPointerDownEvent elementId ;
		point: aPointerDownEvent point ;
		yourself
]

{ #category : #'event handling' }
CpBrowserEventHandler >> createDragEvent: aPointerDownEvent [

	dragEvent := CpDragEvent new
		target: aPointerDownEvent target ;
		elementId: aPointerDownEvent elementId ;
		point: aPointerDownEvent point ;
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
	self primRegisterEventProcess: eventHandlerProcess.

	"Start the process (which will actually put it to sleep waiting for the first event)"
	eventHandlerProcess resume
]

{ #category : #'event handling' }
CpBrowserEventHandler >> createKeyPressEvent: aKeyDownEvent [

	keyPressEvent := CpKeyPressEvent new
		target: aKeyDownEvent target ; 
		modifiers: aKeyDownEvent modifiers ;
		key: aKeyDownEvent key ;
		isComposing: aKeyDownEvent isComposing ;
		yourself
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
CpBrowserEventHandler >> handleBeforeInputEvent: aBeforeInputEvent [

	aBeforeInputEvent dispatch
]

{ #category : #'event handling' }
CpBrowserEventHandler >> handleClickEvent: aClickEvent [

	aClickEvent dispatch
]

{ #category : #'event handling' }
CpBrowserEventHandler >> handleCompositionEndEvent: aCompositionEndEvent [

	aCompositionEndEvent dispatch
]

{ #category : #'event handling' }
CpBrowserEventHandler >> handleCompositionStartEvent: aCompositionStartEvent [

	aCompositionStartEvent dispatch
]

{ #category : #'event handling' }
CpBrowserEventHandler >> handleCompositionUpdateEvent: aCompositionUpdateEvent [

	aCompositionUpdateEvent dispatch
]

{ #category : #'event handling' }
CpBrowserEventHandler >> handleEvent: anEvent [

	[ anEvent sendTo: self ] on: Error do: [ :error | self crTrace: error description ]
]

{ #category : #'event handling' }
CpBrowserEventHandler >> handleEvents [

	"Handle events.
	Implementation: Try to prevent long running synchronous calls for performance (jitter/yank in UI)."

	self latestEvents do: [ :each | self handleEvent: each ]
]

{ #category : #'event handling' }
CpBrowserEventHandler >> handleInputEvent: anInputEvent [

	anInputEvent dispatch
]

{ #category : #'event handling' }
CpBrowserEventHandler >> handleKeyDownEvent: aKeyDownEvent [

	aKeyDownEvent dispatch.

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
CpBrowserEventHandler >> handleKeyPress: aKeyUpEvent [

	(self keyPressEvent key = aKeyUpEvent key)
		ifFalse: [
			self keyPressEvent isComposing
				ifFalse: [ self handleKeyPress: self keyPressEvent ].
			^ self ].

	self keyPressEvent dispatch
]

{ #category : #'event handling' }
CpBrowserEventHandler >> handleKeyPressEvent: aKeyPressEvent [

	aKeyPressEvent dispatch
]

{ #category : #'event handling' }
CpBrowserEventHandler >> handleKeyUpEvent: aKeyUpEvent [

	aKeyUpEvent dispatch.

	self hasKeyPressEvent
		ifTrue: [
			self
				handleKeyPress: aKeyUpEvent ;
				removeKeyPressEvent ]
]

{ #category : #'event handling' }
CpBrowserEventHandler >> handlePointerDownEvent: aPointerDownEvent [

	aPointerDownEvent dispatch.

	"Pointer down can become both a click and a drag event, create both"
	self
		createClickEvent: aPointerDownEvent ;
		createDragEvent: aPointerDownEvent
]

{ #category : #'event handling' }
CpBrowserEventHandler >> handlePointerMoveEvent: aPointerMoveEvent [

	aPointerMoveEvent dispatch.

	"If mouse moved too far assume the earlier mouseDown will not become a click"
	(self hasClickEvent and: [ (self point: self clickEvent point isSimilarTo: aPointerMoveEvent point) not ])
		ifTrue: [ self removeClickEvent ].

	self hasDragEvent
		ifTrue: [ self simulateDragOverEvent: aPointerMoveEvent ]
]

{ #category : #'event handling' }
CpBrowserEventHandler >> handlePointerUpEvent: aPointerUpEvent [

	aPointerUpEvent dispatch.

	self hasClickEvent
		ifTrue: [
			self
				simulateClickEvent: aPointerUpEvent ;
				removeClickEvent ].

	self hasDragEvent
		ifTrue: [
			self
				simulateDragEndEvent: aPointerUpEvent ;
				removeDragEvent ]
]

{ #category : #testing }
CpBrowserEventHandler >> hasClickEvent [

	^ clickEvent notNil
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

{ #category : #accessing }
CpBrowserEventHandler >> keyPressEvent [

	^ keyPressEvent
]

{ #category : #accessing }
CpBrowserEventHandler >> latestEvents [

	"Answer a collection of the latest Events received from the browser"

	^ self primLatestEvents
]

{ #category : #utilities }
CpBrowserEventHandler >> point: aPoint isSimilarTo: otherPoint [

	^ self class point: aPoint isSimilarTo: otherPoint
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
CpBrowserEventHandler >> primRegisterEventProcess: eventHandlerProcess [

	<primitive: 'primitiveEventHandlerRegisterProcess:' module: 'CpDOMPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
CpBrowserEventHandler >> primRegisterInterestIn: aDomElement [

	<primitive: 'primitiveEventHandlerRegisterInterestIn:' module: 'CpDOMPlugin'>
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

{ #category : #'event handling' }
CpBrowserEventHandler >> removeKeyPressEvent [

	keyPressEvent := nil
]

{ #category : #'event handling' }
CpBrowserEventHandler >> simulateClickEvent: aPointerUpEvent [

	(self point: self clickEvent point isSimilarTo: aPointerUpEvent point)
		ifFalse: [ ^ self ].

	self clickEvent dispatch
]

{ #category : #'event handling' }
CpBrowserEventHandler >> simulateDragEndEvent: aPointerUpEvent [

	self dragEvent hasTracePoints
		ifFalse: [ ^ self ].

	self dragEvent
		endPoint: aPointerUpEvent point ;
		dispatch
]

{ #category : #'event handling' }
CpBrowserEventHandler >> simulateDragOverEvent: aPointerMoveEvent [

	self dragEvent
		addTracePoint: aPointerMoveEvent point ;
		dispatch
]
