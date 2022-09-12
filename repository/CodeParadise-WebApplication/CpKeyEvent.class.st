"
I am a Key(board) Event. I offer an interface to low level key press and release events.
For text entry please also have a look at InputEvent.

I have a slightly different behavior than the browser variant. For the space(bar) key I answer #Space as key value instead of ' '. This is to be more consistent across whitespace characters like #Tab and #Backspace.

"
Class {
	#name : #CpKeyEvent,
	#superclass : #CpUserInterfaceEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #accessing }
CpKeyEvent >> isComposing [

	"Answer a Boolean indicating a key is being composed"

	^ self propertyAt: #isComposing
]

{ #category : #accessing }
CpKeyEvent >> key [

	"Answer a String representing the key for the receiver.
	Control characters (more precisely: characters with a non printable representation)
	are answered as Strings (like 'Enter', 'Tab', 'ArrowLeft', etc).
	In contrast with browsers a space is answered as 'Space' which allows #keyWithModifiers
	do behave more consistently."

	| key |

	key := self propertyAt: #key.

	^ key = ' '
		ifTrue: [ #Space ]
		ifFalse: [ key ]
]

{ #category : #accessing }
CpKeyEvent >> keyWithModifiers [

	"Answer a String representing the receiver's key with modifiers prepended.
	A modifier is only prepended for control characters (more precisely: characters
	with non printable representation).
	If multiple modifiers are pressed, all are prepended in alphabetical order.

	Prefixes:
		'A': Alt (also called Option Key on Mac)
		'C': Control
		'M': Meta (also called Command Key on Mac and Windows Key on Windows)
		'S': Shift

	For example: 'a', 'A', 'S-Tab', 'A-ArrowLeft', 'C-S-Enter', etc."

	| key |

	key := self key ifNil: [ ^ nil ].
	(key size = 1 or: [ self hasModifiers not ])
		ifTrue: [ ^ key ].

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

{ #category : #printing }
CpKeyEvent >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ', modifiers: ' ;
		print: self modifiers ;
		nextPutAll: ', key: ' ;
		print: self key ;
		nextPutAll: ', repeat: ' ;
		print: self repeat ;
		nextPutAll: ', isComposing: ' ;
		print: self isComposing
]

{ #category : #accessing }
CpKeyEvent >> repeat [

	"Answer a Boolean indicating the key is being held down"

	^ self propertyAt: #repeat
]
