Class {
	#name : #CpClickEvent,
	#superclass : #CpUserInterfaceEvent,
	#instVars : [
		'offset',
		'modifiers'
	],
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
		ifTrue: [ ClickInstances at: aPointerDownEvent pointerId put: (self newFromPointerEvent: aPointerDownEvent) ]
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
CpClickEvent class >> newFromPointerEvent: aPointerEvent [

	^ self new
		type: #click ;
		timeStamp: aPointerEvent timeStamp ;
		point: aPointerEvent point ;
		offset: aPointerEvent offset ;
		target: aPointerEvent target ;
		elements: aPointerEvent elements ;
		modifiers: aPointerEvent modifiers ;
		yourself
]

{ #category : #'class initialization' }
CpClickEvent class >> postInstall [

	super postInstall.

	ClickInstances := Dictionary new
]

{ #category : #testing }
CpClickEvent >> hasAltModifier [

	^ (self modifiers bitAnd: 1) ~= 0
]

{ #category : #testing }
CpClickEvent >> hasCtrlModifier [

	^ (self modifiers bitAnd: 2) ~= 0
]

{ #category : #testing }
CpClickEvent >> hasMetaModifier [

	^ (self modifiers bitAnd: 4) ~= 0
]

{ #category : #testing }
CpClickEvent >> hasModifiers [

	^ self modifiers ~= 0
]

{ #category : #testing }
CpClickEvent >> hasShiftModifier [

	^ (self modifiers bitAnd: 8) ~= 0
]

{ #category : #accessing }
CpClickEvent >> modifiers [

	"Answer an Integer specifying the different modifiers pressed.
	Combine the following individual numbers:
		1 - alt
		2 - ctrl
		4 - meta
		8 - shift"

	^ modifiers
]

{ #category : #accessing }
CpClickEvent >> modifiers: anInteger [

	modifiers := anInteger
]

{ #category : #accessing }
CpClickEvent >> offset [

	^ offset
]

{ #category : #accessing }
CpClickEvent >> offset: aPoint [

	offset := aPoint
]
