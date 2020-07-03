Class {
	#name : #CpClickEvent,
	#superclass : #CpPointerEvent,
	#instVars : [
		'clickPoint'
	],
	#category : #'WebApplication-Events'
}

{ #category : #'instance creation' }
CpClickEvent class >> newFrom: aDictionary [

	"Create a new instance of the receiver based on the specified DOM event (a Javascript object encoded as a Dictionary)"

	| clickPoint |

	clickPoint := self pointFrom: aDictionary.

	^ (super newFrom: aDictionary)
		clickPoint: clickPoint ;
		yourself
]

{ #category : #accessing }
CpClickEvent class >> type [

	^ #click
]

{ #category : #visiting }
CpClickEvent >> accept: aVisitor [

	aVisitor click: self
]

{ #category : #accessing }
CpClickEvent >> clickPoint [

	^ clickPoint
]

{ #category : #accessing }
CpClickEvent >> clickPoint: aPoint [

	clickPoint := aPoint
]

{ #category : #printing }
CpClickEvent >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ', clickPoint: '.
	self clickPoint printOn: aStream
]

{ #category : #sending }
CpClickEvent >> sendTo: anObject [

	anObject handleClickEvent: self
]
