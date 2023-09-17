Extension { #name : #CpDragEvent }

{ #category : #'*CodeParadise-WebApplication-Snapshot' }
CpDragEvent class >> preSnapshotOnce [

	"Remove the class variables (will be recreated during restart)"

	DragInstances := nil.
	SupportingEventsInstalled := false
]
