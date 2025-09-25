Class {
	#name : #CpTextDataUpdater,
	#superclass : #CpDomDataUpdater,
	#category : #'CodeParadise-WebApplication-Support'
}

{ #category : #rendering }
CpTextDataUpdater >> renderData: anObject on: anElement [

	anElement textContent: (self stringValueFromData: anObject)
]
