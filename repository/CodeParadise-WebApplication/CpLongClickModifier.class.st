Class {
	#name : #CpLongClickModifier,
	#superclass : #CpClickDurationModifier,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #testing }
CpLongClickModifier class >> isValidDuration: anInteger [

	"Answer whether the specified time (in milliseconds) is valid for the receiver"

	^ anInteger >= self minimalLongClickDuration
]
