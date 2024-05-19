Class {
	#name : #CpUserInterfaceEvent,
	#superclass : #CpEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #accessing }
CpUserInterfaceEvent >> detail [

	"Answer the current (or next, depending on the event) click count"

	^ self propertyAt: #detail
]
