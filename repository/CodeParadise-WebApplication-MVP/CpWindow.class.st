Class {
	#name : #CpWindow,
	#superclass : #CpView,
	#instVars : [
		'position',
		'size'
	],
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #'web resources' }
CpWindow class >> style [

	<webResource: #css>

	^ '* {
			box-sizing: border-box;
		}
		.dragging * {
			pointer-events: none;
			-moz-user-select: none;
			-webkit-user-select: none;
			-ms-user-select: none;
			user-select: none;
		}
		:host(.dragging) {
			pointer-events: auto;
		}
		:host(.dragging) * {
			pointer-events: none;
			-moz-user-select: none;
			-webkit-user-select: none;
			-ms-user-select: none;
			user-select: none;			
		}
		.container {
			display: grid;
			grid-template-columns: auto;
			grid-template-rows: minmax(1.2em, max-content) auto;
			width: 100%;
			height: 100%;
			overflow: hidden;
			border-radius: 8px;
			border: var(--window-border-size, 1px) solid var(--window-border-color, #333);
			background-color: var(--window-background-color, #ddd);
		}
		#titleBar {
			display: grid;
			grid-template-columns: minmax(min-content, 1fr) auto minmax(min-content, 1fr);
			grid-template-rows: auto;
			background: linear-gradient(#eee, var(--window-background-color, #ddd));
			cursor: move;
		}
		#controls {
			height: calc(1.125em + 6px);
			padding-left: 8px;
			padding-right: 8px;
			white-space: nowrap;
		}
		#controls ::slotted(cp-icon) {
			display: inline-block;
			width: calc(1.125em + 6px);
			height: calc(1.125em + 6px);
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
		#title * {
			pointer-events: none;
		}
		#content {
			width: 100%;
			height: 100%;
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

	^ '<div class="container">
			<div id="titleBar">
				<div id="controls"><slot name="controls"></slot></div>
				<div id="title"><slot name="title">Untitled</slot></div>
			</div>
			<div id="body">
				<div id="content"><slot name="content"></slot></div>
			</div>
			<div id="handles">
				<div id="topLeft" class="corner"></div><div id="top"></div><div id="topRight" class="corner"></div>
				<div id="left" class="side"></div><div id="right" class="side"></div>
				<div id="bottomLeft" class="corner"></div><div id="bottom" class="side"></div><div id="bottomRight" class="corner"></div>
			</div>
		</div>'
]

{ #category : #actions }
CpWindow >> close [

	self serverAnnounce: CpWindowClose
]

{ #category : #'event handling' }
CpWindow >> handlePointerDownEvent: aPointerDownEvent [

	self makeTopWindow
]

{ #category : #'event handling' }
CpWindow >> handleWindowMove: aDragEvent [

	| clientOffset point |

	"Prevent other views from receiving events"
	self flag: #todo. "Responsibility to handle draggability should be changed"
"	aDragEvent isEnded
		ifTrue: [ self parent stopDragging: self ]
		ifFalse: [ self parent makeDraggable: self ]."

	clientOffset := aDragEvent offset.
	point := aDragEvent lastPoint.

	position := (point x - clientOffset x) @ (point y - clientOffset y).

	self updatePosition
]

{ #category : #'event handling' }
CpWindow >> handleWindowResizeCorner: aDragEvent [

	| point resizeCorner |

	"Prevent other views from receiving events"
	self flag: #todo. "Responsibility to handle draggability should be changed"
"	aDragEvent isEnded
		ifTrue: [ self parent stopDragging: self ]
		ifFalse: [ self parent makeDraggable: self ]."

	point := aDragEvent lastPoint.
	resizeCorner := aDragEvent target id.

	"Distinguish all four corners by x and y axis"
	(resizeCorner endsWith: #Left)
		ifTrue: [ self updateLeftSide: point x ]
		ifFalse: [ self updateRightSide: point x ].
	(resizeCorner beginsWith: #top)
		ifTrue: [ self updateTopSide: point y ]
		ifFalse: [ self updateBottomSide: point y ].

	self render
]

{ #category : #'event handling' }
CpWindow >> handleWindowResizeSide: aDragEvent [

	| point resizeSide |

	"Prevent other views from receiving events"
	self flag: #todo. "Responsibility to handle draggability should be changed"
"	aDragEvent isEnded
		ifTrue: [ self parent stopDragging: self ]
		ifFalse: [ self parent makeDraggable: self ]."

	point := aDragEvent lastPoint.
	resizeSide := aDragEvent target id.

	"Distinguish all four sides"
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

	self render
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

	closeControl := CpIcon close
		when: CpClickEvent send: #close to: self ;
		yourself.

	self
		appendChild: closeControl atSlotNamed: #controls ; 
		styleAt: #position put: #absolute ;
		render.

	self shadowRoot
		ifNotNil: [ :shadowRoot |
			(shadowRoot allDescendantsMatching: '.corner')
				do: [ :each | each when: CpDragEvent send: #handleWindowResizeCorner: to: self  ].
			(shadowRoot allDescendantsMatching: '.side')
				do: [ :each | each when: CpDragEvent send: #handleWindowResizeSide: to: self ].
			(shadowRoot firstDescendantMatching: '#titleBar')
				when: CpDragEvent send: #handleWindowMove: to: self ]
]

{ #category : #accessing }
CpWindow >> left [

	^ self position x printString, 'px'
]

{ #category : #updating }
CpWindow >> makeTopWindow [

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
		updatePosition ;
		updateSize
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
CpWindow >> updatePosition [

	self
		styleAt: #top put: self top ;
		styleAt: #left put: self left

]

{ #category : #updating }
CpWindow >> updateRightSide: positionRight [

	size := (positionRight - position x) >= self minWidth
		ifTrue: [ (positionRight - position x) @ size y ]
		ifFalse: [ self minWidth @ size y ]
]

{ #category : #updating }
CpWindow >> updateSize [

	self
		styleAt: #width put: self width ;
		styleAt: #height put: self height
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
