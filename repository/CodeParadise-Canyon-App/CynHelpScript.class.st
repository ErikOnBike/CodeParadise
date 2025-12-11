Class {
	#name : #CynHelpScript,
	#superclass : #Object,
	#instVars : [
		'steps',
		'currentStepIndex'
	],
	#category : #'CodeParadise-Canyon-App-Help'
}

{ #category : #accessing }
CynHelpScript >> addStep: aStep [

	steps add: aStep.
	aStep script: self.

	"Assume the first step is always a showable step (for now)"
	currentStepIndex = 0
		ifTrue: [ currentStepIndex := 1 ].

	^ aStep
]

{ #category : #accessing }
CynHelpScript >> currentStep [

	^ steps at: currentStepIndex ifAbsent: [ nil ]
]

{ #category : #testing }
CynHelpScript >> hasAllShowableStepsWithNameIn: aCollection [

	^ aCollection allSatisfy: [ :each | self hasShowableStepWithName: each ]
]

{ #category : #testing }
CynHelpScript >> hasAnyShowableStepWithNameIn: aCollection [

	^ aCollection anySatisfy: [ :each | self hasShowableStepWithName: each ]
]

{ #category : #testing }
CynHelpScript >> hasNextStep [

	currentStepIndex + 1 to: steps size do: [ :index |
		(steps at: index) isShowable
			ifTrue: [ ^ true ] ].

	^ false
]

{ #category : #testing }
CynHelpScript >> hasPreviousStep [

	currentStepIndex - 1 to: 1 by: -1 do: [ :index |
		(steps at: index) isShowable
			ifTrue: [ ^ true ] ].

	^ false
]

{ #category : #testing }
CynHelpScript >> hasShowableStepWithName: aString [

	^ (self stepNamed: aString)
		ifNotNil: [ :step | step isShowable ]
		ifNil: [ false ]
]

{ #category : #initialization }
CynHelpScript >> initialize [

	super initialize.

	steps := OrderedCollection new.
	currentStepIndex := 0
]

{ #category : #testing }
CynHelpScript >> isNotEmpty [

	"Answer whether the receiver has steps (assume the first step is always showable)"

	^ steps isNotEmpty
]

{ #category : #accessing }
CynHelpScript >> nextStep [

	| nextIndex |

	steps ifEmpty: [ ^ nil ].

	nextIndex := currentStepIndex + 1.
	[ nextIndex <= steps size and: [ (steps at: nextIndex) isShowable not ] ] whileTrue: [
		nextIndex := nextIndex + 1 ].

	"Update the current step index"
	nextIndex <= steps size
		ifTrue: [ currentStepIndex := nextIndex ]
		ifFalse: [ ^ nil ].

	^ steps at: currentStepIndex
]

{ #category : #accessing }
CynHelpScript >> previousStep [

	| previousIndex |

	steps ifEmpty: [ ^ nil ].

	previousIndex := currentStepIndex - 1.
	[ previousIndex >= 1 and: [ (steps at: previousIndex) isShowable not ] ] whileTrue: [
		previousIndex := previousIndex - 1 ].

	"Update the current step index"
	previousIndex >= 1
		ifTrue: [ currentStepIndex := previousIndex ]
		ifFalse: [ ^ nil ].

	^ steps at: currentStepIndex
]

{ #category : #initialization }
CynHelpScript >> release [

	steps ifNotNil: [
		steps do: [ :each | each release ].
		steps := nil ].

	super release
]

{ #category : #accessing }
CynHelpScript >> reset [

	steps ifEmpty: [ ^ self ].

	"Assume the first step is always showable (for now)"
	currentStepIndex := 1
]

{ #category : #accessing }
CynHelpScript >> stepNamed: aString [

	"Answer the (first) step with the specified name or nil if none is present"

	^ steps detect: [ :each | each name = aString ] ifNone: [ nil ]
]
