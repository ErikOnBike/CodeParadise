"
I am an Input Event. I offer an interface to higher level text entry events.
To distinguish individual key strokes please also have a look at KeyEvent.
"
Class {
	#name : #CpInputEvent,
	#superclass : #CpEvent,
	#instVars : [
		'data',
		'inputType',
		'isComposing'
	],
	#category : #'WebApplication-Events'
}

{ #category : #visiting }
CpInputEvent >> accept: aVisitor [

	aVisitor input: self
]

{ #category : #accessing }
CpInputEvent >> data [

	^ data
]

{ #category : #accessing }
CpInputEvent >> data: aString [

	data := aString
]

{ #category : #accessing }
CpInputEvent >> inputType [

	^ inputType
]

{ #category : #accessing }
CpInputEvent >> inputType: aString [

	inputType := aString
]

{ #category : #accessing }
CpInputEvent >> isComposing [

	^ isComposing
]

{ #category : #accessing }
CpInputEvent >> isComposing: aBoolean [

	isComposing := aBoolean
]

{ #category : #printing }
CpInputEvent >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ', data: '.
	self data printOn: aStream.
	aStream nextPutAll: ', inputType: '.
	self inputType printOn: aStream.
	aStream nextPutAll: ', isComposing: '.
	self isComposing printOn: aStream
]

{ #category : #sending }
CpInputEvent >> sendTo: anObject [

	anObject handleInputEvent: self
]
