"
I am a simple Server Application to show some DOM manipulation behavior.
I only live in the ServerEnvironment.
"
Class {
	#name : #CpDomExamplesServerApplication,
	#superclass : #CpWebApplication,
	#category : #'CodeParadise-WebApplication-Examples'
}

{ #category : #accessing }
CpDomExamplesServerApplication class >> app [

	"Answer the unique identifier (a Symbol) for the receiver"

	^ #'DOM-Examples'
]

{ #category : #accessing }
CpDomExamplesServerApplication class >> clientBehaviorClass [

	^ CpDomExamplesClientBehavior
]
