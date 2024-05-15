Extension { #name : 'Announcement' }

{ #category : '*CodeParadise-WebApplication' }
Announcement class >> addListenerTo: anElement [

	<webApplicationExtension>

	"Add a listener for the receiver to the specified DOM element.

	Implementation:
	For non-event Announcements this should be a no-op."
]

{ #category : '*CodeParadise-WebApplication' }
Announcement class >> removeListenerFrom: anElement [

	<webApplicationExtension>

	"Remove a browser event listener from the specified element.

	Implementation:
	For non-event Announcements this should be a no-op."
]
