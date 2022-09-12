Class {
	#name : #CpShortClickModifier,
	#superclass : #CpClickDurationModifier,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #testing }
CpShortClickModifier class >> isValidDuration: anInteger [

	"Answer whether the specified time (in milliseconds) is valid for the receiver"

	^ anInteger < self minimalLongClickDuration
]
