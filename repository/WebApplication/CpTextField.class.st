Class {
	#name : #CpTextField,
	#superclass : #CpView,
	#instVars : [
		'text'
	],
	#category : #'WebApplication-Components'
}

{ #category : #accessing }
CpTextField class >> cpRequiredClasses [

	^ super cpRequiredClasses, { CpCursor }
]

{ #category : #'instance creation' }
CpTextField class >> new [

	"Answer new instance of the receiver.
	Register interest in this instance for event handling."

	| instance |

	instance := super new.
	CpBrowserEventHandler current registerInterestIn: instance.
	^ instance
]

{ #category : #'web resources' }
CpTextField class >> style [

	<webResource: #css>

	^ ':host {
			display: inline-flex;
			position: relative;
			white-space: nowrap;
			font-size: .8rem;
		}

		#container {
			display: inline-block;
			width: 100%;
			height: 100%;
			min-height: inherit;
			padding: .25rem;
			border-radius: .25rem;
			border: 1px solid #333;
			cursor: text;
		}

		#container:focus {
			outline: none;
		}

		#entry {
			display: inline-block;
			width: 100%;
			height: 100%;
			overflow: hidden;
			text-overflow: hidden;
			white-space: nowrap;
		}'
]

{ #category : #'web resources' }
CpTextField class >> template [

	<webResource: #html>

	^ '<div id="container" tabindex="-1"><div id="entry"><slot name="text"></slot></div></div>'
]

{ #category : #'as yet unclassified' }
CpTextField >> handleArrowLeft [

	self children ifNotNil: [ :children |

		| cursorIndex previousElement nextElement |

		"Find cursor"
		cursorIndex := children findFirst: [ :each | each class = CpCursor ].
		cursorIndex > 1
			ifFalse: [ ^ self ].

		"Move cursor 'into' previous item by moving characters from left to right"
		previousElement := children at: cursorIndex - 1.
		previousElement textContent ifEmpty: [ ^ self ].
		nextElement := children at: cursorIndex + 1 ifAbsent: [
			self appendChild: (CpHtmlElement newWithTag: #span) atSlotNamed: #text ].
		nextElement textContent: previousElement textContent last asString, nextElement textContent.
		previousElement textContent: previousElement textContent allButLast ]
]

{ #category : #'as yet unclassified' }
CpTextField >> handleArrowRight [

	self children ifNotNil: [ :children |

		| cursorIndex previousElement nextElement |

		"Find cursor"
		cursorIndex := children findFirst: [ :each | each class = CpCursor ].
		cursorIndex = 0
			ifTrue: [ ^ self ].

		"Move cursor 'into' next item by moving characters from right to left"
		nextElement := children at: cursorIndex + 1 ifAbsent: [ ^ self ].
		nextElement textContent ifEmpty: [ ^ self ].
		previousElement := children at: cursorIndex - 1 ifAbsent: [
			self insertChild: (CpHtmlElement newWithTag: #span) before: (children at: cursorIndex) atSlotNamed: #text ].
		previousElement textContent: previousElement textContent, nextElement textContent first asString.
		nextElement textContent: nextElement textContent allButFirst ]
]

{ #category : #adding }
CpTextField >> handleBackspace [

	self children ifNotNil: [ :children |

		| cursorIndex previousElement |

		"Find cursor"
		cursorIndex := children findFirst: [ :each | each class = CpCursor ].
		cursorIndex = 0
			ifTrue: [ ^ self ].

		"Remove last character from previous element"
		previousElement := children at: cursorIndex - 1 ifAbsent: [ ^ self ].
		previousElement textContent ifEmpty: [ ^ self ].
		previousElement textContent: previousElement textContent allButLast ]
]

{ #category : #'event handling' }
CpTextField >> handleClickEvent: aClickEvent [

	"Remove existing cursor"
	(self allDescendantsMatching: #'cp-cursor') do: [ :each | each remove ].

	"Set new cursor and give focus"
	(self appendChild: CpCursor new atSlotNamed: #text) focus
]

{ #category : #adding }
CpTextField >> handleDelete [

	self children ifNotNil: [ :children |

		| cursorIndex nextElement |

		"Find cursor"
		cursorIndex := children findFirst: [ :each | each class = CpCursor ].
		cursorIndex = 0
			ifTrue: [ ^ self ].

		"Remove first character from next element"
		nextElement := children at: cursorIndex + 1 ifAbsent: [ ^ self ].
		nextElement textContent ifEmpty: [ ^ self ].
		nextElement textContent: nextElement textContent allButFirst ]
]

{ #category : #adding }
CpTextField >> handleInsert: aKeyString [

	self children ifNotNil: [ :children |

		| cursorIndex previousElement |

		"Find cursor"
		cursorIndex := children findFirst: [ :each | each class = CpCursor ].
		cursorIndex = 0
			ifTrue: [ ^ self ].

		"Add key to previous element"
		previousElement := children at: cursorIndex - 1 ifAbsent: [
			self insertChild: (CpHtmlElement newWithTag: #span) before: (children at: cursorIndex) atSlotNamed: #text ].
		previousElement textContent: previousElement textContent, aKeyString ]
]

{ #category : #'as yet unclassified' }
CpTextField >> handleKey: aKeyString [

	self flag: #todo.	"Create better solution for handling keys"

	aKeyString = 'ArrowLeft'
		ifTrue: [ ^ self handleArrowLeft ].
	aKeyString = 'ArrowRight'
		ifTrue: [ ^ self handleArrowRight ].
	aKeyString = 'Backspace'
		ifTrue: [ ^ self handleBackspace ].
	aKeyString = 'Delete'
		ifTrue: [ ^ self handleDelete ].
	aKeyString size = 1
		ifTrue: [ ^ self handleInsert: aKeyString ].
	self crTrace: 'Unhandled key ', aKeyString
]

{ #category : #'event handling' }
CpTextField >> handleKeyPressEvent: aKeyPressEvent [

	aKeyPressEvent key ifNotNil: [ :key | self handleKey: key ]

]

{ #category : #accessing }
CpTextField >> text: aString [

	self appendChild: (aString inHtmlTag: #span) atSlotNamed: #text
]
