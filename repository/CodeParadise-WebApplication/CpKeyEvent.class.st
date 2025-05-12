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

{ #category : #'navigation keys' }
CpKeyEvent class >> arrowDown [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'navigation keys' }
CpKeyEvent class >> arrowLeft [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'navigation keys' }
CpKeyEvent class >> arrowRight [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'navigation keys' }
CpKeyEvent class >> arrowUp [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'audio keys' }
CpKeyEvent class >> audioVolumeDown [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'audio keys' }
CpKeyEvent class >> audioVolumeMute [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'audio keys' }
CpKeyEvent class >> audioVolumeUp [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'editing keys' }
CpKeyEvent class >> backspace [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'editing keys' }
CpKeyEvent class >> clear [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'ui keys' }
CpKeyEvent class >> contextMenu [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #private }
CpKeyEvent class >> createConditionalEvent [

	"Answer a ConditionalEvent for the receiver on the key defined by the calling method (selector)"

	^ self key: thisContext sender method selector asString capitalized
]

{ #category : #'editing keys' }
CpKeyEvent class >> delete [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'navigation keys' }
CpKeyEvent class >> end [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'whitespace keys' }
CpKeyEvent class >> enter [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'ui keys' }
CpKeyEvent class >> escape [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'function keys' }
CpKeyEvent class >> f1 [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'function keys' }
CpKeyEvent class >> f10 [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'function keys' }
CpKeyEvent class >> f11 [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'function keys' }
CpKeyEvent class >> f12 [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'function keys' }
CpKeyEvent class >> f13 [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'function keys' }
CpKeyEvent class >> f14 [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'function keys' }
CpKeyEvent class >> f15 [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'function keys' }
CpKeyEvent class >> f16 [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'function keys' }
CpKeyEvent class >> f17 [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'function keys' }
CpKeyEvent class >> f18 [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'function keys' }
CpKeyEvent class >> f19 [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'function keys' }
CpKeyEvent class >> f2 [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'function keys' }
CpKeyEvent class >> f20 [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'function keys' }
CpKeyEvent class >> f3 [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'function keys' }
CpKeyEvent class >> f4 [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'function keys' }
CpKeyEvent class >> f5 [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'function keys' }
CpKeyEvent class >> f6 [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'function keys' }
CpKeyEvent class >> f7 [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'function keys' }
CpKeyEvent class >> f8 [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'function keys' }
CpKeyEvent class >> f9 [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'instance creation' }
CpKeyEvent class >> fromString: aString [

	"Answer an instance of the receiver (for use as an Event to listen for).
	The input may contain markers like A, C, M, S to indicate modifiers.

	For example:
		CpKeyPressEvent fromString: 'C-S-s' => (CpKeyPressEvent key: 's') & (CpCtrlKeyDown + CpShiftKeyDown)
		CpKeyPressEvent fromString: #'S-Enter' => (CpKeyPressEvent enter & CpNoModifiersDown)
	"

	| keyString modifiers |

	modifiers := CpNoModifiersDown.
	keyString := aString copy.

	"Repeatedly add modifiers (duplicates will be ignored because of modifier implementation)"
	[ keyString size > 2 and: [ keyString second = $- ] ] whileTrue: [

		"Add modifier if found, otherwise signal error"
		(CpModifierKeyDownCondition fromCharacter: keyString first)
			ifNotNil: [ :modifierCondition | modifiers := modifiers + modifierCondition ]
			ifNil: [ self error: ('Unknown modifier {1} in {2} for KeyEvent' format: { keyString first asString . aString }) ].

		keyString := keyString allButFirst: 2 ].

	"Validate a key is left"
	keyString ifEmpty: [ 	self error: 'Invalid KeyEvent string representation: ', aString ].

	"Answer key event with the modifiers applied"
	^ (self key: keyString) & modifiers
]

{ #category : #'ui keys' }
CpKeyEvent class >> help [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'navigation keys' }
CpKeyEvent class >> home [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #announcing }
CpKeyEvent class >> key: aString [

	"Answer a ConditionalEvent for the receiver on the key specified"

	^ self & (CpKeyEventCondition key: aString)
]

{ #category : #announcing }
CpKeyEvent class >> keyRangeFrom: lowerBoundKeyString to: upperBoundKeyString [

	^ self & (CpKeyRangeEventCondition fromKey: lowerBoundKeyString to: upperBoundKeyString)
]

{ #category : #'navigation keys' }
CpKeyEvent class >> pageDown [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'navigation keys' }
CpKeyEvent class >> pageUp [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'whitespace keys' }
CpKeyEvent class >> space [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

{ #category : #'whitespace keys' }
CpKeyEvent class >> tab [

	"Answer a ConditionalEvent for the receiver on the key defined by the selector"

	^ self createConditionalEvent
]

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
	to behave more consistently."

	| key |

	key := self propertyAt: #key.

	^ key = ' '
		ifTrue: [ 'Space' ]
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
	(key size = 1 or: [ self isNoModifierDown ])
		ifTrue: [ ^ key ].

	^ String streamContents: [ :stream |
		self isAltKeyDown
			ifTrue: [ stream nextPutAll: 'A-' ].
		self isCtrlKeyDown
			ifTrue: [ stream nextPutAll: 'C-' ].
		self isMetaKeyDown
			ifTrue: [ stream nextPutAll: 'M-' ].
		self isShiftKeyDown
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
