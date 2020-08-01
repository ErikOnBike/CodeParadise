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

{ #category : #initialization }
FuiElement >> initialize [

	super initialize.

	announcer := Announcer new
]

{ #category : #initialization }
FuiElement >> release [

	announcer ifNotNil: [
		announcer subscriptions reset.
		announcer := nil ].

	super release
]

{ #category : #accessing }
FuiElement >> shadowElement [

	"Answer the shadow DOM's element (this is the first element within the shadow DOM) of the receiver"

	<primitive: 'primitiveFUIElementShadowElement' module: 'CpFomanticPlugin'>
	self primitiveFailed

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
