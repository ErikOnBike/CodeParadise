Class {
	#name : #CpWindow,
	#superclass : #CpView,
	#instVars : [
		'position',
		'size'
	],
	#category : #'CodeParadise-Beach-Components'
}

{ #category : #'web resources' }
CpWindow class >> style [

	<webResource: #css>

	^ '* {
			box-sizing: border-box;
		}
		:host {
			position: absolute;
		}
		#container {
			display: grid;
			grid-template-columns: auto;
			grid-template-rows: fit-content(4em) auto;
			width: 100%;
			height: 100%;
			overflow: hidden;
			border-radius: 8px;
			border: var(--window-border-size, 1px) solid var(--window-border-color, #333);
			background-color: var(--window-background-color, #ddd);
			box-shadow: 16px 16px 24px 8px rgba(0, 0, 0, .1);
		}
		#titleBar {
			display: grid;
			grid-template-columns: minmax(min-content, 1fr) auto minmax(min-content, 1fr);
			grid-template-rows: auto;
			background: linear-gradient(#eee, var(--window-background-color, #ddd));
			cursor: move;
		}
		#controls {
			height: calc(1.2em + 6px);
			padding-left: 8px;
			padding-right: 8px;
			white-space: nowrap;
		}
		#controls ::slotted(cp-icon) {
			display: inline-block;
			width: calc(1.2em + 6px);
			height: calc(1.2em + 6px);
			cursor: pointer;
		}
		#title {
			padding-top: 3px;
			padding-bottom: 3px;
			text-align: center;
			white-space: nowrap;
			text-overflow: ellipsis;
			overflow: hidden;
			color: var(--window-title-color, #333);
		}
		#title,
		#title * {
			pointer-events: none;
		}
		#content {
			width: 100%;
			height: 100%;
			background-color: #fff;
		}
		#handles {
			position: absolute;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			pointer-events: none;
		}
		#top {
			position: absolute;
			top: -4px;
			left: 12px;
			width: calc(100% - 24px);
			height: 8px;
			cursor: ns-resize;
			pointer-events: auto;
		}
		#bottom {
			position: absolute;
			bottom: -4px;
			left: 12px;
			width: calc(100% - 24px);
			height: 8px;
			cursor: ns-resize;
			pointer-events: auto;
		}
		#left {
			position: absolute;
			top: 12px;
			left: -4px;
			width: 8px;
			height: calc(100% - 24px);
			cursor: ew-resize;
			pointer-events: auto;
		}
		#right {
			position: absolute;
			top: 12px;
			right: -4px;
			width: 8px;
			height: calc(100% - 24px);
			cursor: ew-resize;
			pointer-events: auto;
		}
		#topLeft {
			position: absolute;
			top: -4px;
			left: -4px;
			width: 16px;
			height: 16px;
			cursor: nwse-resize;
			pointer-events: auto;
		}
		#topRight {
			position: absolute;
			top: -4px;
			right: -4px;
			width: 16px;
			height: 16px;
			cursor: nesw-resize;
			pointer-events: auto;
		}
		#bottomLeft {
			position: absolute;
			bottom: -4px;
			left: -4px;
			width: 16px;
			height: 16px;
			cursor: nesw-resize;
			pointer-events: auto;
		}
		#bottomRight {
			position: absolute;
			bottom: -4px;
			right: -4px;
			width: 16px;
			height: 16px;
			cursor: nwse-resize;
			pointer-events: auto;
		}'
]

{ #category : #'web resources' }
CpWindow class >> template [

	<webResource: #html>

	^ '<div id="container">
			<div id="titleBar">
				<div id="controls"><slot name="controls"></slot></div>
				<div id="title"><slot name="title">Untitled</slot></div>
			</div>
			<div id="body">
				<div id="content"><slot name="content"></slot></div>
			</div>
			<div id="handles">
				<div id="topLeft" class="corner"></div><div id="top" class="side"></div><div id="topRight" class="corner"></div>
				<div id="left" class="side"></div><div id="right" class="side"></div>
				<div id="bottomLeft" class="corner"></div><div id="bottom" class="side"></div><div id="bottomRight" class="corner"></div>
			</div>
		</div>'
]

{ #category : #announcing }
CpWindow >> announceUpdate [

	"Announce the receiver updated, if the receiver is not closing)"

	(self isClassed: #closing)
		ifFalse: [ self serverAnnounce: (CpWindowUpdate position: position size: size) ]
]

{ #category : #actions }
CpWindow >> close [

	"Send close announcement to server.

	Implementation:
	Set class on receiver to show the receiver is closing."

	self addClass: #closing.
	self serverAnnounce: CpWindowClose
]

{ #category : #'event handling' }
CpWindow >> handlePointerDownEvent: aPointerDownEvent [

	self makeTopWindow
]

{ #category : #'event handling' }
CpWindow >> handleWindowMove: aDragEvent [

	"Move the receiver according to the specified DragEvent.
	Dragging can start anywhere inside the titlebar. Therefore take offset
	of drag position into account."

	| point offset |

	aDragEvent isCanceled
		ifTrue: [ ^ self ].

	self makeTopWindow.
	point := self translateToLocalPoint: aDragEvent point.
	offset := aDragEvent offset.

	position := (point x - offset x) @ (point y - offset y).

	self renderPosition.

	aDragEvent isEnded
		ifTrue: [ self announceUpdate ]
]

{ #category : #'event handling' }
CpWindow >> handleWindowResizeCorner: aDragEvent [

	| point resizeCorner |

	aDragEvent isCanceled
		ifTrue: [ ^ self ].

	self makeTopWindow.
	point := self translateToLocalPoint: aDragEvent point.
	resizeCorner := aDragEvent target id.

	"Distinguish all four corners (topLeft, topRight, bottomLeft, bottomRight)
	and map onto x or y axis"
	(resizeCorner endsWith: #Left)
		ifTrue: [ self updateLeftSide: point x ]
		ifFalse: [ self updateRightSide: point x ].
	(resizeCorner beginsWith: #top)
		ifTrue: [ self updateTopSide: point y ]
		ifFalse: [ self updateBottomSide: point y ].

	"Assume position and size have changed and re-render
	(although in fact only one might have changed)"
	self render.

	aDragEvent isEnded
		ifTrue: [ self announceUpdate ]
]

{ #category : #'event handling' }
CpWindow >> handleWindowResizeSide: aDragEvent [

	| point resizeSide |

	aDragEvent isCanceled
		ifTrue: [ ^ self ].

	self makeTopWindow.
	point := self translateToLocalPoint: aDragEvent point.
	resizeSide := aDragEvent target id.

	"Distinguish all four sides (left, right, top, bottom)"
	resizeSide = #left
		ifTrue: [ self updateLeftSide: point x ]
		ifFalse: [
			resizeSide = #right
				ifTrue: [ self updateRightSide: point x ]
				ifFalse: [
					resizeSide = #top
						ifTrue: [ self updateTopSide: point y ]
						ifFalse: [
							resizeSide = #bottom
								ifTrue: [ self updateBottomSide: point y ] ] ] ].

	"Assume position and size have changed and re-render
	(although in fact only one might have changed)"
	self render.

	aDragEvent isEnded
		ifTrue: [ self announceUpdate ]
]

{ #category : #accessing }
CpWindow >> height [

	^ self size y printString, 'px'
]

{ #category : #initialization }
CpWindow >> initialize [

	| closeControl |

	super initialize.

	position := 100 @ 100.
	size := self minWidth @ self minHeight.

	closeControl := (CpIcon named: #close)
		when: CpClickEvent send: #close to: self ;
		yourself.

	self appendChild: closeControl atSlotNamed: #controls.
	self render.

	self when: CpPointerDownEvent send: #handlePointerDownEvent: to: self.

	self shadowRoot
		ifNotNil: [ :shadowRoot |
			(shadowRoot allDescendantsMatching: '.corner')
				do: [ :each | each when: CpDragEvent send: #handleWindowResizeCorner: to: self  ].
			(shadowRoot allDescendantsMatching: '.side')
				do: [ :each | each when: CpDragEvent send: #handleWindowResizeSide: to: self ].
			(shadowRoot elementWithId: #titleBar)
				when: CpDragEvent send: #handleWindowMove: to: self ]
]

{ #category : #accessing }
CpWindow >> left [

	^ self position x printString, 'px'
]

{ #category : #updating }
CpWindow >> makeTopWindow [

	"Make receiver top window by making it the last child within its parent"

	self nextSibling ifNil: [ ^ self ].

	self parent appendChild: self remove
]

{ #category : #accessing }
CpWindow >> minHeight [

	^ 200
]

{ #category : #accessing }
CpWindow >> minWidth [

	^ 400
]

{ #category : #accessing }
CpWindow >> position [

	^ position
]

{ #category : #rendering }
CpWindow >> render [

	self
		renderPosition ;
		renderSize
]

{ #category : #updating }
CpWindow >> renderPosition [

	self
		styleAt: #top put: self top ;
		styleAt: #left put: self left

]

{ #category : #updating }
CpWindow >> renderPosition: aPoint [

	position := aPoint.
	self renderPosition
]

{ #category : #updating }
CpWindow >> renderSize [

	self
		styleAt: #width put: self width ;
		styleAt: #height put: self height
]

{ #category : #updating }
CpWindow >> renderSize: aPoint [

	size := aPoint.
	self renderSize
]

{ #category : #rendering }
CpWindow >> renderTitle: anElement [

	self
		replaceAllChildrenWith: anElement asHtmlElement
		atSlotNamed: #title
]

{ #category : #accessing }
CpWindow >> size [

	^ size
]

{ #category : #accessing }
CpWindow >> top [

	^ self position y printString, 'px'
]

{ #category : #updating }
CpWindow >> updateBottomSide: positionBottom [

	size := (positionBottom - position y) >= self minHeight
		ifTrue: [ size x @ (positionBottom - position y) ]
		ifFalse: [ size x @ self minHeight ]
]

{ #category : #updating }
CpWindow >> updateLeftSide: positionLeft [

	(position x + size x) >= (positionLeft + self minWidth)
		ifTrue: [
			size := (size x + (position x - positionLeft)) @ size y.
			position := positionLeft @ position y ]
		ifFalse: [
			position := (position x + size x - self minWidth) @ position y.
			size := self minWidth @ size y ]
]

{ #category : #updating }
CpWindow >> updateRightSide: positionRight [

	size := (positionRight - position x) >= self minWidth
		ifTrue: [ (positionRight - position x) @ size y ]
		ifFalse: [ self minWidth @ size y ]
]

{ #category : #updating }
CpWindow >> updateTopSide: positionTop [

	(position y + size y) >= (positionTop + self minHeight)
		ifTrue: [
			size := size x @ (size y + (position y - positionTop)).
			position := position x @ positionTop ]
		ifFalse: [
			position := position x @ (position y + size y - self minHeight).
			size := size x @ self minHeight ]
]

{ #category : #accessing }
CpWindow >> width [

	^ self size x printString, 'px'
]
