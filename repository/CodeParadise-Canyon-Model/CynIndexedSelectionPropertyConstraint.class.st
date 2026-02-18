Class {
	#name : #CynIndexedSelectionPropertyConstraint,
	#superclass : #CynPropertyConstraint,
	#instVars : [
		'indices'
	],
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #'instance creation' }
CynIndexedSelectionPropertyConstraint class >> indices: aCollection [

	"Answer a new instance of the receiver with the specified indices Collection.
	For consistency to the user, let aCollection have a fixed enumeration order.
	Do not use Set or (non-ordered) Dictionary for example."

	^ self basicNew
		initializeWithIndices: aCollection ;
		yourself
]

{ #category : #'instance creation' }
CynIndexedSelectionPropertyConstraint class >> new [

	self errorNewReplacedBy: #indices:
]

{ #category : #accessing }
CynIndexedSelectionPropertyConstraint >> indices [

	^ indices
]

{ #category : #initialization }
CynIndexedSelectionPropertyConstraint >> initializeWithIndices: aCollection [

	self initialize.

	indices := aCollection
]

{ #category : #accessing }
CynIndexedSelectionPropertyConstraint >> possibleValues [

	^ indices
]

{ #category : #validating }
CynIndexedSelectionPropertyConstraint >> violationsForValue: anInteger in: aModel do: aBlock [

	"Validate the provided String is part of the selection"

	anInteger isNil
		ifTrue: [ ^ aBlock value: #'constraint.required' ].

	(indices includes: anInteger)
		ifFalse: [ ^ aBlock value: (CynTextReference key: #'constraint.selection.unknown' with: anInteger asString) ]
]
