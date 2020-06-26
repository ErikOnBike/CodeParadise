"
I am an event handler for events inside a web browser.

"
Class {
	#name : #CpBrowserEventHandler,
	#superclass : #Object,
	#instVars : [
		'delegate',
		'clickEvent',
		'dragEvent'
	],
	#classVars : [
		'Current'
	],
	#category : #'WebApplication-Events'
}

{ #category : #accessing }
CpBrowserEventHandler class >> cpRequiredClasses [

	^ super cpRequiredClasses, { CpClickEvent . CpDragEvent . CpMouseUpEvent . CpMouseDownEvent . CpMouseMoveEvent . CpTouchStartEvent . CpTouchMoveEvent . CpTouchEndEvent }
]

{ #category : #accessing }
CpBrowserEventHandler class >> current [

	"Answer the current instance of the receiver"

	^ Current ifNil: [ Current := self basicNew initialize ; yourself ]
]

{ #category : #'instance creation' }
CpBrowserEventHandler class >> new [

	self shouldNotImplement
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
CpBrowserEventHandler >> createClickEvent: mouseDownEvent [

	clickEvent := CpClickEvent new
		target: mouseDownEvent target ;
		elementId: mouseDownEvent elementId ;
		clickPoint: mouseDownEvent mousePoint ;
		yourself
]

{ #category : #'event handling' }
CpBrowserEventHandler >> createDragEvent: mouseDownEvent [

	dragEvent := CpDragEvent new
		target: mouseDownEvent target ;
		elementId: mouseDownEvent elementId ;
		startPoint: mouseDownEvent mousePoint ;
		offset: mouseDownEvent offset ;
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
CpBrowserEventHandler >> handleClick: mouseUpEvent [

	self dispatchEvent: self clickEvent
]

{ #category : #'event handling' }
CpBrowserEventHandler >> handleDragEnd: mouseUpEvent [

	self dispatchEvent: (self dragEvent
		endPoint: mouseUpEvent mousePoint ;
		yourself)
]

{ #category : #'event handling' }
CpBrowserEventHandler >> handleDragOver: mouseMoveEvent [

	self dispatchEvent: (self dragEvent
		addTracePoint: mouseMoveEvent mousePoint ;
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

{ #category : #initialization }
CpBrowserEventHandler >> initialize [

	"Create the event Process to start handling Events"

	super initialize.

	self createEventHandlerProcess
]

{ #category : #accessing }
CpBrowserEventHandler >> latestEvents [

	"Answer a collection of the latest Events received from the browser"

	"Each primitive browser event is an Array of Associations (and needs converting to a Dictionary for)
	representing an event"
	^ self primLatestEvents collect: [ :each | self eventClass buildFrom: each asDictionary ]
]

{ #category : #'event handling' }
CpBrowserEventHandler >> mouseDown: mouseDownEvent [

	self dispatchEvent: mouseDownEvent.

	"Mouse down can become both a click and a drag event, create both"
	self
		createClickEvent: mouseDownEvent ;
		createDragEvent: mouseDownEvent
]

{ #category : #'event handling' }
CpBrowserEventHandler >> mouseMove: mouseMoveEvent [

	self dispatchEvent: mouseMoveEvent.

	"If mouse moved too far assume the earlier mouseDown will not become a click"
	(self hasClickEvent and: [ (self point: self clickEvent clickPoint isSimilarTo: mouseMoveEvent mousePoint) not ])
		ifTrue: [ self removeClickEvent ].

	self hasDragEvent
		ifTrue: [ self handleDragOver: mouseMoveEvent ]
]

{ #category : #'event handling' }
CpBrowserEventHandler >> mouseUp: mouseUpEvent [

	self dispatchEvent: mouseUpEvent.

	self hasClickEvent
		ifTrue: [
			(self point: self clickEvent clickPoint isSimilarTo: mouseUpEvent mousePoint)
				ifTrue: [ self handleClick: mouseUpEvent ].
			self removeClickEvent ].

	self hasDragEvent
		ifTrue: [
			self dragEvent hasTracePoints
				ifTrue: [ self handleDragEnd: mouseUpEvent ].
			self removeDragEvent ]
]

{ #category : #utilities }
CpBrowserEventHandler >> point: aPoint isSimilarTo: otherPoint [

	| distance |

	distance := aPoint dist: otherPoint.

	^ distance < self class similarDistance
]

{ #category : #primitives }
CpBrowserEventHandler >> primLatestEvents [

	<primitive: 'primitiveEventHandlerLatestEvents' module: 'CpDOMPlugin'>
	^ #()

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
CpBrowserEventHandler >> touchEnd: touchEndEvent [

	| mouseUpEvent |

	mouseUpEvent := CpMouseUpEvent new
		target: touchEndEvent target ;
		elementId: touchEndEvent elementId ;
		mousePoint: touchEndEvent touchPoint ;
		offset: touchEndEvent offset ;
		yourself.
		
	self mouseUp: mouseUpEvent
]

{ #category : #'event handling' }
CpBrowserEventHandler >> touchMove: touchMoveEvent [

	| mouseMoveEvent |

	mouseMoveEvent := CpMouseDownEvent new
		target: touchMoveEvent target ;
		elementId: touchMoveEvent elementId ;
		mousePoint: touchMoveEvent touchPoint ;
		offset: touchMoveEvent offset ;
		yourself.
		
	self mouseMove: mouseMoveEvent
]

{ #category : #'event handling' }
CpBrowserEventHandler >> touchStart: touchStartEvent [

	| mouseDownEvent |

	mouseDownEvent := CpMouseDownEvent new
		target: touchStartEvent target ;
		elementId: touchStartEvent elementId ;
		mousePoint: touchStartEvent touchPoint ;
		offset: touchStartEvent offset ;
		yourself.
		
	self mouseDown: mouseDownEvent
]
