Class {
	#name : #CpNodeJSRestPathPattern,
	#superclass : #CpNodeJSRestPath,
	#instVars : [
		'paramMapping'
	],
	#category : #'CodeParadise-NodeJS-REST-Request'
}

{ #category : #testing }
CpNodeJSRestPathPattern >> hasParameterNamed: aString [

	^ paramMapping includesKey: aString
]

{ #category : #initialization }
CpNodeJSRestPathPattern >> initializeFromString: aString [

	super initializeFromString: aString.

	"Create a mapping containing parameter name and position"
	paramMapping := Dictionary new.
	pathSegments withIndexDo: [ :each :index |
		(each beginsWith: ':')
			ifTrue: [
				paramMapping
					at: each allButFirst
					ifPresent: [ self error: 'Duplicate parameter ', each allButFirst, ' in REST path pattern' ]
					ifAbsentPut: index ] ]
]

{ #category : #accessing }
CpNodeJSRestPathPattern >> parameterNamed: aString fromPath: aPath [

	"Answer the value of the named parameter from the specified path segments (or nil if not available)"

	| paramIndex |

	paramIndex := paramMapping at: aString ifAbsent: [ ^ nil ].

	^ aPath segmentAt: paramIndex
]

{ #category : #accessing }
CpNodeJSRestPathPattern >> parameterNames [

	"Answer the parameter names"

	^ paramMapping keys
]

{ #category : #printing }
CpNodeJSRestPathPattern >> printOn: aStream [

	super printOn: aStream.

	aStream
		nextPutAll: ', params: ' ;
		print: paramMapping
]

{ #category : #private }
CpNodeJSRestPathPattern >> segmentAt: anInteger matches: aString [

	| segment |
	
	segment := self segmentAt: anInteger.

	^ (segment beginsWith: ':') or: [ segment = aString ]
]
