Class {
	#name : #CpPrimaryClickEvent,
	#superclass : #CpAnyClickEvent,
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #testing }
CpPrimaryClickEvent class >> handlesClickEvent: aClickEvent [

	"Accept only primary click"

	^ aClickEvent isPrimaryButtonPressed
]

{ #category : #testing }
CpPrimaryClickEvent >> isPrimaryButtonPressed [

	^ true
]

{ #category : #testing }
CpPrimaryClickEvent >> isSecondaryButtonPressed [

	^ false
]
