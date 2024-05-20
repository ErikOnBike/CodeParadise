"
I represent the definition for a REST parameter.
Based on a REST Request and optionally the endpoint definition I can provide
the value which belongs to me.

Subclasses implement behavior specific for the following type of parameters:
CpNodeJSRestBodyParameter - parameter is the request body
CpNodeJSRestHeaderParameter - parameter is one of the header fields of the request (requires a key to refer to header)
CpNodeJSRestPathParameter - parameter is one of the segments in the URL of the request (requires a key to refer to segment)

"
Class {
	#name : #CpNodeJSRestParameter,
	#superclass : #Object,
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #'instance creation' }
CpNodeJSRestParameter class >> fromLocation: aSymbol [

	aSymbol == #body
		ifTrue: [ ^ CpNodeJSRestBodyParameter new ].

	self error: 'Unknown REST parameter location ', aSymbol
]

{ #category : #'instance creation' }
CpNodeJSRestParameter class >> fromLocation: locationSymbol at: keySymbol [

	locationSymbol == #path
		ifTrue: [ ^ CpNodeJSRestBodyParameter new ].
	locationSymbol == #header
		ifTrue: [ ^ CpNodeJSRestHeaderParameter withKey: keySymbol ].
	locationSymbol == #path
		ifTrue: [ ^ CpNodeJSRestPathParameter withKey: keySymbol ].

	self error: 'Unknown REST parameter (indexed) location ', locationSymbol
]

{ #category : #testing }
CpNodeJSRestParameter >> isPathParameter [

	^ false
]

{ #category : #enumerating }
CpNodeJSRestParameter >> resolveThenDo: aBlock [

	"Resolve the receiver's value then evaluate the specified block.

	Implementation:
	All parameters are already resolved, except for the body parameter
	(which has its own implementation for this method)."

	aBlock value
]

{ #category : #accessing }
CpNodeJSRestParameter >> valueFromRequest: aRestRequest forEndpoint: aRestEndpoint [

	self subclassResponsibility
]
