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

	currentStepIndex = 0
		ifTrue: [ currentStepIndex := 1 ].

	^ aStep
]

{ #category : #accessing }
CynHelpScript >> currentStep [

	^ steps at: currentStepIndex ifAbsent: [ nil ]
]

{ #category : #accessing }
CynHelpScript >> firstStep [

	steps ifEmpty: [ ^ nil ].

	"Update the current step index"
	currentStepIndex := 1.

	^ steps at: currentStepIndex
]

{ #category : #testing }
CynHelpScript >> hasNextStep [

	^ currentStepIndex < steps size
]

{ #category : #testing }
CynHelpScript >> hasPreviousStep [

	^ currentStepIndex > 1
]

{ #category : #initialization }
CynHelpScript >> initialize [

	super initialize.

	steps := OrderedCollection new.
	currentStepIndex := 0
]

{ #category : #testing }
CynHelpScript >> isAtFirstStep [

	^ currentStepIndex = 1
]

{ #category : #testing }
CynHelpScript >> isAtLastStep [

	^ currentStepIndex = steps size
]

{ #category : #testing }
CynHelpScript >> isEmpty [

	^ steps isEmpty
]

{ #category : #testing }
CynHelpScript >> isNotEmpty [

	^ steps isNotEmpty
]

{ #category : #accessing }
CynHelpScript >> lastStep [

	steps ifEmpty: [ ^ nil ].

	"Update the current step index"
	currentStepIndex := steps size.

	^ steps at: currentStepIndex
]

{ #category : #accessing }
CynHelpScript >> nextStep [

	steps ifEmpty: [ ^ nil ].

	"Update the current step index"
	currentStepIndex < steps size
		ifTrue: [ currentStepIndex := currentStepIndex + 1 ]
		ifFalse: [ ^ nil ].

	^ steps at: currentStepIndex
]

{ #category : #accessing }
CynHelpScript >> previousStep [

	steps ifEmpty: [ ^ nil ].

	"Update the current step index"
	currentStepIndex > 1
		ifTrue: [ currentStepIndex := currentStepIndex - 1 ]
		ifFalse: [ ^ nil ].

	^ steps at: currentStepIndex
]

{ #category : #accessing }
CynHelpScript >> reset [

	steps ifEmpty: [ ^ self ].

	currentStepIndex := 1
]
