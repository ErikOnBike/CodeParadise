"
I am a simple Server Application to show some DOM manipulation behavior.
I only live in the ServerEnvironment.
"
Class {
	#name : #CpDomExamplesServerApplication,
	#superclass : #CpServerApplication,
	#category : #'WebApplication-Examples'
}

{ #category : #accessing }
CpDomExamplesServerApplication class >> app [

	"Answer the unique identifier (a Symbol) for the receiver"

	^ #'DOM-Examples'
]

{ #category : #actions }
CpDomExamplesServerApplication >> load [

	"Load the client behavior in the ClientEnvironment"

	super load.

	self environment addClass: CpDomExampleClientBehavior.

	"Start the client behavior"
	self startClientBehavior
]

{ #category : #actions }
CpDomExamplesServerApplication >> reload [

	"Start the client behavior"
	super reload.

	self startClientBehavior
]

{ #category : #actions }
CpDomExamplesServerApplication >> startClientBehavior [

	"Start the client behavior by creating an instance of the class containing the behavior"
	self environment clientCreateInstanceOf: CpDomExampleClientBehavior withId: #client
]
