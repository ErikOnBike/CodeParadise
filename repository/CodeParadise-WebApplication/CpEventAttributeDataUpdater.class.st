Class {
	#name : #CpEventAttributeDataUpdater,
	#superclass : #CpPrefixedAttributeDataUpdater,
	#instVars : [
		'eventClass'
	],
	#category : #'CodeParadise-WebApplication-Support'
}

{ #category : #accessing }
CpEventAttributeDataUpdater class >> prefix [

	^ 'event-'
]

{ #category : #initialization }
CpEventAttributeDataUpdater >> initializeWithKey: keyString name: nameString [

	super initializeWithKey: keyString name: nameString.

	"Find the Event class for the receiver (see class comment of CpTemplateBasedDomUpdater for an explanation).
	Only the Cp prefix is removed, other prefixes remain allowing events like ion-change or sl-change to be used too."
	CpBaseEvent allSubclassesDo: [ :each |
		((each name withoutPrefix: #Cp) withoutSuffix: #Event) asKebabCase = name
			ifTrue: [
				eventClass := each.
				^ self ] ].

	self warnCr: 'Unknown event type ', name
]

{ #category : #rendering }
CpEventAttributeDataUpdater >> renderData: anObject on: anElement [

	"It is assumed the data is a BlockClosure or understands #cull:"

	eventClass ifNil: [ ^ self ].

	"Remove any previous event handler (when updating)"
	anElement unsubscribe: self.

	"Add a new event handler"
	(self valueFromData: anObject) ifNotNil: [ :block |
		anElement when: eventClass do: block for: self ]
]
