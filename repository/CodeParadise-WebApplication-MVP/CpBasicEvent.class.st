"
I am the base class for a number of supporting events.
I have an id to allow myself to be identified.
I am implemented as an Announcement. In contrast with regular Announcements,
my instances can also be used to specify a specific Announcement to
subscribe/listen to. The instance forms a parameterized Announcement instead
of the actual Announcement being announced. This parameterized Announcement is
matched against any received Announcements. If a match is found, the proper
handler is evaluated.

A number of examples (of subscriptions inside a Presenter to listen to announcements
from the View). The examples are based on some of my concrete subclasses.

	""Handle announcement of any field and any value (the method should distinguish between fields)""
	self view when: CpFieldChanged send: #titleChanged: to: self.

	""Handle announcement of specific field (any value will be accepted, even nil)""
	self view when: (CpFieldChanged id: #title) send: #titleChanged: to: self.

	""Handle announcement of specific field with specific value (only value 'exit' is matched)""
	self view when: (CpFieldChanged id: #commandLine value: 'exit') send: #exit to: self.

	""Handle announcement of any action (the method should distinguish between actions)""
	self view when: CpActionRequested send: #navigate: to: self.

	""Handle announcement of specific action (any parameter will be accepted, even none)""
	self view when: (CpActionRequested id: #navigateHome) send: #navigateHome to: self.

	""Handle announcement of specific action and specific parameter (which should have some value specified,
	all other parameters are ignored for matching)""
	self view when: (CpActionRequested id: #navigate parameterKeys: #(#to)) send: #navigateTo: to: self.

	""The following Announcement from the View would DOES match the above subscription in the Presenter""
	self serverAnnounce: (CpActionRequested id: #navigate parameters: { #to -> 'home' } asDictionary).

	""The following Announcement from the View would NOT match the above subscription in the Presenter,
	because the #to parameter is not defined.""
	self serverAnnounce: (CpActionRequested id: #navigate parameters: { #from -> 'location' } asDictionary).

	""Handle announcement of specific action and specific parameter (which should have value 'home', all other parameters are accepted)""
	self view when: (CpActionRequested id: #navigate parameters: { #to -> 'home' } asDictionary) send: #navigateHome to: self.

"
Class {
	#name : #CpBasicEvent,
	#superclass : #Announcement,
	#instVars : [
		'id'
	],
	#category : #'CodeParadise-WebApplication-MVP-Support'
}

{ #category : #'instance creation' }
CpBasicEvent class >> id: aSymbol [

	^ self basicNew
		initializeWithId: aSymbol ;
		yourself
]

{ #category : #'instance creation' }
CpBasicEvent class >> new [

	"Do not instantiate events directly"

	self error: 'Please create new instances for ', self name, ' using method ', #id:
]

{ #category : #testing }
CpBasicEvent >> handlesAnnouncement: anAnnouncement [

	"Answer whether the receiver handles the specified announcement.
	This is normally a class side method, but it is used as an instance
	variant to allow a field name to be specified. This makes it possible
	to define a 'parameterized' announcement.

	Usage example:
		self view when: (CpFieldChanged id: #title) send: #titleChanged: to: self.
	"

	^ (self class handlesAnnouncement: anAnnouncement)
		and: [ self id = anAnnouncement id ]
]

{ #category : #accessing }
CpBasicEvent >> id [

	^ id
]

{ #category : #initialization }
CpBasicEvent >> initializeWithId: aSymbol [

	self initialize.

	id := aSymbol
]
