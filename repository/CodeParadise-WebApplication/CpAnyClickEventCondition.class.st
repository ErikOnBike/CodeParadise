Class {
	#name : 'CpAnyClickEventCondition',
	#superclass : 'CpEventCondition',
	#category : 'CodeParadise-WebApplication-Events-Custom',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Events-Custom'
}

{ #category : 'accessing' }
CpAnyClickEventCondition class >> minimalLongClickDuration [

	"Answer the duration a long click should (at least) be (an Integer in milliseconds)"

	^ 500
]
