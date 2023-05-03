Class {
	#name : #CpEventCondition,
	#superclass : #Object,
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #testing }
CpEventCondition class >> matches: anEvent [

	"Answer whether the receiver matches the specified Event.

	Implementation:
	The message #subclassResponsibility is not sent to prevent subclasses having to
	implement this method because it might be implemented as an instance side method."

	SubclassResponsibility signalFor: thisContext selector
]

{ #category : #accessing }
CpEventCondition class >> value: anEvent [

	"Answer a Boolean value representing whether the specified event matches the receiver"

	^ self matches: anEvent
]

{ #category : #testing }
CpEventCondition >> matches: anEvent [

	"Answer whether the receiver matches the specified Event.

	Implementation:
	The message #subclassResponsibility is not sent to prevent subclasses having to
	implement this method because it might be implemented as a class side method."

	SubclassResponsibility signalFor: thisContext selector
]

{ #category : #accessing }
CpEventCondition >> value: anEvent [

	"Answer a Boolean value representing whether the specified event matches the receiver"

	^ self matches: anEvent
]
