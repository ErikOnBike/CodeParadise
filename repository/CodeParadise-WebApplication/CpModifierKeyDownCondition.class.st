Class {
	#name : #CpModifierKeyDownCondition,
	#superclass : #CpEventCondition,
	#instVars : [
		'modifiers'
	],
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #'logical operations' }
CpModifierKeyDownCondition class >> + aModifierKeyCondition [

	"Answer an instance of the receiver specifying an additional modifier to be combined with the receiver"

	^ CpModifierKeyDownCondition modifiers: (self modifiers bitOr: aModifierKeyCondition modifiers)
]

{ #category : #testing }
CpModifierKeyDownCondition class >> matches: anEvent [

	"Answer whether the receiver matches the specified event.
	The modifers should be identical for a match."

	^ self modifiers = anEvent modifiers
]

{ #category : #accessing }
CpModifierKeyDownCondition class >> modifiers [

	"Answer the modifiers (an Integer, see CpEvent >> #modifiers) the receiver represents.
	The answer should specify which modifiers should be present (allowing more modifiers
	to be present). To check for an exact match, create an instance of the receiver."

	^ 0
]

{ #category : #'instance creation' }
CpModifierKeyDownCondition class >> modifiers: anInteger [

	"Create an instance of the receiver with the specified modifiers value.
	See class comment for possible values and usage."

	^ self basicNew
		initializeWithModifiers: anInteger ;
		yourself
]

{ #category : #'instance creation' }
CpModifierKeyDownCondition class >> new [

	self error: 'Instances of this class should not be created using #new. Use ', #modifiers:
]

{ #category : #accessing }
CpModifierKeyDownCondition >> + aModifierKeyCondition [

	"Update the receiver specifying an additional modifier to be combined with the receiver"

	^ self class modifiers: (modifiers bitOr: aModifierKeyCondition modifiers)
]

{ #category : #initialization }
CpModifierKeyDownCondition >> initialize [

	"By default initialize with the class' modifiers value"

	super initialize.

	modifiers := self class modifiers
]

{ #category : #initialization }
CpModifierKeyDownCondition >> initializeWithModifiers: anInteger [

	"Initialize using the specified modifiers value"

	super initialize.

	modifiers := anInteger
]

{ #category : #testing }
CpModifierKeyDownCondition >> matches: anEvent [

	"Answer whether the receiver matches the specified event.
	The modifers should be identical for a match."

	^ self modifiers = anEvent modifiers
]

{ #category : #accessing }
CpModifierKeyDownCondition >> modifiers [

	^ modifiers
]
