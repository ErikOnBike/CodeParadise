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
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #accessing }
CpView class >> allProxies [

	<serverEnvironment>

	"Answer a collection of ViewProxy instances which refer to the receiver"

	^ CpViewProxy allInstancesForViewClass: self
]

{ #category : #accessing }
CpView class >> allProxiesDo: aBlock [

	<serverEnvironment>

	"Perform the specified block for all ViewProxy instances which refer to the receiver"

	CpViewProxy allInstancesForViewClass: self do: aBlock
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
CpView >> performMessage: aMessage [

	"Perform the specified message on the receiver"

	aMessage sendTo: self
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
