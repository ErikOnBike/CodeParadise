Class {
	#name : #CpKeyEventCondition,
	#superclass : #CpEventCondition,
	#instVars : [
		'key'
	],
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #'instance creation' }
CpKeyEventCondition class >> key: aString [

	"Answer an instance of the receiver with the specified key (a String).
	The key should have a describing String for control keys like:
		Space
		Tab
		Enter
		ArrowLeft"

	^ self basicNew
		initializeWithKey: aString ;
		yourself
]

{ #category : #'instance creation' }
CpKeyEventCondition class >> new [

	self error: 'Instances of this class should not be created using #new. Use ', #key:
]

{ #category : #initialization }
CpKeyEventCondition >> initializeWithKey: aString [

	"Initialize using the specified key value"

	self initialize.

	key := aString
]

{ #category : #accessing }
CpKeyEventCondition >> key [

	^ key
]

{ #category : #testing }
CpKeyEventCondition >> matches: anEvent [

	"Answer whether the receiver matches the specified event.
	The key should be identical for a match."

	^ self key = anEvent key
]
