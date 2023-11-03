Class {
	#name : #CpRichTextField,
	#superclass : #CpView,
	#instVars : [
		'text',
		'keymapper'
	],
	#category : #'CodeParadise-Beach-Components'
}

{ #category : #accessing }
CpRichTextField class >> defaultKeyMapping [

	self flag: #todo.	"Handle OS specific keymappings better"

	^ Dictionary new
		at: 'ArrowLeft' put: 'CharacterLeft' ;
		at: 'ArrowRight' put: 'CharacterRight' ;
		at: (CpClientEnvironment isPlatformMacOS ifTrue: [ 'A-ArrowLeft' ] ifFalse: [ 'C-ArrowLeft' ]) put: 'WordLeft' ;
		at: (CpClientEnvironment isPlatformMacOS ifTrue: [ 'A-ArrowRight' ] ifFalse: [ 'C-ArrowRight' ]) put: 'WordRight' ;
		yourself
]

{ #category : #'web resources' }
CpRichTextField class >> style [

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
			overflow: hidden;
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
			white-space: nowrap;
		}'
]

{ #category : #'web resources' }
CpRichTextField class >> template [

	<webResource: #html>

	^ '<div id="container" tabindex="-1"><div id="entry"><slot name="text"></slot></div></div>'
]

{ #category : #'text deleting' }
CpRichTextField >> handleBackspace [

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
CpRichTextField >> handleBeforeInputEvent: aBeforeInputEvent [

	(#('insertText' 'insertCompositionText' 'insertFromComposition' 'insertFromPaste') includes: aBeforeInputEvent inputType)
		ifTrue: [ ^ self handleInsert: aBeforeInputEvent data ].

	self crTrace: aBeforeInputEvent printString
]

{ #category : #'cursor navigation' }
CpRichTextField >> handleCharacterLeft [

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

{ #category : #'cursor navigation' }
CpRichTextField >> handleCharacterRight [

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

{ #category : #'event handling' }
CpRichTextField >> handleClickEvent: aClickEvent [

	"Remove existing cursor"
	(self allDescendantsMatching: #'cp-cursor') do: [ :each | each remove ].

	"Set new cursor and give focus"
	(self appendChild: CpCursor new atSlotNamed: #text) focus
]

{ #category : #'event handling' }
CpRichTextField >> handleCompositionEndEvent: aCompositionEndEvent [

	self crTrace: aCompositionEndEvent printString
]

{ #category : #'event handling' }
CpRichTextField >> handleCompositionStartEvent: aCompositionStartEvent [

	self crTrace: aCompositionStartEvent printString
]

{ #category : #'event handling' }
CpRichTextField >> handleCompositionUpdateEvent: aCompositionUpdateEvent [

	self crTrace: aCompositionUpdateEvent printString
]

{ #category : #'text deleting' }
CpRichTextField >> handleDelete [

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

{ #category : #'text inserting' }
CpRichTextField >> handleInsert: aKeyString [

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

{ #category : #'event handling' }
CpRichTextField >> handleKey: aKeyString [

	"Handle the specified key. The key can contain modifiers like 'C-M-A' to denote Ctrl-Meta-A.
	See also CpKeyEvent>>keyWithModifiers"

	| handlerSelector |

	self flag: #todo.	"Create better solution for handling keys"

	"Perform direct mapping to a handler"
	handlerSelector := ('handle', aKeyString) asSymbol.
	(self class includesSelector: handlerSelector)
		ifTrue: [ ^ self perform: handlerSelector ].

	self crTrace: 'Unhandled key ', aKeyString
]

{ #category : #'event handling' }
CpRichTextField >> handleKeyPressEvent: aKeyPressEvent [

	aKeyPressEvent keyWithModifiers
		ifNotNil: [ :keyWithModifiers | self handleKey: (self keymapper map: keyWithModifiers) ]

]

{ #category : #initialization }
CpRichTextField >> initialize [

	super initialize.

	keymapper := CpKeyMapper new.

	self class defaultKeyMapping keysAndValuesDo: [ :key :value |
		keymapper addMappingFrom: key to: value ].

	self flag: #todo "This class needs fixing: handlers are not installed by default anymore"
]

{ #category : #accessing }
CpRichTextField >> keymapper [

	^ keymapper
]

{ #category : #initialization }
CpRichTextField >> release [

	keymapper ifNotNil: [
		keymapper release.
		keymapper := nil ].

	super release
]

{ #category : #accessing }
CpRichTextField >> text: aString [

	self appendChild: (aString inHtmlTag: #span) atSlotNamed: #text
]
