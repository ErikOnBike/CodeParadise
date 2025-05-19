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

{ #category : #'class initialization' }
CpBrowserSnapshot class >> beLoaded [

	"The downloader is used to download the snapshot image (see #downloadImageScript)"

	CpDownloader beLoaded
]

{ #category : #accessing }
CpBrowserSnapshot class >> collectWebComponentsFrom: anElement into: aDictionary [

	"Collect the receiver and all children which are WebComponents into the specified Dictionary.
	Use the component's ID as key and the component itself as value."

	anElement isWebComponent
		ifTrue: [
			anElement id
				ifNotNil: [ :id | aDictionary at: id put: anElement ] ].

	anElement children do: [ :each | self collectWebComponentsFrom: each into: aDictionary ]
]

{ #category : #'web resources' }
CpBrowserSnapshot class >> downloadImageScript [

	"Answer a JavaScript download image script.
	Assume the snapshot primitive is called just before executing this script.

	Implementation:
	Use the Squeak JS VM's file storage implementation to retrieve the image content."

	^ '// Add empty function to mimic presence of FilePlugin
Squeak.flushAllFiles = function() {};

// Add default download operation to the filePut method
Squeak.filePut = function(name, buffer) {
	console.log("Saving image");
	globalThis.cpDownload(buffer, "application/octet-stream", name.endsWith(".image") ? name : name + ".image");
};'
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

	"Add script to download the snapshot"
	CpHtmlElement documentAddScript: self downloadImageScript.

	"Install the keyboard handler to perform the snapshot operation"
	CpBrowserWindow current
		when: (CpKeyDownEvent fromString: 'X-S-s') send: #saveSnapshot: to: self
]

{ #category : #'class initialization' }
CpBrowserSnapshot class >> postSnapshotOnce [

	"Add script to allow reattaching Smalltalk CpDomElements to browser DOM elements"

	CpHtmlElement documentAddScript: self privateAttachToIdScript
]

{ #category : #'web resources' }
CpBrowserSnapshot class >> privateAttachToIdScript [

	"Answer a JavaScript primitive for attaching a Smalltalk CpDomElement to a browser DOM element.

	Add this primitive to the DOMPlugin."

	^ '// Add extra primitive to the DOM plugin
Squeak.externalModules.CpDOMPlugin["primitiveDomElementPrivateAttachToId:"] = function(argCount) {
	if(argCount !== 1) return false;
	var id = this.interpreterProxy.stackValue(0).asString();
	if(!id) return false;
	var receiver = this.interpreterProxy.stackValue(argCount);
	var domElement = document.getElementById(id);
	if(!domElement) return false;
	receiver.domElement = domElement;
	this.domElementMap.set(domElement, receiver);
	return this.answerSelf(argCount); 
};'
]

{ #category : #private }
CpBrowserSnapshot class >> saveSnapshot [

	"Save a snapshot of the image"

	"Start snapshot in separate process which terminates itself"
	[ self snapshotImage ] forkAt: 2 named: 'Snapshot'
]

{ #category : #private }
CpBrowserSnapshot class >> saveSnapshot: aKeyEvent [

	"Save a snapshot of the image"

	"Prevent default behavior for the key being pressed"
	aKeyEvent preventDefault.

	self saveSnapshot
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

	| content components |

	"Prepare image for snapshot"
	(Smalltalk classNamed: #CpTransition)
		ifNotNil: [ :cls | cls preSnapshot ].
	CpEvent preSnapshot.
	CpEvent allSubclassesDo: [ :each | each preSnapshot ].
	CpJavaScriptObject withAllSubclassesDo: [ :each |
		each preSnapshot ].
	CpGlobalThis preSnapshotOnce.

	"Save application content"
	content := CpHtmlElement documentBody markupContent.

	"Save components"
	components := Dictionary new.
	self collectWebComponentsFrom: CpHtmlElement documentBody into: components.

	"Snapshot image"	
	self traceCr: 'About to save image'.
	Smalltalk snapshotPrimitive
		ifFalse: [
			self traceCr: 'Saved image'.

			"Prepare image for restart"
			CpJavaScriptObject withAllSubclassesDo: [ :each |
				each postSnapshot ].
			CpEvent allSubclassesDo: [ :each | each postSnapshot ].
			CpEvent postSnapshot.
			(Smalltalk classNamed: #CpTransition)
				ifNotNil: [ :cls | cls postSnapshot ].

			^ self ].
	self traceCr: 'Restoring saved image'.

	"Recreate Symbol table"
	Symbol perform: #initSymbolTable.

	"Load necessary DOM plugin"
	self loadDOMPlugin.

	"Restore browser support"
	CpJavaScriptObject withAllSubclassesDo: [ :each |
		each postSnapshot ].

	"Restore the application content"
	CpHtmlElement documentBody markupContent: content.

	"Prepare image for restart"
	CpEvent allSubclassesDo: [ :each | each postSnapshot ].
	CpEvent postSnapshot.

	"Restore components"
	self postSnapshot.
	CpWebComponent allSubclassesDo: [ :each | each postInstall ].
	components keysAndValuesDo: [ :id :element |
		element
			privateAttachToId: id ;
			initialize ].

	"Restart transition process as last step in restart"
	(Smalltalk classNamed: #CpTransition)
		ifNotNil: [ :cls | cls postSnapshot ].

	self traceCr: 'Image restored, continuing execution'
]
