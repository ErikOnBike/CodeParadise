Class {
	#name : #CynSelectionPropertyConstraint,
	#superclass : #CynPropertyConstraint,
	#instVars : [
		'selection'
	],
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #'instance creation' }
CynSelectionPropertyConstraint class >> new [

	self errorNewReplacedBy: #selection:
]

{ #category : #accessing }
CynSelectionPropertyConstraint class >> selection: aCollection [

	"Answer a new instance of the receiver with the specified selection Collection.
	For consistency to the user, let aCollection have a fixed enumeration order.
	Do not use Set or (non-ordered) Dictionary for example."

	^ self basicNew
		initializeWithSelection: aCollection ;
		yourself
]

{ #category : #initialization }
CynSelectionPropertyConstraint >> initializeWithSelection: aCollection [

	self initialize.

	selection := aCollection
]

{ #category : #testing }
CynSelectionPropertyConstraint >> isSelection [

	^ true
]

{ #category : #accessing }
CynSelectionPropertyConstraint >> selection [

	^ selection
]

{ #category : #validating }
CynSelectionPropertyConstraint >> violationsForValue: aString in: aModel do: aBlock [

	"Validate the provided String is part of the selection"

	(aString isEmptyOrNil and: [ (selection includes: nil) not ])
		ifTrue: [ ^ aBlock value: #'constraint.required' ].

	(selection includes: aString)
		ifFalse: [ ^ aBlock value: (CynTextReference key: #'constraint.selection.unknown' with: aString) ]
]
