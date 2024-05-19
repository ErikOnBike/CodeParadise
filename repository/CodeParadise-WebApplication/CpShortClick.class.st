Class {
	#name : 'CpShortClick',
	#superclass : 'CpAnyClickEventCondition',
	#category : 'CodeParadise-WebApplication-Events-Custom',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Events-Custom'
}

{ #category : 'testing' }
CpShortClick class >> matches: anEvent [

	^ anEvent duration < self minimalLongClickDuration
]
