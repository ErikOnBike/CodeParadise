Class {
	#name : #CpKeyRangeEventCondition,
	#superclass : #CpEventCondition,
	#instVars : [
		'lowerBoundKey',
		'upperBoundKey'
	],
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #'instance creation' }
CpKeyRangeEventCondition class >> fromKey: lowerBoundKeyString to: upperBoundKeyString [

	"Answer an instance of the receiver with the specified range.
	The range consists of a lower and upper (inclusive) bound, meaning
	it will allow selecting ranges like '0' to '9' (inclusive) and
	'a' to 'f' (inclusive) but beware of using 'Escape' or 'ArrowDown'
	because these don't really define a logical range (although you can
	use 'ArrowA' to 'ArrowZ' or 'ArrowDown' to 'ArrowUp' to select all
	arrow keys."

	^ self basicNew
		initializeWithLowerBoundKey: lowerBoundKeyString upperBoundKey: upperBoundKeyString ;
		yourself
]

{ #category : #initialization }
CpKeyRangeEventCondition >> initializeWithLowerBoundKey: lowerBoundKeyString upperBoundKey: upperBoundKeyString [

	self initialize.

	lowerBoundKey := lowerBoundKeyString.
	upperBoundKey := upperBoundKeyString
]

{ #category : #accessing }
CpKeyRangeEventCondition >> lowerBoundKey [

	^ lowerBoundKey
]

{ #category : #testing }
CpKeyRangeEventCondition >> matches: anEvent [

	"Answer whether the receiver matches the specified event.
	The key should be identical for a match."

	^ self lowerBoundKey <= anEvent key
		and: [ self upperBoundKey >= anEvent key ]
]

{ #category : #accessing }
CpKeyRangeEventCondition >> upperBoundKey [

	^ upperBoundKey
]
