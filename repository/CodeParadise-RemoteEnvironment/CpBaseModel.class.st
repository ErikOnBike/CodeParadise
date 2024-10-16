"
I am a Model, I announce when my value changed.

"
Class {
	#name : #CpBaseModel,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #announcing }
CpBaseModel >> announce: anAnnouncement [

	"Let the receiver announce the specified Announcement"

	"Nobody has registered interest"
	announcer ifNil: [ ^ self ].

	announcer announce: anAnnouncement
]

{ #category : #initialization }
CpBaseModel >> release [

	announcer ifNotNil: [
		announcer subscriptions reset.
		announcer := nil ].

	super release
]

{ #category : #announcing }
CpBaseModel >> removeSubscription: aSubscription [

	"Remove the specified subscription from the receiver"

	"Nobody has registered interest"
	announcer ifNil: [ ^ aSubscription ].

	announcer removeSubscription: aSubscription
]

{ #category : #announcing }
CpBaseModel >> unsubscribe: anObject [

	"Unsubscribe the specified Object from Announcements of the receiver"

	"Nobody has registered interest"
	announcer ifNil: [ ^ nil ].

	^ announcer unsubscribe: anObject
]

{ #category : #announcing }
CpBaseModel >> valueChanged [
	
	"Announce the fact that the receiver's value changed.

	Implementation:
	This method is for compatibility with Model and NewValueHolder.
	The method contains some duplicate code with #announce: for
	performance reasons."

	"Nobody has registered interest"
	announcer ifNil: [ ^ self ].

	announcer announce: (ValueChanged newValue: self)
]

{ #category : #deprecated }
CpBaseModel >> when: anAnnouncementClass do: aBlock [

	self warnCr: 'Use of any Announcer''s #when:do: is deprecated, please use #when:do:for:'.

	^ self when: anAnnouncementClass do: aBlock for: aBlock receiver
]

{ #category : #announcing }
CpBaseModel >> when: anAnnouncementClass do: aBlock for: anObject [

	"Subscribe anObject to announcements of anAnnouncementClass class. 
	 When announced, aBlock is evaluated."

	announcer ifNil: [ announcer := Announcer new ].

	^ announcer
		when: anAnnouncementClass do: aBlock for: anObject
]

{ #category : #announcing }
CpBaseModel >> when: anAnnouncementClass send: aSymbol to: anObject [

	"Let the sender subscribe to the specified announcement of the receiver.
	See Announcer>>#when:send:to:"

	announcer ifNil: [ announcer := Announcer new ].

	^ announcer when: anAnnouncementClass send: aSymbol to: anObject
]

{ #category : #deprecated }
CpBaseModel >> whenChangedDo: aBlock [

	self warnCr: 'Use of any Announcer''s #whenChanged:do: is deprecated, please use #whenChangedDo:for:'.

	^ self whenChangedDo: aBlock for: aBlock receiver
]

{ #category : #announcing }
CpBaseModel >> whenChangedDo: aBlock for: anObject [

	"Let the sender subscribe to the value changed announcement of the receiver.

	Implementation:
	This method is for compatibility with Model and NewValueHolder"

	^ self when: ValueChanged do: aBlock for: anObject
]

{ #category : #announcing }
CpBaseModel >> whenChangedSend: aSymbol to: anObject [

	"Let the sender subscribe to the value changed announcement of the receiver

	Implementation:
	This method is for compatibility with Model and NewValueHolder"

	^ self when: ValueChanged send: aSymbol to: anObject
]
