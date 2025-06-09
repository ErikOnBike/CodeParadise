Class {
	#name : #CynClientReadWritePropertySlot,
	#superclass : #CynClientPropertySlot,
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #accessing }
CynClientReadWritePropertySlot class >> propertyCategory [

	^ #readWriteProperties
]

{ #category : #accessing }
CynClientReadWritePropertySlot >> read: anObject [

	"Delegate reading to property getter"

	^ anObject rawAt: name
]

{ #category : #accessing }
CynClientReadWritePropertySlot >> write: aValue to: anObject [

	"Delegate writing to property setter"

	^ anObject rawAt: name put: aValue
]
