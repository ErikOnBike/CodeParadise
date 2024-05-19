Class {
	#name : 'CpAttributesMutation',
	#superclass : 'CpMutationEventCondition',
	#category : 'CodeParadise-WebApplication-Events-Custom',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Events-Custom'
}

{ #category : 'accessing' }
CpAttributesMutation class >> optionValueFromConditions: aCollection [

	^ (aCollection includes: self)
		or: [ (aCollection includes: CpAttributeOldValueMutation)
			or: [ aCollection anySatisfy: [ :each | each isAttributeFilter ] ] ]
]
