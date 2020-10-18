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
			position: absolute;
			width: 100%;
			height: 100%;
			overflow: hidden;
		}
		.container * {
			background-color: var(--window-background-color, #ccc);
		}
		:host(.dragging) .container * {
			background-color: var(--window-dragging-background-color, rgba(255, 0, 0, .1));
		}
		#topLeft, #topRight, #bottomLeft, #bottomRight {
			position: absolute;
			width: 8px;
			height: 8px;
		}
		#top, #bottom {
			position: absolute;
			left: 8px;
			width: calc(100% - 16px);
			height: 8px;
			cursor: move;
		}
		#left, #right {
			position: absolute;
			top: 8px;
			width: 8px;
			height: calc(100% - 16px);
			cursor: move;
		}
		#top {
			top: 0;
			border-top: 1px solid #000;
		}
		#bottom {
			bottom: 0;
			border-bottom: 1px solid #000;
		}
		#left {
			left: 0;
			border-left: 1px solid #000;
		}
		#right {
			right: 0;
			border-right: 1px solid #000;
		}
		#topLeft {
			top: 0;
			left: 0;
			border-top: 1px solid #000;
			border-left: 1px solid #000;
			border-top-left-radius: 8px;
			cursor: nw-resize;
		}
		#topRight {
			top: 0;
			right: 0;
			border-top: 1px solid #000;
			border-right: 1px solid #000;
			border-top-right-radius: 8px;
			cursor: ne-resize;
		}
		#bottomLeft {
			bottom: 0;
			left: 0;
			border-bottom: 1px solid #000;
			border-left: 1px solid #000;
			border-bottom-left-radius: 8px;
			cursor: sw-resize;
		}
		#bottomRight {
			bottom: 0;
			right: 0;
			border-bottom: 1px solid #000;
			border-right: 1px solid #000;
			border-bottom-right-radius: 8px;
			cursor: se-resize;
		}
		slot[name="content"] {
			display: block;
			position: absolute;
			top: 8px;
			left: 8px;
			width: calc(100% - 16px);
			height: calc(100% - 16px);
		}'
]

{ #category : #'web resources' }
CpWindow class >> template [

	<webResource: #html>

	^ '<div class="container">
			<div id="topLeft"></div><div id="top"></div><div id="topRight"></div>
			<div id="left"></div><slot name="content"></slot><div id="right"></div>
			<div id="bottomLeft"></div><div id="bottom"></div><div id="bottomRight"></div>
		</div>'
]

{ #category : #'event handling' }
CpWindow >> handleDragEvent: aDragEvent [

	(#(#top #left #bottom #right) includes: aDragEvent elementId)
		ifTrue: [ ^ self handleWindowMove: aDragEvent ].

	(#(#topLeft #topRight #bottomLeft #bottomRight) includes: aDragEvent elementId)
		ifTrue: [ ^ self handleWindowResize: aDragEvent ]
]

{ #category : #'event handling' }
CpWindow >> handlePointerDownEvent: aPointerDownEvent [

	self makeTopWindow
]

{ #category : #'event handling' }
CpWindow >> handleWindowMove: aDragEvent [

	| clientOffset point |

	"Prevent other views from receiving events"
	aDragEvent isEnded
		ifTrue: [ CpScreen stopDragging: self ]
		ifFalse: [ CpScreen makeDraggable: self ].

	clientOffset := aDragEvent offset.
	point := aDragEvent lastPoint.

	position := (point x - clientOffset x) @ (point y - clientOffset y).

	self updatePosition
]

{ #category : #'event handling' }
CpWindow >> handleWindowResize: aDragEvent [

	| point resizeCorner |

	"Prevent other views from receiving events"
	aDragEvent isEnded
		ifTrue: [ CpScreen stopDragging: self ]
		ifFalse: [ CpScreen makeDraggable: self ].

	point := aDragEvent lastPoint.
	resizeCorner := aDragEvent elementId.

	"Distinguish all four corners by x and y axis"
	(resizeCorner endsWith: #Left)
		ifTrue: [ self updateLeftSide: point x ]
		ifFalse: [ self updateRightSide: point x ].
	(resizeCorner beginsWith: #top)
		ifTrue: [ self updateTopSide: point y ]
		ifFalse: [ self updateBottomSide: point y ].

	self render
]

{ #category : #accessing }
CpWindow >> height [

	^ self size y printString, 'px'
]

{ #category : #initialization }
CpWindow >> initialize [

	super initialize.

	position := 100 @ 100.
	size := self minWidth @ self minHeight.

	self
		styleAt: #position put: #absolute ;
		render
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
