Class {
	#name : #CpMouseDownEvent,
	#superclass : #CpMouseEvent,
	#category : #'WebApplication-Events'
}

{ #category : #accessing }
CpMouseDownEvent class >> type [

	^ #mousedown
]

{ #category : #visiting }
CpMouseDownEvent >> accept: aVisitor [

	aVisitor mouseDown: self
]

{ #category : #sending }
CpMouseDownEvent >> sendTo: anObject [

	anObject handleMouseDownEvent: self
]
