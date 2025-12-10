Class {
	#name : #CynHelpHighlight,
	#superclass : #Object,
	#instVars : [
		'fromPos',
		'fromSize',
		'toPos',
		'toSize',
		'ellipse'
	],
	#category : #'CodeParadise-Canyon-App-Help'
}

{ #category : #'instance creation' }
CynHelpHighlight class >> at: aPoint [

	^ self basicNew
		initializeWithPoint: aPoint ;
		yourself
]

{ #category : #'instance creation' }
CynHelpHighlight class >> new [

	self errorNewReplacedBy: #at:
]

{ #category : #accessing }
CynHelpHighlight >> currentPos [

	^ (ellipse attributeAt: #cx) asNumber @ (ellipse attributeAt: #cy) asNumber
]

{ #category : #accessing }
CynHelpHighlight >> currentSize [

	^ (ellipse attributeAt: #rx) asNumber @ (ellipse attributeAt: #ry) asNumber
]

{ #category : #accessing }
CynHelpHighlight >> element [

	^ ellipse
]

{ #category : #initialization }
CynHelpHighlight >> initialize [

	super initialize.

	fromSize := 0 @ 0.

	ellipse := (CpSvgElement newWithTag: #ellipse)
		attributeAt: #cx put: '0' ;
		attributeAt: #cy put: '0' ;
		attributeAt: #rx put: '0' ;
		attributeAt: #ry put: '0' ;
		yourself
]

{ #category : #initialization }
CynHelpHighlight >> initializeWithPoint: aPoint [

	self initialize.

	fromPos := aPoint
]

{ #category : #accessing }
CynHelpHighlight >> positionAt: aFloat [

	"Answer the position based on the specified percentage (value between 0 and 1) between from and to"

	^ (fromPos x + ((toPos x - fromPos x) * aFloat)) @
		(fromPos y + ((toPos y - fromPos y) * aFloat))
]

{ #category : #initialization }
CynHelpHighlight >> release [

	ellipse ifNotNil: [
		ellipse destroy.
		ellipse := nil ].

	super release
]

{ #category : #accessing }
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

{ #category : #updating }
CynHelpHighlight >> updateFinal [

	fromPos := toPos.
	fromSize := toSize
]

{ #category : #updating }
CynHelpHighlight >> updateTo: aFloat [

	| pos size |

	pos := self positionAt: aFloat.
	size := self sizeAt: aFloat.

	ellipse
		attributeAt: #cx put: pos x printString ;
		attributeAt: #cy put: pos y printString ;
		attributeAt: #rx put: size x printString ;
		attributeAt: #ry put: size y printString
]
