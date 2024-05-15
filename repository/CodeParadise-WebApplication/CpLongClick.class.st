Class {
	#name : 'CpLongClick',
	#superclass : 'CpAnyClickEventCondition',
	#category : 'CodeParadise-WebApplication-Events-Custom',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Events-Custom'
}

{ #category : 'testing' }
CpLongClick class >> matches: anEvent [

	^ anEvent duration >= self minimalLongClickDuration
]
