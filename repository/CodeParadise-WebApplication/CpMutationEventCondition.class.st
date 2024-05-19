Class {
	#name : 'CpMutationEventCondition',
	#superclass : 'CpEventCondition',
	#category : 'CodeParadise-WebApplication-Events-Custom',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Events-Custom'
}

{ #category : 'testing' }
CpMutationEventCondition class >> isAttributeFilter [

	^ false
]

{ #category : 'testing' }
CpMutationEventCondition class >> matches: anEvent [

	"Answer whether the specified event matches the receiver.
	For Mutation events, this should always be true. The actual conditions
	are defined while setting the event listener."

	^ anEvent class == CpMutationEvent
]

{ #category : 'accessing' }
CpMutationEventCondition class >> optionValueFromConditions: aCollection [

	"Answer the option value for the receiver, based on the specified conditions collection"

	self subclassResponsibility
]
