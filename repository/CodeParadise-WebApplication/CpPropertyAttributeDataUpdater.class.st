Class {
	#name : #CpPropertyAttributeDataUpdater,
	#superclass : #CpPrefixedAttributeDataUpdater,
	#category : #'CodeParadise-WebApplication-Support'
}

{ #category : #accessing }
CpPropertyAttributeDataUpdater class >> prefix [

	^ 'property-'
]

{ #category : #rendering }
CpPropertyAttributeDataUpdater >> renderData: anObject on: anElement [

	anElement propertyAt: self name put: (self valueFromData: anObject)
]
