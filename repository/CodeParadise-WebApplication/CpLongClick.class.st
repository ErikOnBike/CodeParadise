Class {
	#name : #CpLongClick,
	#superclass : #CpAnyClickEventCondition,
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #testing }
CpLongClick class >> matches: anEvent [

	^ anEvent duration >= self minimalLongClickDuration
]
