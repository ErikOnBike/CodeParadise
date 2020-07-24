"
I am a Key(board) Event. I offer an interface to low level key press and release events.
For text entry please also have a look at InputEvent.
"
Class {
	#name : #CpKeyEvent,
	#superclass : #CpEvent,
	#instVars : [
		'modifiers',
		'key',
		'isComposing'
	],
	#category : #'WebApplication-Events'
}

{ #category : #testing }
CpKeyEvent >> hasAltModifier [

	^ (self modifiers bitAnd: 1) ~= 0
]

{ #category : #testing }
CpKeyEvent >> hasCtrlModifier [

	^ (self modifiers bitAnd: 2) ~= 0
]

{ #category : #testing }
CpKeyEvent >> hasMetaModifier [

	^ (self modifiers bitAnd: 4) ~= 0
]

{ #category : #testing }
CpKeyEvent >> hasShiftModifier [

	^ (self modifiers bitAnd: 8) ~= 0
]

{ #category : #accessing }
CpKeyEvent >> isComposing [

	^ isComposing
]

{ #category : #accessing }
CpKeyEvent >> isComposing: aBoolean [

	isComposing := aBoolean
]

{ #category : #testing }
CpKeyEvent >> isInputEvent [

	^ true
]

{ #category : #accessing }
CpKeyEvent >> key [

	^ key
]

{ #category : #accessing }
CpKeyEvent >> key: aString [

	key := aString
]

{ #category : #accessing }
CpKeyEvent >> keyWithModifiers [

	"Answer a String representing the receiver's key with modifiers prepended"

	self key ifNil: [ ^ nil ].
	self key size = 1 ifTrue: [ ^ self key ].

	^ String streamContents: [ :stream |
		self hasAltModifier
			ifTrue: [ stream nextPutAll: 'A-' ].
		self hasCtrlModifier
			ifTrue: [ stream nextPutAll: 'C-' ].
		self hasMetaModifier
			ifTrue: [ stream nextPutAll: 'M-' ].
		self hasShiftModifier
			ifTrue: [ stream nextPutAll: 'S-' ].
		stream nextPutAll: self key ]
]

{ #category : #accessing }
CpKeyEvent >> modifiers [

	"Answer an Integer specifying the different modifiers pressed.
	Combine the following individual numbers:
		1 - alt
		2 - ctrl
		4 - meta
		8 - shift"

	^ modifiers
]

{ #category : #accessing }
CpKeyEvent >> modifiers: anInteger [

	modifiers := anInteger
]

{ #category : #printing }
CpKeyEvent >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ', modifiers: '.
	self modifiers printOn: aStream.
	aStream nextPutAll: ', key: '.
	self key printOn: aStream.
	aStream nextPutAll: ', isComposing: '.
	self isComposing printOn: aStream
]
