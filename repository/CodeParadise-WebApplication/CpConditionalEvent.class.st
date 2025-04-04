"
I am a conditional event, meaning I maintain a collection of conditions which need
to be met before I will be dispatched. I rely on a regular (non conditional) event
to be triggered in the browser (or through code like in a CustomEvent).

I can be used to specify conditions without using an explicit #where: clause on the
announcement. This increases readability when adding event handlers.

Some examples follow below. A number of ConditionalEvents are created using class
side methods on CpEvent (or one of the subclasses). These are present in the examples
below as well.

	aDomElement
		when: CpKeyPressed & CpAltKeyDown send: #someKeyAndAltPressed: to: self ;
		when: CpClickEvent & (CpAltKeyDown + CpShiftKeyDown) send: #onClickAndAltAndShift: to: self ;
		when: CpKeyPressEvent enter send: #onEnterPressed: to: self ;
		when: CpKeyPressEvent space & CpCtrlKeyDown send: #onCtrlSpacePressed: to: self ;
		when: CpClickEvent noModifiers send: #onClickWithoutModifiers: to: self.
"
Class {
	#name : #CpConditionalEvent,
	#superclass : #Object,
	#instVars : [
		'eventClass',
		'conditions'
	],
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #'instance creation' }
CpConditionalEvent class >> eventClass: anEventClass [

	"Answer an instance of the receiver representing an Announcement class for the specified
	Event class. My instances can maintain conditions which are required when handling the
	events. This allows for different combinations of conditions to be specified without the
	need for a class per combination.

	For example:
		aDomElement when: CpPrimaryClickEvent & CpShiftKeyDown send: #onShiftPrimaryClick: to: self.
		aDomElement when: CpSecondaryClickEvent & CpMetaKeyDown & CpLongClick send: #onLongMetaSecondaryClick: to: self.
	"

	^ self basicNew
		initializeWithEventClass: anEventClass ;
		yourself
]

{ #category : #combining }
CpConditionalEvent >> & aCondition [

	"Add the specified condition to the receiver.
	(Answer the receiver to allow other conditions to be added using & again.)"

	self addCondition: aCondition.

	^ self
]

{ #category : #copying }
CpConditionalEvent >> , anEvent [

	"Combine the receiver with the specified event.

	For example in:
		aDomElement when: (CpKeyPressEvent key: '/'), (CpKeyPressEvent key: '?') send: #onSearch to: self
	"

	^ AnnouncementSet with: self with: anEvent
]

{ #category : #combining }
CpConditionalEvent >> addCondition: aCondition [

	"Add the specified condition to the receiver"

	^ (conditions ifNil: [ conditions := Set new ])
		add: aCondition
]

{ #category : #announcing }
CpConditionalEvent >> addListenerTo: anElement [

	"Add an event listener to the specified element.

	Implementation:
	Let the actual event class add the listener. Provide the conditions
	to allow specific handling, although normally this will be handled
	by the receiver which will check for the conditions when the event
	is triggered. For some specific situations, like performance of the
	MutationObserver, conditions are used to set the JavaScript event
	listener up correctly."

	eventClass addListenerTo: anElement withConditions: (conditions ifNil: [ #() ])
]

{ #category : #testing }
CpConditionalEvent >> areConditionsMetForEvent: anEvent [

	"Answer a Boolean indicating whether all conditions are met for the specified event"

	^ conditions
		ifNotNil: [
			conditions allSatisfy: [ :each | each value: anEvent ] ]
		ifNil: [ true ]
]

{ #category : #announcing }
CpConditionalEvent >> handlesAnnouncement: anEvent [

	"Answer whether the receiver handles the specified announcement.

	Implementation:
	Check if all conditions are met (next to being correct event).
	Since this method is called for different events, an optimized
	implementation is chosen. This limits the readability a little."

	^ (eventClass handlesAnnouncement: anEvent)
		and: [ self areConditionsMetForEvent: anEvent ]
]

{ #category : #initialization }
CpConditionalEvent >> initializeWithEventClass: anEventClass [

	self initialize.

	eventClass := anEventClass
]

{ #category : #limiting }
CpConditionalEvent >> only [

	"Answer an instance of the receiver without any 'special' conditions"

	eventClass addConditionsToDenySpecialsTo: self
]

{ #category : #printing }
CpConditionalEvent >> printOn: aStream [

	aStream
		nextPutAll: self class name ;
		nextPutAll: ' conditions: ' ;
		print: (conditions ifNil: [ #() ])
]

{ #category : #announcing }
CpConditionalEvent >> removeListenerFrom: anElement [

	"Remove an event listener from the specified element.

	Implementation: see #addListenerTo:"

	eventClass removeListenerFrom: anElement withConditions: (conditions ifNil: [ #() ])
]

{ #category : #accessing }
CpConditionalEvent >> type [

	"Answer the event type of the receiver"

	^ eventClass type
]
