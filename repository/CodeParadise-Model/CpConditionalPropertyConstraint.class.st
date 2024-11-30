Class {
	#name : #CpConditionalPropertyConstraint,
	#superclass : #CpPropertyConstraint,
	#instVars : [
		'condition',
		'constraint'
	],
	#category : #'CodeParadise-Model-Property'
}

{ #category : #'instance creation' }
CpConditionalPropertyConstraint class >> condition: aBlock constraint: aPropertyConstraint [

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
CpConditionalPropertyConstraint class >> new [

	self errorNewReplacedBy: #condition:constraint:
]

{ #category : #initialization }
CpConditionalPropertyConstraint >> initializeWithCondition: aBlock constraint: aPropertyConstraint [

	self initialize.

	condition := aBlock.
	constraint := aPropertyConstraint
]

{ #category : #accessing }
CpConditionalPropertyConstraint >> violationsForProperty: aSymbol in: aModel [

	"Answer a Collection of Strings representing violations in the specified value"

	^ (condition value: aModel)
		ifTrue: [ constraint violationsForProperty: aSymbol in: aModel ]
		ifFalse: [ #() ]
]
