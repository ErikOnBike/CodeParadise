Class {
	#name : #CpTouchStartEvent,
	#superclass : #CpTouchEvent,
	#category : #'WebApplication-Events'
}

{ #category : #accessing }
CpTouchStartEvent class >> type [

	^ #touchstart
]

{ #category : #visiting }
CpTouchStartEvent >> accept: aVisitor [

	aVisitor touchStart: self
]

{ #category : #sending }
CpTouchStartEvent >> sendTo: anObject [

	anObject handleTouchStartEvent: self
]
