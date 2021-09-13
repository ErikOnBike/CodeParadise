Class {
	#name : #CpPointerEvent,
	#superclass : #CpUserInterfaceEvent,
	#instVars : [
		'offset',
		'pointerId',
		'pointerType',
		'buttons',
		'modifiers'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #testing }
CpPointerEvent >> hasAltModifier [

	^ (self modifiers bitAnd: 1) ~= 0
]

{ #category : #testing }
CpPointerEvent >> hasCtrlModifier [

	^ (self modifiers bitAnd: 2) ~= 0
]

{ #category : #testing }
CpPointerEvent >> hasMetaModifier [

	^ (self modifiers bitAnd: 4) ~= 0
]

{ #category : #testing }
CpPointerEvent >> hasModifiers [

	^ self modifiers ~= 0
]

{ #category : #testing }
CpPointerEvent >> hasShiftModifier [

	^ (self modifiers bitAnd: 8) ~= 0
]

{ #category : #testing }
CpPointerEvent >> isButtonPressed [

	^ buttons ~= 0
]

{ #category : #testing }
CpPointerEvent >> isOnlyPrimaryButtonPressed [

	^ buttons = 1
]

{ #category : #testing }
CpPointerEvent >> isPrimaryButtonPressed [

	^ buttons anyMask: 1
]

{ #category : #accessing }
CpPointerEvent >> modifiers [

	"Answer an Integer specifying the different modifiers pressed.
	Combine the following individual numbers:
		1 - alt
		2 - ctrl
		4 - meta
		8 - shift"

	^ modifiers
]

{ #category : #accessing }
CpPointerEvent >> modifiers: anInteger [

	modifiers := anInteger
]

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
	aStream nextPutAll: ', buttons: '.
	buttons printOn: aStream
]
