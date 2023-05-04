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
		when: CpClickEvent & (CpAltKeyDown & CpShiftKeyDown) send: #onClickAndAltAndShift: to: self ;
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

	"Add the specified condition to the receiver"

	(conditions ifNil: [ conditions := Set new ])
		add: aCondition
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
CpConditionalEvent >> asEventClass [

	^ eventClass
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

{ #category : #printing }
CpConditionalEvent >> printOn: aStream [

	aStream
		nextPutAll: self class name ;
		nextPutAll: ' conditions: ' ;
		print: (conditions ifNil: [ #() ])
]
