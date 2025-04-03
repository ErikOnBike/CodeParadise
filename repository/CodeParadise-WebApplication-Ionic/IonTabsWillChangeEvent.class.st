Class {
	#name : #IonTabsWillChangeEvent,
	#superclass : #IonNamedEvent,
	#category : #'CodeParadise-WebApplication-Ionic-Events'
}

{ #category : #accessing }
IonTabsWillChangeEvent >> tab [

	"Answer the name of the tab selected"

	^ self detail
		at: #tab ifAbsent: [ nil ]
]
