Class {
	#name : #CpShoelaceExamplesWebApplication,
	#superclass : #CpWebApplication,
	#category : #'CodeParadise-WebApplication-Shoelace-Examples'
}

{ #category : #accessing }
CpShoelaceExamplesWebApplication class >> app [

	"Answer the unique identifier (a Symbol) for the receiver"

	^ #'Shoelace-Examples'
]

{ #category : #accessing }
CpShoelaceExamplesWebApplication class >> clientBehaviorClass [

	^ CpShoelaceExamplesClientBehavior
]

{ #category : #installing }
CpShoelaceExamplesWebApplication >> installExtensionMethods [

	"Install the extension methods from known Classes"

	super installExtensionMethods.

	self installExtensionMethodsFor: #webApplicationShoelaceExtension
]
