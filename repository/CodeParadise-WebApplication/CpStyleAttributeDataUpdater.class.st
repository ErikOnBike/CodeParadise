Class {
	#name : #CpStyleAttributeDataUpdater,
	#superclass : #CpPrefixedAttributeDataUpdater,
	#category : #'CodeParadise-WebApplication-Support'
}

{ #category : #accessing }
CpStyleAttributeDataUpdater class >> prefix [

	^ 'style-'
]

{ #category : #rendering }
CpStyleAttributeDataUpdater >> renderData: anObject on: anElement [

	anElement styleAt: self name put: (self stringValueFromData: anObject)
]
