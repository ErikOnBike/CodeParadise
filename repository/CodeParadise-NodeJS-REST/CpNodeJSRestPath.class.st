Class {
	#name : #CpNodeJSRestPath,
	#superclass : #Object,
	#instVars : [
		'pathSegments'
	],
	#category : #'CodeParadise-NodeJS-REST-Core'
}

{ #category : #'instance creation' }
CpNodeJSRestPath class >> fromString: aString [

	"Answer an instance of the receiver based on the specified path pattern string"

	^ self basicNew
		initializeFromString: aString ;
		yourself
]

{ #category : #initialization }
CpNodeJSRestPath >> initializeFromString: aString [

	self initialize.

	pathSegments := aString findTokens: $/
]

{ #category : #testing }
CpNodeJSRestPath >> isEmpty [

	^ pathSegments isEmpty
]

{ #category : #testing }
CpNodeJSRestPath >> matchesPath: aPath [

	"Answer whether the receiver matches the specified path segments"

	pathSegments size = aPath size
		ifFalse: [ ^ false ].

	1 to: pathSegments size do: [ :index |
		(self segmentAt: index matches: (aPath segmentAt: index))
			ifFalse: [ ^ false ] ].

	^ true
]

{ #category : #printing }
CpNodeJSRestPath >> printOn: aStream [

	aStream
		nextPutAll: self class name ;
		nextPutAll: ', segments: ' ;
		print: pathSegments
]

{ #category : #accessing }
CpNodeJSRestPath >> segmentAt: anInteger [

	"Answer the value of the specified segment or nil if segment does not exist"

	^ pathSegments at: anInteger ifAbsent: [ nil ]
]

{ #category : #private }
CpNodeJSRestPath >> segmentAt: anInteger matches: aString [

	^ (self segmentAt: anInteger) = aString
]

{ #category : #accessing }
CpNodeJSRestPath >> size [

	^ pathSegments size
]
