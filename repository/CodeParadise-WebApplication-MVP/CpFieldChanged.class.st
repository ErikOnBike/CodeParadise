"
I am a generic announcement for (input) Fields being changed in the View.
I can have a value to further specify what has actually changed.

See some examples in the class comment for CpBasicEvent.

"
Class {
	#name : #CpFieldChanged,
	#superclass : #CpBasicEvent,
	#instVars : [
		'value'
	],
	#category : #'CodeParadise-WebApplication-MVP-Support'
}

{ #category : #'instance creation' }
CpFieldChanged class >> id: aSymbol [

	"Answer an instance of the receiver with no specific value.
	This allows announcements to be parameterized
	(see also CpFieldChanged >> #handlesAnnouncement:).

	Implementation:
	Use the UndefinedObject class to indicate 'no value'.
	This value will normally not be used inside a field. Any class
	would probably do as alternative as well. Because currently class
	variables are not supported this approach is taken."

	^ self id: aSymbol value: UndefinedObject
]

{ #category : #'instance creation' }
CpFieldChanged class >> id: aSymbol value: anObject [

	^ self basicNew
		initializeWithId: aSymbol value: anObject ;
		yourself
]

{ #category : #testing }
CpFieldChanged >> handlesAnnouncement: anAnnouncement [

	"Answer whether the receiver handles the specified announcement.
	This is normally a class side method, but it is used as an instance
	variant to allow a field id and optionally a value to be specified.
	This makes it possible to define a 'parameterized' announcement.
	See class comment for further explanation and examples."

	^ (super handlesAnnouncement: anAnnouncement)
		and: [ self matchesValueIn: anAnnouncement ]
]

{ #category : #testing }
CpFieldChanged >> hasValue [

	"Answer whether the receiver has an explicit value.
	The value UndefinedObject is used as a placeholder to indicate no value is set.
	This allows nil to be used as a valid value."

	^ value ~~ UndefinedObject
]

{ #category : #initialization }
CpFieldChanged >> initializeWithId: aSymbol value: anObject [

	self initializeWithId: aSymbol.

	value := anObject
]

{ #category : #testing }
CpFieldChanged >> matchesValueIn: anAnnouncement [

	"Answer whether the receiver's value matches the one in the specified
	announcement. Assume the announcement has the same interface as the
	receiver (same class or same protocol supported)."

	"If the receiver has no value, ignore the value of the other announcement"
	self hasValue
		ifFalse: [ ^ true ].

	"If the specified announcement does not have value, there is no match"
	anAnnouncement hasValue
		ifFalse: [ ^ false ].

	^ value = anAnnouncement value
]

{ #category : #printing }
CpFieldChanged >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ', value: ' ;
		print: value
]

{ #category : #accessing }
CpFieldChanged >> value [

	"Answer the value of the receiver or nil if no (explicit) value is present"

	^ self hasValue
		ifTrue: [ value ]
]
