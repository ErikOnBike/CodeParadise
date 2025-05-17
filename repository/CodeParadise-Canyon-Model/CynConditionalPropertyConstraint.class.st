"
I am a conditional PropertyConstraint.
My rules only apply if a specified condition is met.
The condition is a Block which accepts the PropertyModel as input/argument.
If the condition Block evaluates to true, my (conditional) rules apply.
Otherwise my (conditional) rules are ignored.
"
Class {
	#name : #CynConditionalPropertyConstraint,
	#superclass : #CynPropertyConstraint,
	#instVars : [
		'condition',
		'constraint'
	],
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #'instance creation' }
CynConditionalPropertyConstraint class >> condition: aBlock constraint: aPropertyConstraint [

	"Answer a new instance of the receiver with the specified condition
	for the specified PropertyConstraint.

	The condition should be an one argument Block which is evaluated with
	the PropertyModel and should answers a Boolean indicating whether the
	condition is true or not."

	^ self basicNew
		initializeWithCondition: aBlock constraint: aPropertyConstraint ;
		yourself
]

{ #category : #'instance creation' }
CynConditionalPropertyConstraint class >> new [

	self errorNewReplacedBy: #condition:constraint:
]

{ #category : #initialization }
CynConditionalPropertyConstraint >> initializeWithCondition: aBlock constraint: aPropertyConstraint [

	self initialize.

	condition := aBlock.
	constraint := aPropertyConstraint
]

{ #category : #testing }
CynConditionalPropertyConstraint >> isConditional [

	^ true
]

{ #category : #validating }
CynConditionalPropertyConstraint >> isValidValue: anObject [

	self error: 'Do not use #isValidValue: on a conditional constraint, please use #isValidValue:in:'
]

{ #category : #accessing }
CynConditionalPropertyConstraint >> normalizeProperty: aSymbol in: aModel [

	"Store a normalized value for the specified value in the specified Object.

	Implementation:
	The PropertyModel will do nothing if the same value is stored 'over' the
	old value (therefore no checks here if old and new value are equal)."

	(condition value: aModel)
		ifTrue: [ constraint normalizeProperty: aSymbol in: aModel ]
]

{ #category : #validating }
CynConditionalPropertyConstraint >> violationsForValue: anObject in: aModel do: aBlock [

	(condition value: aModel)
		ifTrue: [ constraint violationsForValue: anObject in: aModel do: aBlock ]
]
