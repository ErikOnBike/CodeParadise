"
I am the snapshot feature for CodeParadise webapplications.
Currently I only support MVP-based webapplications.
When installed, the Ctrl-Shift-s or Cmd-Shift-s (Linux/Windows vs macOS) key combination
performs a snapshot. The snapshot will be downloaded by your browser (using the name 'snapshot.image').
You can later start this image again.
The image will be 'sealed' during the snapshot process. Meaning it will not interact with the
server environment anymore. It is possible however to add communication components to have an
interactive webapplication.

"
Class {
	#name : #CpBrowserSnapshot,
	#superclass : #Object,
	#category : #'CodeParadise-WebApplication-Snapshot-Core'
}

{ #category : #snapshot }
CpBrowserSnapshot class >> customPostSnapshotWith: anObject [

	"Perform any custom pre snapshot behavior using the data from #customPreSnapshot"
]

{ #category : #snapshot }
CpBrowserSnapshot class >> customPreSnapshot [

	"Perform any custom pre snapshot behavior and answer an Objec to be used during post snapshot"

	^ nil
]

{ #category : #private }
CpBrowserSnapshot class >> loadDOMPlugin [

	"Load the DOM plugin by executing a trivial primitive from the plugin"

	<primitive: 'primitiveDomElementDocument' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #'class initialization' }
CpBrowserSnapshot class >> postInstall [

	super postInstall.

	"Invoke snapshot directly"
	self saveSnapshot
]

{ #category : #private }
CpBrowserSnapshot class >> saveSnapshot [

	"Save a snapshot of the image"

	"Start snapshot in separate process which terminates itself"
	[ self snapshotImage ] forkAt: 2 named: 'Snapshot'
]

{ #category : #actions }
CpBrowserSnapshot class >> snapshotImage [

	"Snapshot the image for later restarting it with the current content.

	Implementation:
	Currently it is assumed the receiver is running inside an MVP-based
	webapplication and no 'manual' DOM manipulation has been performed.
	In the future support might be added for other environments as well
	(like Node.js based environments or WebWorker threads which don't have
	access to the DOM). Also non MVP webapplications might be supported.

	Currently the image is 'sealed' meaning it does not try to reconnect
	to a server environment. Such a feature might be added in the future
	as well, although the TinyBootstrap process can already create images
	with additional classes installed.
	Currently no effort is done to minimize the image. Since the image
	is sealed, some communication classes like CpClientCommunicator and
	CpJavaScriptWebSocketChannel could be removed from the image. Even
	the receiver (except for the 'restart' behavior) could be removed.

	Only the HTML body is preserved during the snapshot process. The
	head content is assumed to be created by the different classes and/or
	components and will be recreated during the restart.
	Since WebComponents do not know their content nor where they are
	placed inside the DOM, a dictionary is kept with their id, so they
	can be restored in the proper location.

	See also https://github.com/ErikOnBike/TinyBootstrap for an
	alternative to create custom images."

	| data |

	"Prepare image for snapshot"
	(Smalltalk classNamed: #CpTransition)
		ifNotNil: [ :cls | cls preSnapshot ].
	CpEvent preSnapshot.
	CpEvent allSubclassesDo: [ :each | each preSnapshot ].
	CpJavaScriptObject withAllSubclassesDo: [ :each |
		each preSnapshot ].
	CpGlobalThis preSnapshotOnce.

	"Prepare marked classes"
	Smalltalk globals at: #CpSnapshotClasses ifPresent: [ :classes |
		classes do: [ :each | each preSnapshot ] ].

	"Perform custom snapshotting"
	data := self customPreSnapshot.

	"Snapshot image (using tiny image specific methods #snapshotPrimitive and #quit)"
	self traceCr: 'About to save image'.
	Smalltalk snapshotPrimitive
		ifFalse: [
			self traceCr: 'Saved image'.

			^ Smalltalk quit ].
	self traceCr: 'Restoring saved image'.

	"Recreate Symbol table"
	Symbol perform: #initSymbolTable.

	"Load necessary DOM plugin"
	self loadDOMPlugin.

	"Restore browser support"
	CpJavaScriptObject withAllSubclassesDo: [ :each |
		each postSnapshot ].

	"Prepare image for restart"
	CpEvent allSubclassesDo: [ :each | each postSnapshot ].
	CpEvent postSnapshot.

	"Restore components"
	self postSnapshot.
	CpDomElement allSubclassesDo: [ :each | each postInstall ].

	"Perform custom post snapshotting"
	self customPostSnapshotWith: data.

	"Prepare marked classes"
	Smalltalk globals at: #CpSnapshotClasses ifPresent: [ :classes |
		classes do: [ :each | each postSnapshot ] ].

	"Restart transition process as last step in restart (since DOM should be fully restored)"
	(Smalltalk classNamed: #CpTransition)
		ifNotNil: [ :cls | cls postSnapshot ].

	self traceCr: 'Image restored, continuing execution'
]
