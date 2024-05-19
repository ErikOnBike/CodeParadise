Extension { #name : #AnnouncementSet }

{ #category : #'*CodeParadise-WebApplication' }
AnnouncementSet >> addListenerTo: anElement [

	"Add an event listener to the specified element.

	Implementation:
	Add the event listener to all elements in the set."

	<webApplicationExtension>

	self do: [ :each | each addListenerTo: anElement ]
]

{ #category : #'*CodeParadise-WebApplication' }
AnnouncementSet >> removeListenerFrom: anElement [

	"Remove an event listener from the specified element.

	Implementation: see #addListenerTo:"

	<webApplicationExtension>

	self do: [ :each | each removeListenerFrom: anElement ]
]
