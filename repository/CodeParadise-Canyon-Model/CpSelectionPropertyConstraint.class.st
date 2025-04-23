Class {
	#name : #CpSelectionPropertyConstraint,
	#superclass : #CpPropertyConstraint,
	#instVars : [
		'selection'
	],
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #'instance creation' }
CpSelectionPropertyConstraint class >> new [

	self errorNewReplacedBy: #selection:
]

{ #category : #accessing }
CpSelectionPropertyConstraint class >> selection: aCollection [

	"Answer a new instance of the receiver with the specified selection Collection.
	For consistency to the user, let aCollection have a fixed enumeration order.
	Do not use Set or (non-ordered) Dictionary for example."

	^ self basicNew
		initializeWithSelection: aCollection ;
		yourself
]

{ #category : #initialization }
CpSelectionPropertyConstraint >> initializeWithSelection: aCollection [

	self initialize.

	selection := aCollection
]

{ #category : #testing }
CpSelectionPropertyConstraint >> isSelection [

	^ true
]

{ #category : #accessing }
CpSelectionPropertyConstraint >> selection [

	^ selection
]

{ #category : #accessing }
CpSelectionPropertyConstraint >> violationsIn: aString do: aBlock [

	"Validate the provided String is part of the selection"

	(aString isEmptyOrNil and: [ (selection includes: nil) not ])
		ifTrue: [ ^ aBlock value: #'constraint.required' ].

	(selection includes: aString)
		ifFalse: [ ^ aBlock value: (CpParamText key: #'constraint.selection.unknown' with: aString) ]
]
