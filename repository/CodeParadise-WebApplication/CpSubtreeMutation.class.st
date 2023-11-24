Class {
	#name : #CpSubtreeMutation,
	#superclass : #CpMutationEventCondition,
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #accessing }
CpSubtreeMutation class >> optionValueFromConditions: aCollection [

	^ aCollection includes: self
]
