Class {
	#name : 'CpAttributeFilterMutation',
	#superclass : 'CpMutationEventCondition',
	#instVars : [
		'attributes'
	],
	#category : 'CodeParadise-WebApplication-Events-Custom',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Events-Custom'
}

{ #category : 'accessing' }
CpAttributeFilterMutation class >> attributes: aCollection [

	aCollection
		ifEmpty: [ self error: self name, ' only supports a non-empty list of attributes' ].

	^ self basicNew
		initializeWithAttributes: aCollection ;
		yourself
]

{ #category : 'accessing' }
CpAttributeFilterMutation class >> optionValueFromConditions: aCollection [

	"Answer an Array containing all the attributes being observed as option value"

	| allAttributes |

	allAttributes := OrderedCollection new: 0 streamContents: [ :stream |
		aCollection do: [ :each |
			each isAttributeFilter
				ifTrue: [ stream nextPutAll: each attributes ] ] ].

	^ allAttributes
		ifNotEmpty: [ allAttributes asArray ]
		ifEmpty: [ nil ]
]

{ #category : 'accessing' }
CpAttributeFilterMutation >> attributes [

	^ attributes asArray
]

{ #category : 'initialization' }
CpAttributeFilterMutation >> initializeWithAttributes: aCollection [

	self initialize.

	attributes := aCollection
]

{ #category : 'testing' }
CpAttributeFilterMutation >> isAttributeFilter [

	^ true
]

{ #category : 'testing' }
CpAttributeFilterMutation >> matches: anEvent [

	^ (self class matches: anEvent)
		and: [ anEvent mutationRecords anySatisfy: [ :each |
			"Check if the attributeName in the mutation record matches the receiver"
			(each at: #attributeName ifAbsent: [ nil ])
				ifNotNil: [ :attributeName | attributes includes: attributeName ]
				ifNil: [ false ] ] ]
]
