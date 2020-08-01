Class {
	#name : #CpFomanticExamplesServerApplication,
	#superclass : #CpWebApplication,
	#category : #'CodeParadise-WebApplication-Fomantic-Examples'
}

{ #category : #accessing }
CpFomanticExamplesServerApplication class >> app [

	"Answer the unique identifier (a Symbol) for the receiver"

	^ #'Fomantic-Examples'
]

{ #category : #accessing }
CpFomanticExamplesServerApplication class >> clientBehaviorClass [

	^ CpFomanticExamplesClientBehavior
]
