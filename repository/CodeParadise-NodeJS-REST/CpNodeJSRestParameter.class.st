Class {
	#name : #CpNodeJSRestParameter,
	#superclass : #Object,
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #'instance creation' }
CpNodeJSRestParameter class >> fromLocation: aSymbol [

	aSymbol == #body
		ifTrue: [ ^ CpNodeJSRestParameterBody new ].

	self error: 'Unknown REST parameter location ', aSymbol
]

{ #category : #'instance creation' }
CpNodeJSRestParameter class >> fromLocation: locationSymbol at: keySymbol [

	locationSymbol == #path
		ifTrue: [ ^ CpNodeJSRestParameterBody new ].
	locationSymbol == #header
		ifTrue: [ ^ CpNodeJSRestParameterHeader withKey: keySymbol ].
	locationSymbol == #path
		ifTrue: [ ^ CpNodeJSRestParameterPath withKey: keySymbol ].

	self error: 'Unknown REST parameter (indexed) location ', locationSymbol
]

{ #category : #testing }
CpNodeJSRestParameter >> isPathParameter [

	^ false
]

{ #category : #accessing }
CpNodeJSRestParameter >> valueFromRequest: aRestRequest forEndpoint: aRestEndpoint [

	self subclassResponsibility
]
