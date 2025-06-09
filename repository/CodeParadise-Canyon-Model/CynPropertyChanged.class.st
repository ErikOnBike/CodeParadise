Class {
	#name : #CynPropertyChanged,
	#superclass : #ValueChanged,
	#instVars : [
		'name'
	],
	#category : #'CodeParadise-Canyon-Model-Announcements'
}

{ #category : #'instance creation' }
CynPropertyChanged class >> name: aSymbol [

	"Answer a new instance of the receiver with the specified values"

	^ self basicNew
		initializeWithName: aSymbol ;
		yourself
]

{ #category : #'instance creation' }
CynPropertyChanged class >> name: aSymbol newValue: anObject [

	"Answer a new instance of the receiver with the specified new value"

	^ self name: aSymbol oldValue: nil newValue: anObject
]

{ #category : #'instance creation' }
CynPropertyChanged class >> name: aSymbol oldValue: oldValue newValue: newValue [

	"Answer a new instance of the receiver with the specified values"

	^ self basicNew
		initializeWithName: aSymbol oldValue: oldValue newValue: newValue ;
		yourself
]

{ #category : #announcing }
CynPropertyChanged >> handlesAnnouncement: anAnnouncement [

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
CynPropertyChanged >> initializeWithName: aSymbol [

	self initialize.

	name := aSymbol
]

{ #category : #initialization }
CynPropertyChanged >> initializeWithName: aSymbol oldValue: old newValue: new [

	self initializeWithName: aSymbol.

	oldValue := old.
	newValue := new
]

{ #category : #accessing }
CynPropertyChanged >> name [

	^ name
]
