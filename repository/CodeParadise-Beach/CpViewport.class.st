Class {
	#name : #CpViewport,
	#superclass : #CpView,
	#instVars : [
		'position'
	],
	#category : #'CodeParadise-Beach-Components'
}

{ #category : #'web resources' }
CpViewport class >> style [

	<webResource: #css>

	^ ':host {
			position: absolute;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			overflow: hidden;
		}'
]

{ #category : #'web resources' }
CpViewport class >> template [

	<webResource: #html>

	^ '<div id="container">
			<slot></slot>
		</div>'
]

{ #category : #announcing }
CpViewport >> announceUpdate [

	self serverAnnounce: (CpViewportUpdate position: position)
]

{ #category : #'event handling' }
CpViewport >> handleDropEvent: aDropEvent [

	"Handle the drop event on the receiver.
	Delegate this to the first child which might handle it.
	This is needed in an unlimited workspace for example, where
	there is no actual surface to receive the drop event."

	self firstChild onDrop: aDropEvent
]

{ #category : #'event handling' }
CpViewport >> handleViewportMove: aDragEvent [

	"Move the receiver according to the specified DragEvent"

	"Validate dragging is still active"
	aDragEvent ifCanceled: [ ^ self ].

	"Implementation: Since the DragEvent keeps track of a fixed position
	and this Viewport movement changes the world beneath is, only use the
	last delta of the DragEvent."
	position := position - aDragEvent lastDelta.

	self render.

	aDragEvent ifEnded: [ self announceUpdate ]
]

{ #category : #'event handling' }
CpViewport >> handleWheelEvent: aWheelEvent [

	self renderPosition: position + aWheelEvent delta.

	"Let items that are currently being dragged update"
	CpDragEvent updateAll.

	self announceUpdate
]

{ #category : #initialization }
CpViewport >> initialize [

	super initialize.

	position := 0 @ 0.

	"Handle drag/wheel events to move the receiver and also
	handle drop event to allow child to receive a drop event
	even though it might have moved off screen (an unlimited
	workspace for example)."
	self
		when: CpWheelEvent send: #handleWheelEvent: to: self ;
		when: CpDragEvent send: #handleViewportMove: to: self ;
		when: CpDropEvent send: #handleDropEvent: to: self
]

{ #category : #rendering }
CpViewport >> render [

	self renderPosition
]

{ #category : #rendering }
CpViewport >> renderPosition [

	(self shadowRoot elementWithId: #container)
		styleAt: #transform put: 'translate(', position x negated printString, 'px,', position y negated printString, 'px)'
]

{ #category : #rendering }
CpViewport >> renderPosition: aPoint [

	position := aPoint.
	self renderPosition
]

{ #category : #initialization }
CpViewport >> resetPosition [

	| from |

	from := position.

	[ :p | self renderPosition: from - (from * (CpTransition easeOutBack: p)) ] asTransition
		duration: 700 ;
		when: CpTransitionEnded send: #announceUpdate to: self ;
		start
]

{ #category : #transforming }
CpViewport >> translateToLocalPoint: screenPoint [

	"Answer the Point which represents the position of the screenPoint relative to the receiver"

	^ screenPoint + position
]
