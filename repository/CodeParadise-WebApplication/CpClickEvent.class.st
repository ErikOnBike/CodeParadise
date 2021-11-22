Class {
	#name : #CpClickEvent,
	#superclass : #CpMouseEvent,
	#classVars : [
		'ClickInstances'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #announcing }
CpClickEvent class >> addListenerTo: anElement [

	"Add a listener for the receiver to the specified DOM element.

	Implementation:
	Simulate a ClickEvent by using PointerDown/PointerMove/PointerUp events."

	super addListenerTo: anElement.

	anElement
		when: CpPointerDownEvent send: #clickStart: to: self ;
		when: CpPointerMoveEvent send: #clickUpdate: to: self ;
		when: CpPointerUpEvent send: #clickEnd: to: self

]

{ #category : #'event handling - private' }
CpClickEvent class >> clickEnd: aPointerUpEvent [

	| clickEvent |

	clickEvent := ClickInstances at: aPointerUpEvent pointerId ifAbsent: [ ^ self ].

	"Remove temporary storage (for all situations)"
	ClickInstances removeKey: aPointerUpEvent pointerId.

	"Validate the pointer is still near the original position to be accepted as a click event"
	(self point: clickEvent point isSimilarTo: aPointerUpEvent point) 
		ifTrue: [ clickEvent dispatch ]
]

{ #category : #'event handling - private' }
CpClickEvent class >> clickStart: aPointerDownEvent [

	| clickEvent |

	clickEvent := ClickInstances at: aPointerDownEvent pointerId ifAbsent: [ nil ].

	(clickEvent isNil or: [ (clickEvent hasSameOrigin: aPointerDownEvent) not ])
		ifTrue: [
			(self newFromMouseEvent: aPointerDownEvent) ifNotNil: [ :pointerEvent |
				ClickInstances at: aPointerDownEvent pointerId put: pointerEvent ] ]
]

{ #category : #'event handling - private' }
CpClickEvent class >> clickUpdate: aPointerMoveEvent [

	| clickEvent |

	clickEvent := ClickInstances at: aPointerMoveEvent pointerId ifAbsent: [ ^ self ].

	"Validate the pointer is still near the original position,
	otherwise the click event will be removed (not become effective)."
	(self point: clickEvent point isSimilarTo: aPointerMoveEvent point) 
		ifFalse: [ ClickInstances removeKey: aPointerMoveEvent pointerId ]
]

{ #category : #'instance creation' }
CpClickEvent class >> newFromMouseEvent: aMouseEvent [

	"Answer a new instance of the receiver (or a subclass) matching the
	specified pointer event.
	In case no matching instance can be created, answer nil."

	| clickEventClass elements |

	"Find the correct click event class. For convenience
	the PrimaryClickEvent and SecondaryClickEvent are
	available which represent clicks without modifiers
	(and without additional buttons being pressed).
	
	Implementation: Since subclasses will be defined
	after base classes, use indirect reference to
	subclasses (for usage in RemoveEnvironment)."
	clickEventClass := aMouseEvent hasModifiers
		ifTrue: [ self ]
		ifFalse: [
			aMouseEvent isOnlyPrimaryButtonPressed
				ifTrue: [ Smalltalk at: #CpPrimaryClickEvent ]
				ifFalse: [
					aMouseEvent isOnlySecondaryButtonPressed
						ifTrue: [ Smalltalk at: #CpSecondaryClickEvent ]
						ifFalse: [ self ] ] ].

	"Validate the elements are actually listening to the specific click event"
	elements := aMouseEvent elements
		select: [ :each | clickEventClass isListenedToOn: each ].
	elements ifEmpty: [ ^ nil ].

	^ clickEventClass newFromMouseEvent: aMouseEvent elements: elements
]

{ #category : #'instance creation' }
CpClickEvent class >> newFromMouseEvent: aMouseEvent elements: aCollection [

	"Answer a new instance of the receiver using the information
	from the specified pointer event and elements to dispatch to."

	^ self basicNew
		initializeWithMouseEvent: aMouseEvent elements: aCollection ;
		yourself
]

{ #category : #'class initialization' }
CpClickEvent class >> postInstallOnce [

	ClickInstances := Dictionary new
]

{ #category : #initialization }
CpClickEvent >> initializeWithMouseEvent: aMouseEvent elements: aCollection [

	self initialize.

	type := #click.
	timeStamp := aMouseEvent timeStamp.
	pageX := aMouseEvent pageX.
	pageY := aMouseEvent pageY.
	offsetX := aMouseEvent offsetX.
	offsetY := aMouseEvent offsetY.
	target := aMouseEvent target.
	elements := aCollection.
	buttons := aMouseEvent buttons.
	modifiers := aMouseEvent modifiers

]
