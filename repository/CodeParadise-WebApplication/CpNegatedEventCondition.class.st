Class {
	#name : 'CpNegatedEventCondition',
	#superclass : 'CpEventCondition',
	#instVars : [
		'condition'
	],
	#category : 'CodeParadise-WebApplication-Events-Custom',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Events-Custom'
}

{ #category : 'accessing' }
CpNegatedEventCondition class >> condition: anEventCondition [

	^ self basicNew
		initializeWithCondition: anEventCondition ;
		yourself
]

{ #category : 'initialization' }
CpNegatedEventCondition >> initializeWithCondition: anEventCondition [

	self initialize.

	condition := anEventCondition
]

{ #category : 'testing' }
CpNegatedEventCondition >> matches: anEvent [

	^ (condition value: anEvent) not
]

{ #category : 'logical operations' }
CpNegatedEventCondition >> not [

	"Answer a negated version of the receiver (i.e. the receiver's initial negated condition)"

	^ condition
]
