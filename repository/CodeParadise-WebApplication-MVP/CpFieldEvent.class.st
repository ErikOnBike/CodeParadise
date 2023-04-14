Class {
	#name : #CpFieldEvent,
	#superclass : #Announcement,
	#instVars : [
		'field'
	],
	#category : #'CodeParadise-WebApplication-MVP-Support'
}

{ #category : #accessing }
CpFieldEvent class >> field: aSymbol [

	^ self basicNew
		initializeWithField: aSymbol ;
		yourself
]

{ #category : #accessing }
CpFieldEvent >> field [

	^ field
]

{ #category : #testing }
CpFieldEvent >> handlesAnnouncement: anAnnouncement [

	"Answer whether the receiver handles the specified announcement.
	This is normally a class side method, but it is used as an instance
	variant to allow a field name to be specified. This makes it possible
	to define a 'parameterized' announcement.

	Usage example:
		self view when: (CpFieldEvent field: #title) send: #titleChanged: to: self.
	"

	^ (self class handlesAnnouncement: anAnnouncement)
		and: [ self field = anAnnouncement field ]
]

{ #category : #initialization }
CpFieldEvent >> initializeWithField: aSymbol [

	self initialize.

	field := aSymbol
]
