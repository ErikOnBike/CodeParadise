Class {
	#name : #CynHelpHighlight,
	#superclass : #Object,
	#instVars : [
		'fromPos',
		'fromSize',
		'toPos',
		'toSize',
		'path'
	],
	#category : #'CodeParadise-Canyon-App-Help'
}

{ #category : #'instance creation' }
CynHelpHighlight class >> at: aPoint [

	^ self basicNew
		initializeWithPoint: aPoint ;
		yourself
]

{ #category : #accessing }
CynHelpHighlight class >> maxRadius [

	"Answer the minimal radius for a box corner or an ellipse"

	^ 16
]

{ #category : #'instance creation' }
CynHelpHighlight class >> new [

	self errorNewReplacedBy: #at:
]

{ #category : #accessing }
CynHelpHighlight >> element [

	^ path
]

{ #category : #private }
CynHelpHighlight >> finalRatio [

	"Answer the ration of the destination"

	"If becoming 'empty' use the initial ratio (or otherwise assume square ratio)"
	toSize y = 0
		ifTrue: [
			^ fromSize y = 0
				ifTrue: [ 1 ]
				ifFalse: [ fromSize x / fromSize y ] ].

	^ toSize x / toSize y
]

{ #category : #initialization }
CynHelpHighlight >> initialize [

	super initialize.

	fromSize := 0 @ 0.

	path := CpSvgElement newWithTag: #path
]

{ #category : #initialization }
CynHelpHighlight >> initializeWithPoint: aPoint [

	self initialize.

	fromPos := aPoint
]

{ #category : #private }
CynHelpHighlight >> isEllipseRatio: aFloat [

	"Ratio between 2/3 and 3/2 is an ellipse ratio (otherwise a box ratio)"

	^ aFloat between: 0.66666666 and: 1.5
]

{ #category : #private }
CynHelpHighlight >> path: aString [

	path attributeAt: #d put: aString
]

{ #category : #private }
CynHelpHighlight >> positionAt: aFloat [

	"Answer the position based on the specified percentage (value between 0 and 1) between from and to"

	^ (fromPos x + ((toPos x - fromPos x) * aFloat)) @
		(fromPos y + ((toPos y - fromPos y) * aFloat))
]

{ #category : #initialization }
CynHelpHighlight >> release [

	path ifNotNil: [
		path destroy.
		path := nil ].

	super release
]

{ #category : #private }
CynHelpHighlight >> shapeFor: aPoint [

	"Answer the shape of the specified ratio.
	Small shapes are always ellipses.
	For empty shapes (a 0 width or 0 height or both 0) answer nil."

	| width height minSize |

	width := aPoint x.
	height := aPoint y.
	(width = 0 or: [ height = 0 ])
		ifTrue: [ ^ nil ].

	minSize := 3 * self class maxRadius.
	(width < minSize and: [ height < minSize ])
		ifTrue: [ ^ #ellipse ].

	^ (self isEllipseRatio: width / height)
		ifTrue: [ #ellipse ]
		ifFalse: [ #box ]
]

{ #category : #private }
CynHelpHighlight >> shapeShiftAt: aFloat toBoxAt: posPoint size: sizePoint [

	"Update the shape (knowing it becomes a box) with the specified position and size"

	| start startSize now horizontalSide verticalSide |

	"If currently still in ellipse shape, draw regular ellipse"
	(self shapeFor: sizePoint) = #ellipse
		ifTrue: [ ^ self updateEllipseAt: posPoint size: sizePoint ].

	"Find timing when shape started shifting (when box ratio was encountered)"
	start := self shapeShiftStart.
	startSize := self sizeAt: start.

	"The current moment as percentage between start and end"
	now := (aFloat - start) / (1 - start).

	"Start making the (horizontal and vertical) sides larger to become a box"
	horizontalSide := (toSize x - (2 * self class maxRadius)) * now max: 0.
	verticalSide := (toSize y - (2 * self class maxRadius)) * now max: 0.

	"Draw box with rounded corners using the specified sides"
	self updateBoxAt: posPoint size: sizePoint horizontalSide: horizontalSide verticalSide: verticalSide
]

{ #category : #private }
CynHelpHighlight >> shapeShiftAt: aFloat toEllipseAt: posPoint size: sizePoint [

	"Update the shape (knowing it becomes an ellipse) with the specified position and size"

	| start startSize now horizontalSide verticalSide |

	"If currently still in box shape, draw regular box"
	(self shapeFor: sizePoint) = #box
		ifTrue: [ ^ self updateBoxAt: posPoint size: sizePoint ].

	"Find timing when shape started shifting (when ellipse ratio was encountered)"
	start := self shapeShiftStart.
	startSize := self sizeAt: start.

	"The current moment as percentage between start and end"
	now := (aFloat - start) / (1 - start).

	"Start making the (horizontal and vertical) sides smaller to become an ellipse"
	horizontalSide := (startSize x - (2 * self class maxRadius)) * (1 - now) min: 0.
	verticalSide := (startSize y - (2 * self class maxRadius)) * (1 - now) min: 0.

	"Draw box with rounded corners using the specified sides (add 20% to size, see #updateEllipseAt:size:)"
	self updateBoxAt: posPoint size: (sizePoint + (sizePoint * 0.2 * now)) horizontalSide: horizontalSide verticalSide: verticalSide
]

{ #category : #private }
CynHelpHighlight >> shapeShiftStart [

	"Answer the start of the shape shift between source and destination.
	This is a number between 0 and 1 indicating (in time) where the
	shape shift took place.

	Implementation:
	Assume this is called from method that knows a shape shift will occur.
	Assume we never resize to 0 height (so no divide by zero on destination size).
	If source height is 0, there will be no shape shift (so no divide by zero
	on source size)."

	| divisor start1 start2 |

	"Try 2/3"
	divisor := 3.0 * (toSize x - fromSize x) - (2.0 * (toSize y - fromSize y)).
	divisor = 0
		ifFalse: [
			start1 := (2.0 * fromSize y - (3.0 * fromSize x)) / divisor.
			(start1 between: 0.0 and: 1.0)
				ifFalse: [ start1 := nil ] ].

	"Try 3/2"
	divisor := 2.0 * (toSize x - fromSize x) - (3.0 * (toSize y - fromSize y)).
	divisor = 0
		ifFalse: [
			start2 := (3.0 * fromSize y - (2.0 * fromSize x)) / divisor.
			(start2 between: 0.0 and: 1.0)
				ifFalse: [ start2 := nil ] ].

	start1 ifNotNil: [ 
		start2 ifNotNil: [ ^ start1 min: start2 ].
		^ start1 ].
	start2 ifNotNil: [ ^ start2 ].

	self errorCr: 'Unable to find ratio switch for ', fromSize printString, ' and ', toSize printString.

	^ 0.0
]

{ #category : #private }
CynHelpHighlight >> sizeAt: aFloat [

	"Answer the size based on the specified percentage (value between 0 and 1) between from and to"

	^ (fromSize x + ((toSize x - fromSize x) * aFloat)) @
		(fromSize y + ((toSize y - fromSize y) * aFloat))
]

{ #category : #updating }
CynHelpHighlight >> toPos: posPoint size: sizePoint [

	toPos := posPoint.
	toSize := sizePoint
]

{ #category : #private }
CynHelpHighlight >> updateBoxAt: posPoint size: sizePoint [

	"Update (the box) with the specified position and size"

	| width height halfWidth halfHeight radius |

	width := sizePoint x.
	height := sizePoint y.

	halfWidth := width / 2.
	halfHeight := height / 2.

	"Calculate corner radius"
	radius := (halfWidth min: halfHeight) min: self class maxRadius.

	self updateBoxAt: posPoint size: sizePoint horizontalSide: (width - (2 * radius)) verticalSide: (height - (2 * radius))
]

{ #category : #private }
CynHelpHighlight >> updateBoxAt: posPoint size: sizePoint horizontalSide: xFloat verticalSide: yFloat [

	"Update (the box) with the specified position, size and sides"

	| width height halfWidth halfHeight radiusX radiusY leftX rightX topY bottomY arcOptions |

	width := sizePoint x.
	height := sizePoint y.

	halfWidth := width / 2.
	halfHeight := height / 2.

	"Calculate corner radius"
	radiusX := (width - xFloat) / 2.
	radiusY := (height - yFloat) / 2.

	"Pre-calculate the extremes for x and y taking the radius into account"
	leftX := posPoint x - halfWidth + radiusX.
	rightX := posPoint x + halfWidth - radiusX.
	topY := posPoint y - halfHeight + radiusY.
	bottomY := posPoint y + halfHeight - radiusY.

	"Arc options: angle(0) large-arc(no) clockwise(yes)"
	arcOptions := ' 0 0 1 '.

	self path: (String streamContents: [ :stream |
		stream

			"Move 'cursor' to top-left/north-west of box"
			nextPut: $M ;
			print: leftX ;
			space ;
			print: posPoint y - halfHeight ;

			"Draw top horizontal line"
			nextPut: $H ;
			print: rightX ;

			"Draw first arc on top-right/north-east corner"
			nextPut: $A ;
			print: radiusX ;
			space ;
			print: radiusY ;
			nextPutAll: arcOptions ;
			print: posPoint x + halfWidth ;
			space ;
			print: topY ;

			"Draw right vertical line"
			nextPut: $V ;
			print: bottomY ;

			"Draw second arc on bottom-right/south-east corner"
			nextPut: $A ;
			print: radiusX ;
			space ;
			print: radiusY ;
			nextPutAll: arcOptions ;
			print: rightX ;
			space ;
			print: posPoint y + halfHeight ;

			"Draw bottom horizontal line"
			nextPut: $H ;
			print: leftX ;

			"Draw third arc on bottom-left/south-west corner"
			nextPut: $A ;
			print: radiusX ;
			space ;
			print: radiusY ;
			nextPutAll: arcOptions ;
			print: posPoint x - halfWidth ;
			space ;
			print: bottomY ;

			"Draw left vertical line"
			nextPut: $V ;
			print: topY ;

			"Draw fourth (final) arc to top/north side"
			nextPut: $A ;
			print: radiusX ;
			space ;
			print: radiusY ;
			nextPutAll: arcOptions ;
			print: leftX;
			space ;
			print: posPoint y - halfHeight ;

			"Close path"
			nextPut: $Z ])
]

{ #category : #private }
CynHelpHighlight >> updateEllipseAt: posPoint size: sizePoint [

	"Update (the ellipse) with the specified position and size"

	| radiusX radiusY arcOptions |

	radiusX := (sizePoint x / 2) * 1.2.
	radiusY := (sizePoint y / 2) * 1.2.

	"Arc options: angle(0) large-arc(no) clockwise(yes)"
	arcOptions := ' 0 0 1 '.

	self path: (String streamContents: [ :stream |
		stream

			"Move 'cursor' to top/north of ellipse"
			nextPut: $M ;
			print: posPoint x ;
			space ;
			print: posPoint y - radiusY ;

			"Draw first arc to right/east side"
			nextPut: $A ;
			print: radiusX ;
			space ;
			print: radiusY ;
			nextPutAll: arcOptions ;
			print: posPoint x + radiusX ;
			space ;
			print: posPoint y ;

			"Draw second arc to bottom/south side"
			nextPut: $A ;
			print: radiusX ;
			space ;
			print: radiusY ;
			nextPutAll: arcOptions ;
			print: posPoint x ;
			space ;
			print: posPoint y + radiusY ;

			"Draw third arc to left/west side"
			nextPut: $A ;
			print: radiusX ;
			space ;
			print: radiusY ;
			nextPutAll: arcOptions ;
			print: posPoint x - radiusX ;
			space ;
			print: posPoint y ;

			"Draw fourth (final) arc to top/north side"
			nextPut: $A ;
			print: radiusX ;
			space ;
			print: radiusY ;
			nextPutAll: arcOptions ;
			print: posPoint x ;
			space ;
			print: posPoint y - radiusY ;

			"Close path"
			nextPut: $Z ])
]

{ #category : #updating }
CynHelpHighlight >> updateFinal [

	fromPos := toPos.
	fromSize := toSize
]

{ #category : #updating }
CynHelpHighlight >> updateTo: aFloat [

	| pos size fromShape toShape |

	pos := self positionAt: aFloat.
	size := self sizeAt: aFloat.

	"Get shape of source and destination (destination is always valid, but source might start unknown: 0 @ 0)"
	fromShape := self shapeFor: fromSize.
	toShape := self shapeFor: toSize.

	"Ensure no shape-shift when coming from an 'empty' shape"
	fromShape ifNil: [ fromShape := toShape ].

	fromShape = toShape
		ifTrue: [
			toShape = #ellipse
				ifTrue: [ self updateEllipseAt: pos size: size ]
				ifFalse: [ self updateBoxAt: pos size: size ] ]
		ifFalse: [
			"Perform some shape shifting"
			toShape = #ellipse
				ifTrue: [ self shapeShiftAt: aFloat toEllipseAt: pos size: size ]
				ifFalse: [ self shapeShiftAt: aFloat toBoxAt: pos size: size ] ]
]
