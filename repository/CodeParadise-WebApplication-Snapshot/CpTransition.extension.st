Extension { #name : 'CpTransition' }

{ #category : '*CodeParadise-WebApplication-Snapshot' }
CpTransition >> postSnapshotAtTickCount: anInteger [

	"Move the startTick relative to specified tick count, so the transition
	can continu now that the snapshot is restarted (see #preSnaspshotAt:).

	The specified tick count should be the tick count when the snapshot
	restarted and should be equal for all Transition instances."

	startTick := startTick + anInteger
]

{ #category : '*CodeParadise-WebApplication-Snapshot' }
CpTransition class >> postSnapshotOnce [

	"Reset all instances with the correct tick count.
	Restart the transition process when all instances are reset."

	| tickCount |

	tickCount := self tickCount.

	Transitions do: [ :each | each postSnapshotAtTickCount: tickCount ].

	self registerTransitionProcess
]

{ #category : '*CodeParadise-WebApplication-Snapshot' }
CpTransition >> preSnapshotAtTickCount: anInteger [

	"Move the startTick relative to specified tick count, so the transition
	can continu after the snapshot is restarted (see #postSnaspshotAt:).

	The specified tick count should be the tick count when snapshotting started
	and should be equal for all Transition instances."

	startTick := startTick ifNotNil: [ :tick | tick - anInteger ]
]

{ #category : '*CodeParadise-WebApplication-Snapshot' }
CpTransition class >> preSnapshotOnce [

	"Stop current handling of Transitions and prepare all instances to have a state which
	is relative to the current tick count (allowing restarting them once the snapshot is
	restarted)"

	| tickCount |

	tickCount := self tickCount.

	"Stop processing transitions"
	self registerTransitionProcess: nil.

	Transitions do: [ :each | each preSnapshotAtTickCount: tickCount ]
]
