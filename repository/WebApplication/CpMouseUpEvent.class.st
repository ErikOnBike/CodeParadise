Class {
	#name : #CpMouseUpEvent,
	#superclass : #CpMouseEvent,
	#category : #'WebApplication-Events'
}

{ #category : #accessing }
CpMouseUpEvent class >> type [

	^ #mouseup
]

{ #category : #visiting }
CpMouseUpEvent >> accept: aVisitor [

	aVisitor mouseUp: self
]

{ #category : #sending }
CpMouseUpEvent >> sendTo: anObject [

	anObject handleMouseUpEvent: self
]
