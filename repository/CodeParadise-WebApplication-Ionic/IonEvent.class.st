Class {
	#name : #IonEvent,
	#superclass : #CpCustomEvent,
	#category : #'CodeParadise-WebApplication-Ionic-Events'
}

{ #category : #accessing }
IonEvent class >> type [

	"Answer the JavaScript type (a String) representing the receiver"

	^ (self nameWithoutPrefix withoutSuffix: #Event) uncapitalized
]
