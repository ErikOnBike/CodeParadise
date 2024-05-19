"
I am a simple Server Application to show some DOM manipulation behavior.
I only live in the ServerEnvironment.
"
Class {
	#name : 'CpDomExamplesWebApplication',
	#superclass : 'CpWebApplication',
	#category : 'CodeParadise-WebApplication-Examples',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Examples'
}

{ #category : 'accessing' }
CpDomExamplesWebApplication class >> app [

	"Answer the unique identifier (a Symbol) for the receiver"

	^ #'DOM-Examples'
]

{ #category : 'accessing' }
CpDomExamplesWebApplication class >> clientBehaviorClass [

	^ CpDomExamplesClientBehavior
]
