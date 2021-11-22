Class {
	#name : #CpMouseEvent,
	#superclass : #CpUserInterfaceEvent,
	#instVars : [
		'offsetX',
		'offsetY',
		'buttons',
		'modifiers'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #accessing }
CpMouseEvent >> buttonCount [

	^ self buttons bitCount
]

{ #category : #accessing }
CpMouseEvent >> buttons [

	"Answer an Integer specifying the different buttons pressed.
	Combine the following individual numbers:
		1 - primary button
		2 - secondary button
		4 - third (auxiliary) button (like wheel mouse or middle button)
		8 - fourth button
		16 - fifth button"

	^ buttons
]

{ #category : #accessing }
CpMouseEvent >> buttons: anInteger [

	buttons := anInteger
]

{ #category : #testing }
CpMouseEvent >> hasAltModifier [

	^ (self modifiers bitAnd: 1) ~= 0
]

{ #category : #testing }
CpMouseEvent >> hasCtrlModifier [

	^ (self modifiers bitAnd: 2) ~= 0
]

{ #category : #testing }
CpMouseEvent >> hasMetaModifier [

	^ (self modifiers bitAnd: 4) ~= 0
]

{ #category : #testing }
CpMouseEvent >> hasModifiers [

	^ self modifiers ~= 0
]

{ #category : #testing }
CpMouseEvent >> hasShiftModifier [

	^ (self modifiers bitAnd: 8) ~= 0
]

{ #category : #testing }
CpMouseEvent >> isFifthButtonPressed [

	^ buttons anyMask: 16
]

{ #category : #testing }
CpMouseEvent >> isFourthButtonPressed [

	^ buttons anyMask: 8
]

{ #category : #testing }
CpMouseEvent >> isNoButtonPressed [

	^ buttons = 0
]

{ #category : #testing }
CpMouseEvent >> isOnlyPrimaryButtonPressed [

	^ buttons = 1
]

{ #category : #testing }
CpMouseEvent >> isOnlySecondaryButtonPressed [

	^ buttons = 2
]

{ #category : #testing }
CpMouseEvent >> isPrimaryButtonPressed [

	^ buttons anyMask: 1
]

{ #category : #testing }
CpMouseEvent >> isSecondaryButtonPressed [

	^ buttons anyMask: 2
]

{ #category : #testing }
CpMouseEvent >> isThirdButtonPressed [

	^ buttons anyMask: 4
]

{ #category : #accessing }
CpMouseEvent >> modifierCount [

	^ self modifiers bitCount
]

{ #category : #accessing }
CpMouseEvent >> modifiers [

	"Answer an Integer specifying the different modifiers pressed.
	Combine the following individual numbers:
		1 - alt
		2 - ctrl
		4 - meta
		8 - shift"

	^ modifiers
]

{ #category : #accessing }
CpMouseEvent >> modifiers: anInteger [

	modifiers := anInteger
]

{ #category : #accessing }
CpMouseEvent >> offset [

	^ offsetX @ offsetY
]

{ #category : #accessing }
CpMouseEvent >> offset: aPoint [

	offsetX := aPoint x.
	offsetY := aPoint y
]

{ #category : #accessing }
CpMouseEvent >> offsetX [

	^ offsetX
]

{ #category : #accessing }
CpMouseEvent >> offsetX: aNumber [

	offsetX := aNumber
]

{ #category : #accessing }
CpMouseEvent >> offsetY [

	^ offsetY
]

{ #category : #accessing }
CpMouseEvent >> offsetY: aNumber [

	offsetY := aNumber
]

{ #category : #printing }
CpMouseEvent >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ', offset: ' ;
		print: self offset ;
		nextPutAll: ', buttons: ' ;
		print: buttons ;
		nextPutAll: ', modifiers: ' ;
		print: modifiers
]
