Class {
	#name : #CynOptionalPropertyConstraint,
	#superclass : #CynPropertyConstraint,
	#instVars : [
		'constraint'
	],
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #'instance creation' }
CynOptionalPropertyConstraint class >> constraint: aPropertyConstraint [

	"Answer a new instance of the receiver for the specified PropertyConstraint"

	^ self basicNew
		initializeWithConstraint: aPropertyConstraint ;
		yourself
]

{ #category : #'instance creation' }
CynOptionalPropertyConstraint class >> new [

	self errorNewReplacedBy: #constraint:
]

{ #category : #initialization }
CynOptionalPropertyConstraint >> initializeWithConstraint: aPropertyConstraint [

	self initialize.

	constraint := aPropertyConstraint
]

{ #category : #accessing }
CynOptionalPropertyConstraint >> normalizeProperty: aSymbol in: aModel [

	"Store a normalized value for the specified value in the specified Object.

	Implementation:
	The PropertyModel will do nothing if the same value is stored 'over' the
	old value (therefore no checks here if old and new value are equal)."

	constraint normalizeProperty: aSymbol in: aModel
]

{ #category : #accessing }
CynOptionalPropertyConstraint >> possibleValues [

	^ constraint possibleValues
]

{ #category : #validating }
CynOptionalPropertyConstraint >> violationsForValue: anObject in: aModel do: aBlock [

	anObject ifNil: [ ^ self ].

	constraint violationsForValue: anObject in: aModel do: aBlock
]
