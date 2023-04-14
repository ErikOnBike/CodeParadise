Class {
	#name : #CpFieldChanged,
	#superclass : #CpFieldEvent,
	#instVars : [
		'value'
	],
	#category : #'CodeParadise-WebApplication-MVP-Support'
}

{ #category : #accessing }
CpFieldChanged class >> field: aSymbol value: anObject [

	^ self basicNew
		initializeWithField: aSymbol value: anObject ;
		yourself
]

{ #category : #testing }
CpFieldChanged >> handlesAnnouncement: anAnnouncement [

	"Answer whether the receiver handles the specified announcement.
	This is normally a class side method, but it is used as an instance
	variant to allow a field name and value to be specified. This makes
	it possible to define a 'parameterized' announcement.

	Usage example:
		self view when: (CpFieldChanged field: #title value: 'hello') send: #titleChangedToHello to: self.
		self view when: (CpFieldChanged field: #title value: '') send: #titleMadeEmpty to: self.
	"

	^ (super handlesAnnouncement: anAnnouncement)
		and: [ self value = anAnnouncement value ]
]

{ #category : #initialization }
CpFieldChanged >> initializeWithField: aSymbol value: anObject [

	self initializeWithField: aSymbol.

	value := anObject
]

{ #category : #accessing }
CpFieldChanged >> value [

	^ value
]
