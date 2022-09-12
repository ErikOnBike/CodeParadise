Class {
	#name : #CpClickDurationModifier,
	#superclass : #Object,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #adding }
CpClickDurationModifier class >> addToClickAnnouncementClass: aClickAnnouncement [

	aClickAnnouncement setClickDurationModifier: self
]

{ #category : #testing }
CpClickDurationModifier class >> isValidDuration: anInteger [

	"Answer whether the specified time (in milliseconds) is valid for the receiver"

	self subclassResponsibility
]

{ #category : #accessing }
CpClickDurationModifier class >> minimalLongClickDuration [

	^ 500
]
