Class {
	#name : #FuiElement,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'announcer'
	],
	#category : #'CodeParadise-WebApplication-Fomantic-Elements'
}

{ #category : #'as yet unclassified' }
FuiElement class >> allColors [

	^ #(#primary #secondary #tertiary #positive #negative #orange #yellow #olive #green #teal #blue #violet #purple #pink #brown #grey)
]

{ #category : #announcing }
FuiElement >> announce: anAnnouncement [

	self announcer announce: anAnnouncement
]

{ #category : #accessing }
FuiElement >> announcer [

	^ announcer
]

{ #category : #coloring }
FuiElement >> beColor: colorSymbol [

	| classAttribute allClassValues allColorSymbols |

	classAttribute := self shadowElement attributeAt: #class.
	allClassValues := (classAttribute findTokens: ' 	') collect: [ :each | each asSymbol ].
	allColorSymbols := self class allColors.

	"Select all non colors and add the specified color (before the element type which is normally at last position)"
	allClassValues := allClassValues reject: [ :each | allColorSymbols includes: each ].
	colorSymbol ifNotNil: [ allClassValues insert: colorSymbol before: allClassValues size ].

	self flag: #todo.	"No flatten or join method in tiny image yet"
	"Flatten class values"
	self shadowElement attributeAt: #class put: (String streamContents: [ :stream |
		allClassValues do: [ :each |
			stream position > 0
				ifTrue: [ stream nextPut: Character space ].
			stream nextPutAll: each ] ])
]

{ #category : #initialization }
FuiElement >> initialize [

	super initialize.

	announcer := Announcer new
]

{ #category : #coloring }
FuiElement >> primary [

	self beColor: #primary
]

{ #category : #coloring }
FuiElement >> regular [

	self beColor: nil
]

{ #category : #initialization }
FuiElement >> release [

	announcer ifNotNil: [
		announcer subscriptions reset.
		announcer := nil ].

	super release
]

{ #category : #coloring }
FuiElement >> secondary [

	self beColor: #secondary
]

{ #category : #accessing }
FuiElement >> shadowElement [

	"Answer the shadow DOM's element (this is the first element within the shadow DOM) of the receiver"

	<primitive: 'primitiveFUIElementShadowElement' module: 'CpFomanticPlugin'>
	self primitiveFailed

]

{ #category : #coloring }
FuiElement >> tertiary [

	self beColor: #tertiary
]

{ #category : #announcing }
FuiElement >> when: anAnnouncementClass do: aBlock [

	"Let the sender subscribe to the specified announcement of the receiver.
	See Announcer>>#when:do:"

	^ self announcer when: anAnnouncementClass do: aBlock
]

{ #category : #announcing }
FuiElement >> when: anAnnouncementClass send: aSymbol to: anObject [

	"Let the sender subscribe to the specified announcement of the receiver.
	See Announcer>>#when:send:to:"

	^ self announcer when: anAnnouncementClass send: aSymbol to: anObject
]
