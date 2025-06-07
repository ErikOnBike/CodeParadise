Class {
	#name : #CynAbstractPropertySlot,
	#superclass : #Slot,
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #accessing }
CynAbstractPropertySlot class >> propertyCategory [

	| aCynAbstractPropertySlot |
	aCynAbstractPropertySlot := self new.

	aCynAbstractPropertySlot subclassResponsibility
]

{ #category : #accessing }
CynAbstractPropertySlot >> addPropertyTo: aCollection [

	aCollection
		add: self class propertyCategory -> name
]

{ #category : #accessing }
CynAbstractPropertySlot >> nameAndValueIn: anObject do: aBlock [

	aBlock value: name value: (self read: anObject)
]

{ #category : #accessing }
CynAbstractPropertySlot >> valueIn: anObject do: aBlock [

	aBlock value: (self read: anObject)
]
