Class {
	#name : #FuiElement,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'announcer'
	],
	#category : #'CodeParadise-WebApplication-Fomantic-Elements'
}

{ #category : #'accessing - colors' }
FuiElement class >> allColors [

	^ #(#primary #secondary #tertiary #positive #negative #orange #yellow #olive #green #teal #blue #violet #purple #pink #brown #grey)
]

{ #category : #'web resources' }
FuiElement class >> style [

	<webResource: #css>

	^ '@import "https://cdn.jsdelivr.net/npm/fomantic-ui@2.8.6/dist/semantic.min.css";'
]

{ #category : #accessing }
FuiElement class >> type [

	"Answer a Symbol specifying the (Javascript) type of the receiver"

	self subclassResponsibility
]

{ #category : #announcing }
FuiElement >> announce: anAnnouncement [

	self announcer announce: anAnnouncement
]

{ #category : #accessing }
FuiElement >> announcer [

	^ announcer
]

{ #category : #'accessing - colors' }
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

{ #category : #'accessing - state' }
FuiElement >> performOnElement: behavior [

	"Perform the specified behavior (a Dictionary or Symbol) on the receiver's element"

	^ self performOnElement: behavior as: self class type
]

{ #category : #'accessing - state' }
FuiElement >> performOnElement: behavior as: type [

	"Perform the specified behavior (a Dictionary or Symbol) on the receiver's element with the specified type (a Symbol)"

	<primitive: 'primitiveFUIElementPerformOnElement:as:' module: 'CpFomanticPlugin'>
	self primitiveFailed

]

{ #category : #'accessing - colors' }
FuiElement >> primary [

	self beColor: #primary
]

{ #category : #'accessing - colors' }
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

{ #category : #'accessing - colors' }
FuiElement >> secondary [

	self beColor: #secondary
]

{ #category : #accessing }
FuiElement >> shadowElement [

	"Answer the shadow DOM's element (this is the first element within the shadow DOM) of the receiver"

	<primitive: 'primitiveFUIElementShadowElement' module: 'CpFomanticPlugin'>
	self primitiveFailed

]

{ #category : #'accessing - colors' }
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
