Class {
	#name : #CpPointerEvent,
	#superclass : #CpUserInterfaceEvent,
	#instVars : [
		'offset',
		'pointerId',
		'pointerType'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #accessing }
CpPointerEvent >> offset [

	^ offset
]

{ #category : #accessing }
CpPointerEvent >> offset: aPoint [

	offset := aPoint
]

{ #category : #accessing }
CpPointerEvent >> pointerId [

	^ pointerId
]

{ #category : #accessing }
CpPointerEvent >> pointerId: aNumber [

	pointerId := aNumber
]

{ #category : #accessing }
CpPointerEvent >> pointerType [

	^ pointerType
]

{ #category : #accessing }
CpPointerEvent >> pointerType: aString [

	pointerType := aString
]

{ #category : #printing }
CpPointerEvent >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ', offset: '.
	self offset printOn: aStream.
	aStream nextPutAll: ', pointerId: '.
	self pointerId printOn: aStream.
	aStream nextPutAll: ', pointerType: '.
	self pointerType printOn: aStream
]
