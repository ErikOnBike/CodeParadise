Class {
	#name : #CpPropertyChanged,
	#superclass : #ValueChanged,
	#instVars : [
		'name'
	],
	#category : #'CodeParadise-Model-Property'
}

{ #category : #'instance creation' }
CpPropertyChanged class >> name: aSymbol [

	"Answer a new instance of the receiver with the specified values"

	^ self basicNew
		initializeWithName: aSymbol ;
		yourself
]

{ #category : #'instance creation' }
CpPropertyChanged class >> name: aSymbol oldValue: oldValue newValue: newValue [

	"Answer a new instance of the receiver with the specified values"

	^ self basicNew
		initializeWithName: aSymbol oldValue: oldValue newValue: newValue ;
		yourself
]

{ #category : #announcing }
CpPropertyChanged >> handlesAnnouncement: anAnnouncement [

	"Answer whether the receiver handles the specified announcement.
	This is normally a class side method, but it is used as an instance
	variant to allow a property name to be specified. This makes it possible
	to define a 'parameterized' announcement.

	Usage example:
		self model when: (CpPropertyChanged name: #title) send: #titleChanged: to: self.
	"

	^ (self class handlesAnnouncement: anAnnouncement)
		and: [ self name = anAnnouncement name ]
]

{ #category : #initialization }
CpPropertyChanged >> initializeWithName: aSymbol [

	self initialize.

	name := aSymbol
]

{ #category : #initialization }
CpPropertyChanged >> initializeWithName: aSymbol oldValue: old newValue: new [

	self initializeWithName: aSymbol.

	oldValue := old.
	newValue := new
]

{ #category : #accessing }
CpPropertyChanged >> name [

	^ name
]
