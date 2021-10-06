"
I represent a DOM rectangle in a web browser context.
See https://developer.mozilla.org/en-US/docs/Web/API/DOMRect.

I am mainly used to supply a result for the CpDomElement >> #boundingClientRectangle
(similar to https://developer.mozilla.org/en-US/docs/Web/API/Element/getBoundingClientRect).

"
Class {
	#name : #CpDomRectangle,
	#superclass : #Object,
	#instVars : [
		'top',
		'left',
		'bottom',
		'right'
	],
	#category : #'CodeParadise-WebApplication-DOM'
}

{ #category : #accessing }
CpDomRectangle >> bottom [

	^ bottom
]

{ #category : #accessing }
CpDomRectangle >> bottom: anInteger [

	bottom := anInteger
]

{ #category : #accessing }
CpDomRectangle >> centerPoint [

	"Answer a Point in the center (horizontally and vertically) of the receiver"

	^ ((left + right) / 2) @ ((top + bottom) / 2)
]

{ #category : #accessing }
CpDomRectangle >> eastPoint [

	"Answer a Point in the east of the receiver"

	^ right @ ((top + bottom) / 2)
]

{ #category : #accessing }
CpDomRectangle >> height [

	^ bottom - top
]

{ #category : #initialization }
CpDomRectangle >> initialize [

	super initialize.

	top := left := bottom := right := 0
]

{ #category : #accessing }
CpDomRectangle >> left [

	^ left
]

{ #category : #accessing }
CpDomRectangle >> left: anInteger [

	left := anInteger
]

{ #category : #accessing }
CpDomRectangle >> northPoint [

	"Answer a Point in the north of the receiver"

	^ ((left + right) / 2) @ top
]

{ #category : #printing }
CpDomRectangle >> printOn: aStream [

	aStream
		nextPutAll: self class name ;
		nextPutAll: '(left: ' ;
		print: left ;
		nextPutAll: ', top: ' ;
		print: top ;
		nextPutAll: ', right' ;
		print: right ;
		nextPutAll: ', bottom: ' ;
		print: bottom ;
		nextPut: $)
]

{ #category : #accessing }
CpDomRectangle >> right [

	^ right
]

{ #category : #accessing }
CpDomRectangle >> right: anInteger [

	right := anInteger
]

{ #category : #accessing }
CpDomRectangle >> southPoint [

	"Answer a Point in the south of the receiver"

	^ ((left + right) / 2) @ bottom
]

{ #category : #accessing }
CpDomRectangle >> top [

	^ top
]

{ #category : #accessing }
CpDomRectangle >> top: anInteger [

	top := anInteger
]

{ #category : #accessing }
CpDomRectangle >> westPoint [

	"Answer a Point in the west of the receiver"

	^ left @ ((top + bottom) / 2)
]

{ #category : #accessing }
CpDomRectangle >> width [

	^ right - left
]
