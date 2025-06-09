Class {
	#name : #CynClientCalculatedPropertySlot,
	#superclass : #CynClientPropertySlot,
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #accessing }
CynClientCalculatedPropertySlot class >> propertyCategory [

	^ #calculatedProperties
]

{ #category : #testing }
CynClientCalculatedPropertySlot >> isCalculated [

	^ true
]

{ #category : #accessing }
CynClientCalculatedPropertySlot >> read: anObject [

	^ anObject perform: name
]

{ #category : #accessing }
CynClientCalculatedPropertySlot >> write: aValue to: anObject [

	self error: 'Calculated properties can''t be written to'
]
