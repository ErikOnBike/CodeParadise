"
I am a Click AnnouncementClass. I can represent the Announcement class for CpAnyClickEvents.
This allows for conveniently specifying which click event is needed. A regular CpClickEvent will
be announced irrespective of the modifiers pressed during the click event or the duration of the click.
The CpAnyClickEvent subclasses allow to specify which button is required (primary or secondary)
for a click event. My responsibility is to add requirements for key modifiers and duration modifiers.

For example:
	aDomElement
		when: CpAnyClickEvent send: #anyButtonNoModifiers to: self.
	aDomElement
		when: CpPrimaryClickEvent send: #onlyPrimaryButtonNoModifiers to: self.
	aDomElement
		when: CpPrimaryClickEvent + CpShiftModifier send: #primaryButtonAndShiftKey to: self.
	aDomElement
		when: CpSecondaryClickEvent + CpMetaModifier + CpLongClickModifier send: #longSecondaryButtonAndMetaKey to: self.

"
Class {
	#name : #CpClickAnnouncementClass,
	#superclass : #Object,
	#instVars : [
		'clickEventClass',
		'keyModifier',
		'clickDurationModifier'
	],
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #'instance creation' }
CpClickAnnouncementClass class >> clickEventClass: aClickEventClass [

	"Answer an instance of the receiver representing an Announcement class for the specified
	ClickEvent class. My instances can maintain modifiers which are required when handling
	click events. This allows for different combinations to be specified without the need for
	a class per combination.

	For example:
		aDomElement when: CpPrimaryClickEvent + CpShiftModifier send: #shiftAndPrimary to: self.
		aDomElement when: CpSecondaryClickEvent + CpMetaModifier + CpLongClickModifier send: #lomgMetaSecondary to: self.
	"

	^ self basicNew
		initializeWithClickEventClass: aClickEventClass ;
		yourself
]

{ #category : #'instance creation' }
CpClickAnnouncementClass class >> noKeyModifierForClickEventClass: aClickEventClass [

	^ (self clickEventClass: aClickEventClass)
		addKeyModifier: CpNoKeyModifier ;
		yourself
]

{ #category : #combining }
CpClickAnnouncementClass >> + aModifier [

	"Add the specified modifier to the receiver"

	aModifier addToClickAnnouncementClass: self
]

{ #category : #combining }
CpClickAnnouncementClass >> addKeyModifier: aKeyModifier [

	"Add the specified key modifier to the receiver"

	keyModifier := keyModifier
		ifNotNil: [ keyModifier + aKeyModifier ]
		ifNil: [ aKeyModifier ]
]

{ #category : #announcing }
CpClickAnnouncementClass >> addListenerTo: anElement [

	"Add an event listener to the specified DOM element.

	Simulate our click event by setting up an event handler to catch the pointer
	'down' and 'up' events which are the start and end of a click."

	anElement
		when: CpPointerDownEvent send: #clickStart: to: self ;
		when: CpPointerUpEvent send: #clickEnd: to: self
]

{ #category : #'processing - private' }
CpClickAnnouncementClass >> clickEnd: aPointerUpEvent [

	"I am acting as a stateful Announcement Class, delegate the behavior to the actual
	Announcement class (which is a CpSyntheticClickEvent or subclass)"

	clickEventClass clickEnd: aPointerUpEvent
]

{ #category : #'processing - private' }
CpClickAnnouncementClass >> clickStart: aPointerDownEvent [

	"I am acting as a stateful Announcement Class, delegate the behavior to the actual
	Announcement class (which is a CpSyntheticClickEvent or subclass)"

	clickEventClass clickStart: aPointerDownEvent withClickAnnouncement: self
]

{ #category : #announcing }
CpClickAnnouncementClass >> handlesAnnouncement: anAnnouncement [

	"I am acting as a stateful Announcement Class, delegate the behavior to the actual
	Announcement class (which is a CpSyntheticClickEvent or subclass).

	Impplementation:
	The real validation whether the click event can be handled is done in #matchesClickEvent:
	which is called from CpSyntheticClickEvent class >> clickEnd:."

	^ clickEventClass handlesAnnouncement: anAnnouncement
]

{ #category : #initialization }
CpClickAnnouncementClass >> initializeWithClickEventClass: aClickEventClass [

	self initialize.

	clickEventClass := aClickEventClass
]

{ #category : #testing }
CpClickAnnouncementClass >> matchesClickEvent: aClickEvent [

	"Answer whether the receiver's requirements match the specified click event"

	keyModifier
		ifNotNil: [
			(keyModifier equals: aClickEvent modifiers)
				ifFalse: [ ^ false ] ].

	clickDurationModifier
		ifNotNil: [
			(clickDurationModifier isValidDuration: aClickEvent duration)
				ifFalse: [ ^ false ] ].

	^ clickEventClass handlesClickEvent: aClickEvent
]

{ #category : #printing }
CpClickAnnouncementClass >> printOn: aStream [

	aStream
		nextPutAll: self class name ;
		nextPutAll: ', clickEventClass: ' ;
		print: clickEventClass ;
		nextPutAll: ', keyModifier: ' ;
		print: keyModifier value ;
		nextPutAll: ', clickDurationModifier: ' ;
		print: clickDurationModifier
]

{ #category : #announcing }
CpClickAnnouncementClass >> removeListenerFrom: anElement [

	"Remove event listener from the specified DOM element.

	Impementation: see #addEventListenerTo:"

	CpPointerDownEvent removeListenerFrom: anElement.
	CpPointerUpEvent removeListenerFrom: anElement
]

{ #category : #combining }
CpClickAnnouncementClass >> setClickDurationModifier: aClickDurationModifier [

	"Set the specified click duration modifier (it replaces the previous
	value in contrast with KeyModifiers which can be added)"

	clickDurationModifier := aClickDurationModifier
]
