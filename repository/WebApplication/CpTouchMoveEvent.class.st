Class {
	#name : #CpTouchMoveEvent,
	#superclass : #CpTouchEvent,
	#category : #'WebApplication-Events'
}

{ #category : #accessing }
CpTouchMoveEvent class >> type [

	^ #touchmove
]

{ #category : #visiting }
CpTouchMoveEvent >> accept: aVisitor [

	aVisitor touchMove: self
]

{ #category : #sending }
CpTouchMoveEvent >> sendTo: anObject [

	anObject handleTouchMoveEvent: self
]
