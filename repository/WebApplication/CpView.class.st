"
I am a View in a Model-View-Presenter pattern.
I only live in a ClientEnvironnent.
"
Class {
	#name : #CpView,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'announcer',
		'keymapper'
	],
	#category : #'WebApplication-Core'
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
		keymapper addMappingFrom: key to: value ]
]

{ #category : #accessing }
CpView >> keymapper [

	^ keymapper
]

{ #category : #dependencies }
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
