Class {
	#name : #CpNodeJSSnapshot,
	#superclass : #Object,
	#classVars : [
		'SnapshotClasses'
	],
	#category : #'CodeParadise-NodeJS-Support-Snapshot'
}

{ #category : #private }
CpNodeJSSnapshot class >> loadSystemPlugin [

	"Load the System plugin by executing a trivial primitive from the plugin"

	<primitive: 'primitiveEnvironmentVariableNames' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #accessing }
CpNodeJSSnapshot class >> registerSnapshotClass: aClass [

	(SnapshotClasses ifNil: [ SnapshotClasses := Set new ])
		add: aClass
]

{ #category : #actions }
CpNodeJSSnapshot class >> saveSnapshot [

	"Start snapshot in separate process which terminates itself"
	[ self snapshotImage ] forkAt: 2 named: 'Snapshot'
]

{ #category : #actions }
CpNodeJSSnapshot class >> snapshotImage [

	"Snapshot the image for later restarting it with the current content.

	Implementation:
	Currently it is assumed the receiver is running inside a Node.js
	environment (support for other environments can be found in separate
	classes).

	Currently the image is 'sealed' meaning it does not try to reconnect
	to a server environment. Such a feature might be added in the future
	as well, although the TinyBootstrap process can already create images
	with additional classes installed.
	Currently no effort is done to minimize the image. Since the image
	is sealed, some communication classes like CpClientCommunicator and
	CpJavaScriptWebSocketChannel could be removed from the image. Even
	the receiver (except for the 'restart' behavior) could be removed.

	See also https://github.com/ErikOnBike/TinyBootstrap for an
	alternative to create custom images."

	"Prepare image for snapshot"
	SnapshotClasses ifNotNil: [
		SnapshotClasses do: [ :each | each preSnapshot ] ].
	CpNodeJSModule allSubclassesDo: [ :each |
		each preSnapshot ].
	CpJavaScriptObject withAllSubclassesDo: [ :each |
		each preSnapshot ].
	CpGlobalThis preSnapshotOnce.

	"Snapshot image"	
	self traceCr: 'About to save image'.
	Smalltalk snapshotPrimitive
		ifFalse: [
			self traceCr: 'Saved image'.

			"Prepare image for restart"
			CpJavaScriptObject withAllSubclassesDo: [ :each |
				each postSnapshot ].
			CpNodeJSModule allSubclassesDo: [ :each | each postSnapshot ].
			SnapshotClasses ifNotNil: [
				SnapshotClasses do: [ :each | each postSnapshot ] ].

			^ self ].
	self traceCr: 'Restoring saved image'.

	"Recreate Symbol table"
	Symbol perform: #initSymbolTable.

	"Load necessary System plugin"
	self loadSystemPlugin.

	"Prepare image for restart"
	CpJavaScriptObject withAllSubclassesDo: [ :each |
		each postSnapshot ].
	CpNodeJSModule allSubclassesDo: [ :each | each postSnapshot ].
	SnapshotClasses ifNotNil: [
		SnapshotClasses do: [ :each | self traceCr: 'post ', each printString. each postSnapshot ] ].

	self traceCr: 'Image restored, continuing execution'
]
