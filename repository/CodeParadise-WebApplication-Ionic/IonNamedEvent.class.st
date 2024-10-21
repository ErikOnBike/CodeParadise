"
I am an Ion Event which receives the specific prefix 'ion' to prevent name clashes with default events.
"
Class {
	#name : #IonNamedEvent,
	#superclass : #IonEvent,
	#category : #'CodeParadise-WebApplication-Ionic-Events'
}

{ #category : #accessing }
IonNamedEvent class >> type [

	"Answer the JavaScript type (a String) representing the receiver"

	^ (self name withoutSuffix: #Event) uncapitalized
]
