Extension { #name : #Class }

{ #category : #'*CodeParadise-WebApplication-Snapshot' }
Class >> postSnapshot [

	"Perform any necessary initialization after receiver is (re)started in the ClientEnvironment.
	In contrast with a class side #initialize, this method should be called from subclasses
	using [[[ super postSnapshot ]]].
	In case initialization is strictly for the class itself (and should not be re-executed for
	any subclasses), use #postSnapshotOnce"

	<applicationExtension>

	(self classSide includesSelector: #postSnapshotOnce)
		ifTrue: [ self postSnapshotOnce ]
]

{ #category : #'*CodeParadise-WebApplication-Snapshot' }
Class >> postSnapshotOnce [

	"Perform any necessary initialization after receiver is (re)started in the ClientEnvironment.
	In contrast with #postSnapshot, this method should NOT chain post snapshot methods from the
	super class."

	<applicationExtension>
]

{ #category : #'*CodeParadise-WebApplication-Snapshot' }
Class >> preSnapshot [

	"Perform any necessary preparation before receiver is saved in the ClientEnvironment.
	In contrast with a class side #initialize, this method should be called from subclasses
	using [[[ super preSnapshot ]]].
	In case preparation is strictly for the class itself (and should not be re-executed for
	any subclasses), use #preSnapshotOnce"

	<applicationExtension>

	(self classSide includesSelector: #preSnapshotOnce)
		ifTrue: [ self preSnapshotOnce ]
]

{ #category : #'*CodeParadise-WebApplication-Snapshot' }
Class >> preSnapshotOnce [

	"Perform any necessary preparation before receiver is saved in the ClientEnvironment.
	In contrast with #preSnapshot, this method should NOT chain post snapshot methods from the
	super class."

	<applicationExtension>
]
