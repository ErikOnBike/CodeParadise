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
			width: 100%;
			height: 100%;
			overflow: hidden;
		}
		#container {
			width: 100%;
			height: 100%;
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
CpViewport >> handleViewportMove: aDragEvent [

	"Move the receiver according to the specified DragEvent"

	"Validate dragging is still active and no overlapping elements"
	(aDragEvent isCanceled or: [ (aDragEvent isDirectedAt: self) not ])
		ifTrue: [ ^ self ].

	"Implementation: Since the DragEvent keeps track of a fixed position
	and this Viewport movement changes the world beneath is, only use the
	last delta of the DragEvent."
	position := position - aDragEvent lastDelta.

	self render.

	aDragEvent isEnded
		ifTrue: [ self announceUpdate ].

	"The event is handled, stop further propagation"
	aDragEvent stopPropagation
]

{ #category : #'event handling' }
CpViewport >> handleWheelEvent: aWheelEvent [

	position := position + aWheelEvent delta.

	self
		render ;
		announceUpdate
]

{ #category : #initialization }
CpViewport >> initialize [

	super initialize.

	position := 0 @ 0.

	self
		when: CpWheelEvent send: #handleWheelEvent: to: self ;
		when: CpDragEvent send: #handleViewportMove: to: self
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

{ #category : #transforming }
CpViewport >> translateToLocalPoint: screenPoint [

	"Answer the Point which represents the position of the screenPoint relative to the receiver"

	^ screenPoint + position
]
