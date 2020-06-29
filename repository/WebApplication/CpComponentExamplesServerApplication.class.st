Class {
	#name : #CpComponentExamplesServerApplication,
	#superclass : #CpWebApplication,
	#category : #'WebApplication-Examples'
}

{ #category : #accessing }
CpComponentExamplesServerApplication class >> app [

	"Answer the unique identifier (a Symbol) for the receiver"

	^ #'Component-Examples'
]

{ #category : #actions }
CpComponentExamplesServerApplication >> load [

	"Load the client behavior in the ClientEnvironment"

	super load.

	self environment addClass: CpComponentExamplesClientBehavior.

	"Start the client behavior"
	self startClientBehavior
]

{ #category : #actions }
CpComponentExamplesServerApplication >> reload [

	"Start the client behavior"
	super reload.

	self startClientBehavior
]

{ #category : #actions }
CpComponentExamplesServerApplication >> startClientBehavior [

	"Start the client behavior by creating an instance of the class containing the behavior"
	self environment clientCreateInstanceOf: CpComponentExamplesClientBehavior withId: #client
]
