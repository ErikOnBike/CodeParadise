Class {
	#name : #CpClassedAttributeDataUpdater,
	#superclass : #CpPrefixedAttributeDataUpdater,
	#category : #'CodeParadise-WebApplication-Support'
}

{ #category : #accessing }
CpClassedAttributeDataUpdater class >> prefix [

	^ 'classed-'
]

{ #category : #rendering }
CpClassedAttributeDataUpdater >> renderData: anObject on: anElement [

	anElement classed: self name if: (self valueFromData: anObject)
]
