Extension { #name : 'CpPrimaryClickEvent' }

{ #category : '*CodeParadise-WebApplication-Snapshot' }
CpPrimaryClickEvent class >> preSnapshotOnce [

	"Remove the class variables (will be recreated during restart)"

	StopPropagationFrom := nil
]
