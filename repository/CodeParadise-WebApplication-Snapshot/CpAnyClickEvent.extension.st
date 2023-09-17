Extension { #name : #CpAnyClickEvent }

{ #category : #'*CodeParadise-WebApplication-Snapshot' }
CpAnyClickEvent class >> preSnapshotOnce [

	"Remove the class variables (will be recreated during restart)"

	ClickInstances := nil.
	ClickTargets := nil.
	SupportingEventsInstalled := false
]
