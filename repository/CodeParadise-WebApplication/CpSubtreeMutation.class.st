Class {
	#name : 'CpSubtreeMutation',
	#superclass : 'CpMutationEventCondition',
	#category : 'CodeParadise-WebApplication-Events-Custom',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Events-Custom'
}

{ #category : 'accessing' }
CpSubtreeMutation class >> optionValueFromConditions: aCollection [

	^ aCollection includes: self
]
