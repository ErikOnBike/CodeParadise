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

{ #category : #removing }
CpView >> destroy [

	"Destroy the receiver.

	Implementation:
	Unregister from the client environment.
	See: CpMvpWebClientBehavior >> #createView:withId:atParentId:atSlotNamed:atIndex"

	super destroy.

	CpClientEnvironment current objectRegistry
		unregisterObject: self
		ifAbsent: [ "Ignore. Some Views are not created via CpMvpWebClientBehavior and will therefore not be registered" ]
]

{ #category : #performing }
CpView >> downloadContent: anObject type: typeString filename: filenameString [

	"Convenience method to allow download of content"

	CpDownloader content: anObject type: typeString filename: filenameString
]

{ #category : #initialization }
CpView >> initialize [

	super initialize.

	keymapper := CpKeyMapper new.

	self class defaultKeyMapping keysAndValuesDo: [ :key :value |
		keymapper addMappingFrom: key to: value ].

	self initializeChildren
]

{ #category : #initialization }
CpView >> initializeChildren [

	"Initialize any child Views"

	(self shadowRoot allDescendantsMatching: '*')
		do: [ :each | each initialize ]
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

{ #category : #transforming }
CpView >> translateToLocalPoint: screenPoint [

	"Answer the Point which represents the position of the screenPoint relative to the receiver"

	^ self parent translateToLocalPoint: screenPoint
]
