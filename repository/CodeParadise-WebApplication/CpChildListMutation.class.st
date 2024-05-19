Class {
	#name : 'CpChildListMutation',
	#superclass : 'CpMutationEventCondition',
	#category : 'CodeParadise-WebApplication-Events-Custom',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Events-Custom'
}

{ #category : 'accessing' }
CpChildListMutation class >> optionValueFromConditions: aCollection [

	^ aCollection includes: self
]
