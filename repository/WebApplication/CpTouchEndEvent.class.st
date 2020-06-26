Class {
	#name : #CpTouchEndEvent,
	#superclass : #CpTouchEvent,
	#category : #'WebApplication-Events'
}

{ #category : #accessing }
CpTouchEndEvent class >> type [

	^ #touchend
]

{ #category : #visiting }
CpTouchEndEvent >> accept: aVisitor [

	aVisitor touchEnd: self
]

{ #category : #sending }
CpTouchEndEvent >> sendTo: anObject [

	anObject handleTouchEndEvent: self
]
