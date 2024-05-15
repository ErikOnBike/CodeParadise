Class {
	#name : 'CpFomanticExamplesWebApplication',
	#superclass : 'CpWebApplication',
	#category : 'CodeParadise-WebApplication-Fomantic-Examples',
	#package : 'CodeParadise-WebApplication-Fomantic',
	#tag : 'Examples'
}

{ #category : 'accessing' }
CpFomanticExamplesWebApplication class >> app [

	"Answer the unique identifier (a Symbol) for the receiver"

	^ #'Fomantic-Examples'
]

{ #category : 'accessing' }
CpFomanticExamplesWebApplication class >> clientBehaviorClass [

	^ CpFomanticExamplesClientBehavior
]

{ #category : 'installing' }
CpFomanticExamplesWebApplication >> installExtensionMethods [

	"Install the extension methods from known Classes"

	super installExtensionMethods.

	self installExtensionMethodsFor: #webApplicationFomanticExtension
]
