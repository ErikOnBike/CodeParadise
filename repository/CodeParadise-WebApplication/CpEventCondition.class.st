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

	self error: 'Subclass should implement #matches: class side in class ', self name
]

{ #category : #'logical operations' }
CpEventCondition class >> not [

	^ CpNegatedEventCondition condition: self
]

{ #category : #accessing }
CpEventCondition class >> value: anEvent [

	"Answer a Boolean value representing whether the specified event matches the receiver.
	This method is part of the default API to allow regular blocks to be used as conditions."

	^ self matches: anEvent
]

{ #category : #testing }
CpEventCondition >> matches: anEvent [

	"Answer whether the receiver matches the specified Event.

	Implementation:
	The message #subclassResponsibility is not sent to prevent subclasses having to
	implement this method because it might be implemented as a class side method."

	self error: 'Subclass should implement #matches: instance side in class ', self class name
]

{ #category : #'logical operations' }
CpEventCondition >> not [

	^ CpNegatedEventCondition condition: self
]

{ #category : #accessing }
CpEventCondition >> value: anEvent [

	"Answer a Boolean value representing whether the specified event matches the receiver.
	This method is part of the default API to allow regular blocks to be used as conditions."

	^ self matches: anEvent
]
