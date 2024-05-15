Class {
	#name : 'CpNodeJSModule',
	#superclass : 'CpJavaScriptObject',
	#category : 'CodeParadise-NodeJS-Support-Core',
	#package : 'CodeParadise-NodeJS-Support',
	#tag : 'Core'
}

{ #category : 'instance creation' }
CpNodeJSModule class >> forName: aString [

	"Answer the Node.js module for the specified name"

	^ self global
		apply: #require withArguments: { aString } resultAs: self
]

{ #category : 'accessing' }
CpNodeJSModule class >> moduleName [

	"Answer the name of the Node.js module.

	Implementation:
	Already taking NodeJS support into account to
	prevent having to implement this on many layers."

	^ (self nameWithoutPrefix withoutPrefix: 'NodeJS') asLowercase
]

{ #category : 'class initialization' }
CpNodeJSModule class >> postSnapshotOnce [

	"After snapshot (when image is loaded from disk) perform #require again
	to load the module. When module is already loaded (after snapshot has completed,
	not when loading from disk) the additional #require does not have any effect."

	self require
]

{ #category : 'class initialization' }
CpNodeJSModule class >> registerProxyClass [

	"A module is not going to be recognizable as a Class, therefore do nothing (i.e. do not register it)"
]

{ #category : 'instance creation' }
CpNodeJSModule class >> require [

	^ self forName: self moduleName
]
