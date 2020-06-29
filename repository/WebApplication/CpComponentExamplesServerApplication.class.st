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

{ #category : #accessing }
CpComponentExamplesServerApplication class >> clientBehaviorClass [

	^ CpComponentExamplesClientBehavior
]
