Class {
	#name : #IonTabsDidChangeEvent,
	#superclass : #IonNamedEvent,
	#category : #'CodeParadise-WebApplication-Ionic-Events'
}

{ #category : #accessing }
IonTabsDidChangeEvent >> tab [

	"Answer the name of the tab selected"

	^ self detail
		at: #tab ifAbsent: [ nil ]
]
