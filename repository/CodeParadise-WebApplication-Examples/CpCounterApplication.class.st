"
I am a simple WebApplication based on Model-View-Presenter pattern.
I only live in the ServerEnvironment.
"
Class {
	#name : #CpCounterApplication,
	#superclass : #CpMvpWebApplication,
	#instVars : [
		'localCounter'
	],
	#classVars : [
		'GlobalCounter'
	],
	#category : #'CodeParadise-WebApplication-Examples-MVP'
}

{ #category : #accessing }
CpCounterApplication class >> app [

	^ #counter
]

{ #category : #accessing }
CpCounterApplication class >> globalCounter [

	^ GlobalCounter ifNil: [ GlobalCounter := CpCounterModel new ]
]

{ #category : #'class initialization' }
CpCounterApplication class >> release [

	GlobalCounter ifNotNil: [
		GlobalCounter release.
		GlobalCounter := nil ].

	super release
]

{ #category : #accessing }
CpCounterApplication >> applicationModel [

	"Answer the Model for the receiver, which is the receiver itself"

	^ self
]

{ #category : #accessing }
CpCounterApplication >> globalCounter [

	^ self class globalCounter
]

{ #category : #initialization }
CpCounterApplication >> initialize [

	super initialize.

	localCounter := CpCounterModel new
]

{ #category : #accessing }
CpCounterApplication >> localCounter [

	^ localCounter
]

{ #category : #accessing }
CpCounterApplication >> preferredPresenterClass [

	"Answer the preferred Presenter class for the content of the receiver.
	This will be used to display the receiver's content in the PagePresenter.
	(See also #applicationPresenterClass)"

	^ CpCounterApplicationPresenter
]
