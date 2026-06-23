Class {
	#name : #CpPropertySlotDefinitions,
	#superclass : #Object,
	#instVars : [
		'definitions'
	],
	#category : #'CodeParadise-WebApplication-MVP-Slots'
}

{ #category : #accessing }
CpPropertySlotDefinitions >> at: aClass put: anObject [

	"Add the specified definition (anObject) to the receiver, categorized for the specified Class.

	Definitions should always be categorized by their Class to prevent clashing definitions.
	The definition itself can take any form or shape.

	Definitions are stored in the order they are defined (from superclass to subclasses)."

	| values |

	self assert: aClass isClass.

	"Retrieve existing values"
	values := definitions at: aClass ifAbsent: [ #() ].

	"Put back values with the new definition added"
	^ definitions at: aClass put: (values copyWith: anObject)
]

{ #category : #testing }
CpPropertySlotDefinitions >> hasDefinitionFor: aClass [

	"Answer whether the receiver has a definition for the specified category"

	^ definitions includesKey: aClass
]
