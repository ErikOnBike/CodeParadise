Extension { #name : #Announcement }

{ #category : #'*CodeParadise-WebApplication' }
Announcement class >> addListenerTo: anElement [

	<webApplicationExtension>

	"Add a listener for the receiver to the specified DOM element.

	Implementation:
	For non-event Announcements this should be a no-op."
]

{ #category : #'*CodeParadise-WebApplication' }
Announcement class >> asEventClass [

	"Answer the event class (for use in adding the receiver to a DOM element).
	By default the receiver is the event class."

	^ self
]
