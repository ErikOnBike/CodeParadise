Class {
	#name : #CpNodeJSFSWatcher,
	#superclass : #CpNodeJSEventEmitter,
	#category : #'CodeParadise-NodeJS-Support-FileSystem'
}

{ #category : #operations }
CpNodeJSFSWatcher >> close [

	"Stop watching for changes on the given <fs.FSWatcher>. Once stopped, the <fs.FSWatcher> object is no longer usable."

	self apply: #close
]

{ #category : #operations }
CpNodeJSFSWatcher >> ref [

	"When called, requests that the Node.js event loop not exit so long as the <fs.FSWatcher> is active. Calling watcher.ref() multiple times will have no effect."

	self apply: #ref
]

{ #category : #operations }
CpNodeJSFSWatcher >> unref [

	"When called, the active <fs.FSWatcher> object will not require the Node.js event loop to remain active. If there is no other activity keeping the event loop running, the process may exit before the <fs.FSWatcher> object's callback is invoked. Calling watcher.unref() multiple times will have no effect."

	self apply: #unref
]
