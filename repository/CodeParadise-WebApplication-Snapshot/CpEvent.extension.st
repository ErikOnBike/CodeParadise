Extension { #name : #CpEvent }

{ #category : #'*CodeParadise-WebApplication-Snapshot' }
CpEvent class >> postSnapshot [

	super postSnapshot.

	self registerEventClass: self forType: self type
]

{ #category : #'*CodeParadise-WebApplication-Snapshot' }
CpEvent class >> postSnapshotOnce [

	"Restart the event process"

	self registerEventProcess
]

{ #category : #'*CodeParadise-WebApplication-Snapshot' }
CpEvent class >> preSnapshotOnce [

	"Stop current handling of Events"

	"Stop processing events"
	self registerEventProcess: nil
]
