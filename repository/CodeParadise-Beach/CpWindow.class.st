Class {
	#name : #CpWindow,
	#superclass : #CpView,
	#instVars : [
		'position',
		'width',
		'height'
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
			width: max-content;
			height: max-content;
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

	"Announce the receiver updated"

	self serverAnnounce: (CpWindowUpdate position: position width: width height: height)
]

{ #category : #accessing }
CpWindow >> calculatedHeight [

	^ self propertyAt: #offsetHeight
]

{ #category : #accessing }
CpWindow >> calculatedWidth [

	^ self propertyAt: #offsetWidth
]

{ #category : #actions }
CpWindow >> close [

	"Send close announcement to server"

	self serverAnnounce: CpWindowClose
]

{ #category : #accessing }
CpWindow >> defaultPosition [

	^ 100 @ 100
]

{ #category : #'event handling' }
CpWindow >> handleWindowClick: aPrimaryClickEvent [

	"Set focus to the Window if it isn't already the top window"

	self nextSibling ifNil: [ ^ self ].

	self focus
]

{ #category : #'event handling' }
CpWindow >> handleWindowMove: aDragEvent [

	"Move the receiver according to the specified DragEvent.
	Dragging can start anywhere inside the titlebar. Therefore take offset
	of drag position into account."

	| point |

	aDragEvent ifCanceled: [ ^ self ].

	self makeTopWindow.
	point := self translateToLocalPoint: aDragEvent point.

	position := (point x - aDragEvent offsetX) @ (point y - aDragEvent offsetY).

	self renderPosition.

	aDragEvent ifEnded: [ self announceUpdate ]
]

{ #category : #'event handling' }
CpWindow >> handleWindowResizeCorner: aDragEvent [

	| point resizeCorner |

	aDragEvent ifCanceled: [ ^ self ].

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

	aDragEvent ifEnded: [ self announceUpdate ]
]

{ #category : #'event handling' }
CpWindow >> handleWindowResizeSide: aDragEvent [

	| point resizeSide |

	aDragEvent ifCanceled: [ ^ self ].

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

	aDragEvent ifEnded: [ self announceUpdate ]
]

{ #category : #accessing }
CpWindow >> height [

	^ height
]

{ #category : #initialization }
CpWindow >> initialize [

	| closeControl |

	super initialize.

	position := self defaultPosition.

	closeControl := (CpIcon named: #close)
		when: CpPrimaryClickEvent send: #close to: self ;
		yourself.

	self appendChild: closeControl atSlotNamed: #controls.
	self render.

	self when: CpPrimaryClickEvent send: #handleWindowClick: to: self

]

{ #category : #initialization }
CpWindow >> initializeShadowRoot [

	| shadowRoot |

	super initializeShadowRoot.

	shadowRoot := self shadowRoot.

	(shadowRoot allDescendantsMatching: '.corner')
		do: [ :each | each when: CpDragEvent send: #handleWindowResizeCorner: to: self  ].
	(shadowRoot allDescendantsMatching: '.side')
		do: [ :each | each when: CpDragEvent send: #handleWindowResizeSide: to: self ].
	(shadowRoot elementWithId: #titleBar)
		when: CpDragEvent send: #handleWindowMove: to: self
]

{ #category : #updating }
CpWindow >> makeTopWindow [

	"Make receiver top window by making it the last child within its parent"

	self nextSibling ifNil: [ ^ self ].

	self parent appendChild: self remove
]

{ #category : #accessing }
CpWindow >> minHeight [

	^ 64
]

{ #category : #accessing }
CpWindow >> minWidth [

	^ 128
]

{ #category : #accessing }
CpWindow >> position [

	^ position
]

{ #category : #rendering }
CpWindow >> render [

	self
		renderPosition ;
		renderWidth ;
		renderHeight
]

{ #category : #rendering }
CpWindow >> renderHeight [

	self styleAt: #height put: (height ifNotNil: [ height asString, 'px' ])
]

{ #category : #rendering }
CpWindow >> renderHeight: anInteger [

	"Set the height of the receiver to anInteger. anInteger might be nil in which case the
	height is decided by the receiver's content."

	height := anInteger.
	self renderHeight
]

{ #category : #rendering }
CpWindow >> renderPosition [

	self
		styleAt: #left put: position x asString, 'px' ;
		styleAt: #top put: position y asString, 'px'

]

{ #category : #rendering }
CpWindow >> renderPosition: aPoint [

	position := aPoint.
	self renderPosition
]

{ #category : #rendering }
CpWindow >> renderTitle: anElement [

	self
		replaceAllChildrenWith: anElement asHtmlElement
		atSlotNamed: #title
]

{ #category : #rendering }
CpWindow >> renderWidth [

	self styleAt: #width put: (width ifNotNil: [ width asString, 'px' ])
]

{ #category : #rendering }
CpWindow >> renderWidth: anInteger [

	"Set the width of the receiver to anInteger. anInteger might be nil in which case the
	width is decided by the receiver's content."

	width := anInteger.
	self renderWidth
]

{ #category : #rendering }
CpWindow >> renderWidth: widthInteger height: heightInteger [

	"Convenience method to set both width and height.
	See #renderWidth: and #renderHeight: for explanation about arguments."

	self
		renderWidth: widthInteger ;
		renderHeight: heightInteger
]

{ #category : #updating }
CpWindow >> updateBottomSide: positionBottom [

	height := (positionBottom - position y) max: self minHeight
]

{ #category : #updating }
CpWindow >> updateLeftSide: positionLeft [

	width ifNil: [ width := self calculatedWidth ].

	(position x + width) >= (positionLeft + self minWidth)
		ifTrue: [
			width := width + (position x - positionLeft).
			position := positionLeft @ position y ]
		ifFalse: [
			position := (position x + width - self minWidth) @ position y.
			width := self minWidth ]
]

{ #category : #updating }
CpWindow >> updateRightSide: positionRight [

	width := (positionRight - position x) max: self minWidth
]

{ #category : #updating }
CpWindow >> updateTopSide: positionTop [

	height ifNil: [ height := self calculatedHeight ].

	(position y + height) >= (positionTop + self minHeight)
		ifTrue: [
			height := height + (position y - positionTop).
			position := position x @ positionTop ]
		ifFalse: [
			position := position x @ (position y + height - self minHeight).
			height := self minHeight ]
]

{ #category : #accessing }
CpWindow >> width [

	^ width
]
