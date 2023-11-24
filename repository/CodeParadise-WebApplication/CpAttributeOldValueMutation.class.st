Class {
	#name : #CpAttributeOldValueMutation,
	#superclass : #CpMutationEventCondition,
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #accessing }
CpAttributeOldValueMutation class >> optionValueFromConditions: aCollection [

	^ aCollection includes: self
]
