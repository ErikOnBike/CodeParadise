Class {
	#name : #CpFomanticExamplesWebApplication,
	#superclass : #CpWebApplication,
	#category : #'CodeParadise-WebApplication-Fomantic-Examples'
}

{ #category : #accessing }
CpFomanticExamplesWebApplication class >> app [

	"Answer the unique identifier (a Symbol) for the receiver"

	^ #'Fomantic-Examples'
]

{ #category : #accessing }
CpFomanticExamplesWebApplication class >> clientBehaviorClass [

	^ CpFomanticExamplesClientBehavior
]
