"
I am a View in a Model-View-Presenter pattern.
I only live in a ClientEnvironnent.

Implementation:
I cannot respond to messages I receive from a Presenter, since we live in different
environements and message sends to objects are implemented as 'fire and forget'.

"
Class {
	#name : #CpView,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'announcer',
		'keymapper'
	],
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #accessing }
CpView class >> currentPlatform [

	^ CpClientEnvironment current variableAt: #OS
]

{ #category : #accessing }
CpView class >> defaultKeyMapping [

	^ Dictionary new
]

{ #category : #testing }
CpView class >> isPlatformLinux [

	^ self currentPlatform = #linux
]

{ #category : #testing }
CpView class >> isPlatformMacOS [

	^ self currentPlatform = #macos
]

{ #category : #testing }
CpView class >> isPlatformWindows [

	^ self currentPlatform = #windows
]

{ #category : #'web resources' }
CpView class >> template [

	<webResource: #html>

	^ '<div>&lt;empty&gt;</div>'
]

{ #category : #announcing }
CpView >> announce: anAnnouncement [

	self announcer announce: anAnnouncement
]

{ #category : #accessing }
CpView >> announcer [

	^ announcer
]

{ #category : #initialization }
CpView >> initialize [

	super initialize.

	announcer := Announcer new.
	keymapper := CpKeyMapper new.

	self class defaultKeyMapping keysAndValuesDo: [ :key :value |
		keymapper addMappingFrom: key to: value ].

	CpBrowserEventHandler current registerInterestIn: self
]

{ #category : #accessing }
CpView >> keymapper [

	^ keymapper
]

{ #category : #performing }
CpView >> performMessage: aMessage [

	"Perform the specified message on the receiver"

	aMessage sendTo: self
]

{ #category : #initialization }
CpView >> release [

	announcer ifNotNil: [
		announcer subscriptions reset.
		announcer := nil ].
	keymapper ifNotNil: [
		keymapper release.
		keymapper := nil ].

	super release
]

{ #category : #announcing }
CpView >> serverAnnounce: anAnnouncement [

	"Announce the specified Announcement on the server (for a Presenter).

	Implementation:
	Wrap the Announcement in a ViewAnnouncement for easy delivery to the Presenter."

	CpClientEnvironment current
		serverAnnounce: (CpViewAnnouncement forView: self announcing: anAnnouncement asAnnouncement)
]

{ #category : #announcing }
CpView >> when: anAnnouncementClass do: aBlock [

	"Let the sender subscribe to the specified announcement of the receiver.
	See Announcer>>#when:do:"

	^ self announcer when: anAnnouncementClass do: aBlock
]

{ #category : #announcing }
CpView >> when: anAnnouncementClass send: aSymbol to: anObject [

	"Let the sender subscribe to the specified announcement of the receiver.
	See Announcer>>#when:send:to:"

	^ self announcer when: anAnnouncementClass send: aSymbol to: anObject
]
