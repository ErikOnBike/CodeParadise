"
I am a Model in a Model-View-Presenter pattern.
I announce when my value changed.

"
Class {
	#name : #CpModel,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #announcing }
CpModel >> announce: anAnnouncement [

	"Let the receiver announce the specified Announcement"

	self announcer announce: anAnnouncement
]

{ #category : #accessing }
CpModel >> announcer [

	^ announcer
]

{ #category : #initialization }
CpModel >> initialize [

	super initialize.

	announcer := Announcer new
]

{ #category : #dependencies }
CpModel >> release [

	announcer ifNotNil: [
		announcer subscriptions reset.
		announcer := nil ].

	super release
]

{ #category : #announcing }
CpModel >> unsubscribe: anObject [

	"Unsubscribe the specified Object from Announcements of the receiver"

	^ self announcer unsubscribe: anObject
]

{ #category : #announcing }
CpModel >> valueChanged [
	
	"Announce the fact that the receiver's value changed.

	Implementation:
	This method is for compatibility with Model and NewValueHolder"

	self announcer announce: (ValueChanged newValue: self)
]

{ #category : #announcing }
CpModel >> when: anAnnouncementClass do: aValuable [

	"Let the sender subscribe to the specified announcement of the receiver.
	See Announcer>>#when:do:"

	self announcer when: anAnnouncementClass do: aValuable
]

{ #category : #announcing }
CpModel >> when: anAnnouncementClass send: aSymbol to: anObject [

	"Let the sender subscribe to the specified announcement of the receiver.
	See Announcer>>#when:send:to:"

	^ self announcer when: anAnnouncementClass send: aSymbol to: anObject
]

{ #category : #announcing }
CpModel >> whenChangedDo: aBlock [

	"Let the sender subscribe to the value changed announcement of the receiver.

	Implementation:
	This method is for compatibility with Model and NewValueHolder"

	self when: ValueChanged do: aBlock
]

{ #category : #announcing }
CpModel >> whenChangedSend: aSymbol to: anObject [

	"Let the sender subscribe to the value changed announcement of the receiver

	Implementation:
	This method is for compatibility with Model and NewValueHolder"

	self when: ValueChanged send: aSymbol to: anObject
]
